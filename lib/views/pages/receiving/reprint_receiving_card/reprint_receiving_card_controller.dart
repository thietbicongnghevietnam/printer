import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/barcode/barcode.dart';
import 'package:smart_warehouse/repositories/master_repository.dart';
import 'package:smart_warehouse/repositories/receiving_card_repository.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/subsystem/printer/printer.dart';

import 'reprint_receiving_card_state.dart';

@injectable
class ReprintReceivingCardController
    extends BaseCubit<ReprintReceivingCardState> {
  ReprintReceivingCardController(
    this._receivingCardRepository,
    this._masterRepository,
  ) : super(ReprintReceivingCardState());

  final ReceivingCardRepository _receivingCardRepository;
  final MasterRepository _masterRepository;

  String _savedBarcode = '';

  @override
  Future<void> initData() async {
    return launch(() async {
      final printerDevices = await _masterRepository.getPrinterDevices();
      final selectedPrinterDevice =
          _masterRepository.getPreviousPrinterDevice();

      emit(
        state.copyWith(
          printerDevices: printerDevices.$2,
          selectedPrinterDevice: selectedPrinterDevice,
        ),
      );
    });
  }

  Future<void> loadReceivingCard(String barcode) {
    return launch(() async {
      _savedBarcode = barcode;
      final card = Barcode.fromBarcode(barcode);
      final response = await _receivingCardRepository.searchReceivingCards(
          barcode: barcode, material: card.material);
      if (response.isEmpty) {
        throw ValidationError(type: ValidationErrorType.receivingCardNotExist);
      }
      emit(state.copyWith(receivingCard: response));
    });
  }

  void changePrinterDevice(PrinterDevice? printerDevice) {
    emit(state.copyWith(selectedPrinterDevice: printerDevice));
  }

  Future<void> printReceivingCard(int index) {
    return launch(() async {
      if (state.receivingCard.isEmpty) {
        throw ValidationError(type: ValidationErrorType.receivingCardNull);
      }

      final device = state.selectedPrinterDevice;
      if (device == null) {
        throw ValidationError(type: ValidationErrorType.connectPrinterError);
      }

      final printer = getIt<Printer>();
      await printer.connect(device);
      await printer.print(device, state.receivingCard[index].command);
    });
  }

  Future<void> revertReceivingCard(int index) {
    return launch(() async {
      if (state.receivingCard.isEmpty || index >= state.receivingCard.length) {
        throw ValidationError(
          type: ValidationErrorType.openReceivingCardError,
        );
      }

      final receivingCard = state.receivingCard[index];

      await _receivingCardRepository.revertReceivingCard(
        receivingCard.id,
      );
      emit(state.copyWith(receivingCard: []));
    });
  }

  Future<void> reloadReceivingCard() async {
    return launch(() async {
      return loadReceivingCard(_savedBarcode);
    });
  }
}
