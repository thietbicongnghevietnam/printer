import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/barcode/barcode.dart';
import 'package:smart_warehouse/entities/kitting/kitting_card.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/repositories/kitting_repository.dart';
import 'package:smart_warehouse/repositories/master_repository.dart';
import 'package:smart_warehouse/repositories/receiving_card_repository.dart';
import 'package:smart_warehouse/repositories/storing_repository.dart';
import 'package:smart_warehouse/services/models/response/plant_type_freqquency_response_model.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/extensions/iterable_extensions.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';
import 'package:smart_warehouse/subsystem/printer/printer.dart';
import 'package:smart_warehouse/views/pages/kitting/return_kitting/return_kitting_page.dart';
import 'package:smart_warehouse/views/pages/kitting/return_kitting/return_kitting_state.dart';

@injectable
class ReturnKittingController extends BaseCubit<ReturnKittingState> {
  ReturnKittingController(
    this.kittingRepository,
    this.storingRepository,
    this.receivingCardRepository,
    this.masterRepository,
  ) : super(ReturnKittingState());

  final KittingRepository kittingRepository;
  final StoringRepository storingRepository;
  final ReceivingCardRepository receivingCardRepository;

  final MasterRepository masterRepository;
  List<PlantTypeFrequencyResponseModel>? resPlant;

  @override
  Future<void> initData() async {
    final response = await masterRepository.getPrinterDevices();
    emit(
      state.copyWith(
        printerDevices: response.$2,
        savePrinterDevice: masterRepository.getPreviousPrinterDevice(),
      ),
    );
  }

  void updateReturnKittingType(ReturnKittingType? type) {
    emit(state.copyWith(returnKittingType: type ?? ReturnKittingType.inPlan));
  }

  Future<void> scan(String code) async {
    if (state.returnKittingType == ReturnKittingType.outPlan) {
      await _scanMaterial(code);
    } else {
      await _scanKittingCard(code);
    }
  }

  Future<void> _scanKittingCard(String code) {
    return launch(() async {
      final kittingCardID = KittingCard.getKittingCardID(code);

      if (state.kittingCards.any((element) => element.id == kittingCardID)) {
        throw ValidationError(type: ValidationErrorType.kittingCardIsScanned);
      }

      final kittingCard = await kittingRepository.getKittingCard(kittingCardID);

      if (kittingCard.status == 3) {
        throw ValidationError(type: ValidationErrorType.kittingCardIsScanned);
      }

      if (state.material != null) {
        if (state.material != kittingCard.material) {
          throw ValidationError(type: ValidationErrorType.materialNotSame);
        }

        if (state.sloc != kittingCard.receiptSloc) {
          throw ValidationError(type: ValidationErrorType.slocNotSame);
        }
      }

      final newList = state.kittingCards.clone()..add(kittingCard);


      emit(
        state.copyWith(
          kittingCards: newList,
          material: kittingCard.material,
          sloc: kittingCard.receiptSloc,
          plant: kittingCard.plant,
          category: kittingCard.category,
          quantity: newList.sumBy((e) => e.quantity?.toInt() ?? 0),
        ),
      );
    });
  }

  Future<void> _scanMaterial(String code) {
    return launch(() async {
      if (Barcode.validate(code)) {
       final barcode = Barcode.fromBarcode(code);

       await updateMaterial(barcode.material);
      }
    });
  }

  void deleteKittingCard(KittingCard kittingCard) {
    final newList = state.kittingCards.clone()..remove(kittingCard);
    emit(state.copyWith(kittingCards: newList));
  }

  void updateQuantity(int quantity) {
    emit(state.copyWith(quantity: quantity));
  }

  Future<void> updateMaterial(String material) {
    return launch(() async {
      resPlant = await storingRepository.getAllPlanSlocFromMaterial(
        material: material,
      );

      final listPlants =
          resPlant?.map((e) => e.plant ?? '').toSet().toList() ?? [];

      emit(
        state.copyWith(
          material: material,
          listPlants: listPlants,
          listSlocs: [],
          listCategories: [],
        ),
      );
      if (listPlants.length == 1) {
        await updatePlant(listPlants.single);
      }
    });
  }

  Future<void> updatePlant(String plant) {
    return launch(() async {
      final listSloc = resPlant
              ?.firstWhere((element) => element.plant == plant)
              .slocs
              ?.map((e) => e.sloc ?? '')
              .toList() ??
          [];

      emit(
        state.copyWith(plant: plant, listSlocs: listSloc, listCategories: []),
      );
      if (listSloc.length == 1) {
        await updateSloc(listSloc.single);
      }
    });
  }

  Future<void> updateSloc(String sloc) {
    return launch(() async {
      final listCategories = resPlant
              ?.firstWhere((element) => element.plant == state.plant)
              .slocs
              ?.firstWhere((element) => element.sloc == sloc)
              .category ??
          [];
      emit(state.copyWith(sloc: sloc, listCategories: listCategories));
      if (listCategories.length == 1) {
        await updateCategory(listCategories.single);
      }
    });
  }

  Future<void> updateCategory(String category) {
    return launch(() async {
      emit(state.copyWith(category: category));
      await returnKitting(isPreview: true);
    });
  }

  Future<ReceivingCard> returnKitting({bool isPreview = false}) {
    return launch(() async {
      var rc = await kittingRepository.returnKitting(
        barcodes: state.kittingCards.map((e) => e.id.toString()).toList(),
        returnKittingType: state.returnKittingType,
        quantity: state.quantity,
        isPreview: isPreview,
        material: state.material?.toUpperCase() ?? '',
        plant: state.plant ?? '',
        sloc: state.sloc ?? '',
        category: state.category ?? '',
      );

      if (rc == null) {
        throw ValidationError(type: ValidationErrorType.firstLotNotExist);
      }

      rc = rc.copyWith(stockQuantity: state.quantity, quantity: state.quantity);

      emit(state.copyWith(receivingCard: rc));

      return rc;
    });
  }

  Future<void> confirmReturnKitting(PrinterDevice device) {
    return launch(() async {
      final printer = getIt<Printer>();
      await printer.connect(device);
      final receivingCard = await returnKitting();
      await printer.print(device, receivingCard.command);
    });
  }

  void clearData() {
    emit(ReturnKittingState(returnKittingType: state.returnKittingType));
  }
}
