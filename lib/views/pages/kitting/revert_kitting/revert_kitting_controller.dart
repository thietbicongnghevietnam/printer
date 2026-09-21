import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/kitting/kitting_card.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/repositories/kitting_repository.dart';
import 'package:smart_warehouse/repositories/master_repository.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/extensions/iterable_extensions.dart';
import 'package:smart_warehouse/subsystem/printer/printer.dart';
import 'package:smart_warehouse/views/pages/kitting/revert_kitting/revert_kitting_state.dart';

@injectable
class RevertKittingController extends BaseCubit<RevertKittingState> {
  RevertKittingController(this.kittingRepository, this.masterRepository)
      : super(RevertKittingState());

  final KittingRepository kittingRepository;

  final MasterRepository masterRepository;

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

  Future<void> scanKittingCard(String code) {
    return launch(() async {
      final kittingCardID = KittingCard.getKittingCardID(code);

      if (state.kittingCards.any((element) => element.id == kittingCardID)) {
        throw ValidationError(type: ValidationErrorType.kittingCardIsScanned);
      }

      final kittingCard = await kittingRepository.getKittingCard(kittingCardID);

      if (state.kittingCards.isNotEmpty) {
        if (state.kittingCards.first.material != kittingCard.material) {
          throw ValidationError(type: ValidationErrorType.materialNotSame);
        }

        if (state.kittingCards.first.sloc != kittingCard.sloc) {
          throw ValidationError(type: ValidationErrorType.slocNotSame);
        }
      }

      final newList = state.kittingCards.clone()..add(kittingCard);

      emit(state.copyWith(kittingCards: newList));
    });
  }

  void deleteKittingCard(KittingCard kittingCard) {
    final newList = state.kittingCards.clone()..remove(kittingCard);
    emit(state.copyWith(kittingCards: newList));
  }

  Future<ReceivingCard> revertKitting({bool isPreview = false}) {
    return launch(() async {
      return kittingRepository.revertKitting(
        barcodes: state.kittingCards.map((e) => e.barcode ?? '').toList(),
        isPreview: isPreview,
      );
    });
  }

  Future<void> confirmRevertKitting(PrinterDevice device) {
    return launch(() async {
      final printer = getIt<Printer>();
      await printer.connect(device);
      final receivingCard = await revertKitting();
      await printer.print(device, receivingCard.command);
    });
  }
}
