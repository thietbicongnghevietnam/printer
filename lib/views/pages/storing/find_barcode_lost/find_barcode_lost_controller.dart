import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/barcode/barcode.dart';
import 'package:smart_warehouse/entities/barcode/local_barcode.dart';
import 'package:smart_warehouse/entities/barcode/oversea_barcode.dart';
import 'package:smart_warehouse/entities/barcode/pmd_barcode.dart';
import 'package:smart_warehouse/entities/barcode/simple_barcode.dart';
import 'package:smart_warehouse/entities/barcode/standard_barcode.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/entities/receiving_card_item.dart';
import 'package:smart_warehouse/repositories/barcode_repository.dart';
import 'package:smart_warehouse/repositories/inventory_repository.dart';
import 'package:smart_warehouse/repositories/master_repository.dart';
import 'package:smart_warehouse/repositories/receiving_card_repository.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/extensions/iterable_extensions.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';
import 'package:smart_warehouse/subsystem/printer/printer.dart';

import 'find_barcode_lost_state.dart';

@injectable
class FindBarcodeLostController extends BaseCubit<FindBarcodeLostState> {
  FindBarcodeLostController(
    this._masterRepository,
    this._barCodeRepository,
    this._receivingCardRepository,
  ) : super(FindBarcodeLostState());

  final MasterRepository _masterRepository;
  final BarCodeRepository _barCodeRepository;
  final ReceivingCardRepository _receivingCardRepository;

  PrinterDevice? savePrinterDevice;
  List<PrinterDevice>? printerDevices;

  @override
  Future<void> initData() async {
    try {
      launch(() async {
        final response = await _masterRepository.getPrinterDevices();
        printerDevices = response.$2;
        savePrinterDevice = _masterRepository.getPreviousPrinterDevice();
      });
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> scanReceivingCard(String value) async {
    if (value.isEmpty) {
      return;
    }

    try {
      launch(() async {
        if (value.isNotEmpty && value.contains(';')) {
          final receivingCardID = ReceivingCard.getReceivingCardID(value);

          final response =
              await _receivingCardRepository.getReceivingCard(receivingCardID);

          List<ReceivingCardItem> listOnRc = response.items;

          if (listOnRc.isEmpty) {
            throw ValidationError(
                type: ValidationErrorType.receivingCardNotHaveBox);
          }
          listOnRc.removeWhere((e) => e.currentQuantity == 0);

          emit(
            state.copyWith(
              receivingCard: response,
              listBoxAlive: response.items,
            ),
          );
        } else {
          throw ValidationError(type: ValidationErrorType.receivingCardInvalid);
        }
      });
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> scanBoxForRemove(String value) async {
    if (value.isEmpty) {
      return;
    }

    try {
      launch(() async {
        List<ReceivingCardItem> listBoxScanned = state.listBoxAlive.clone();

        final isOnList =
            listBoxScanned.firstWhereOrNull((e) => e.barcode == value);
        if (isOnList != null) {
          listBoxScanned.remove(isOnList);
        } else {
          throw ValidationError(type: ValidationErrorType.barcodeExisted);
        }
        emit(state.copyWith(listBoxAlive: listBoxScanned, activePage: 0));
      });
    } catch (e) {
      logger.e(e);
    }
  }

  void onChangePageOnRc(int active) {
    emit(state.copyWith(activePage: active));
  }

  Future<void> printBoxCards({
    required List<Barcode> barcodes,
    required PrinterDevice printerDevice,
  }) {
    return launch(() async {
      await getIt<Printer>().connect(printerDevice);
      await getIt<Printer>()
          .multiPrint(printerDevice, barcodes.map((e) => e.command).toList());
    });
  }

  void clearData() {
    emit(state.copyWith(activePage: 0, receivingCard: null));
  }
}
