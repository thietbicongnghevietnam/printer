import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/delivery_plan.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/enums/receving_card_type.dart';
import 'package:smart_warehouse/repositories/master_repository.dart';
import 'package:smart_warehouse/repositories/receiving_card_repository.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/subsystem/printer/printer.dart';

import 'reprint_rc_convert_state.dart';

@injectable
class RePrintRcConvertController extends BaseCubit<RePrintRcConvertState> {
  RePrintRcConvertController(
    this._receivingCardRepository,
    this._masterRepository,
  ) : super(RePrintRcConvertState());

  final ReceivingCardRepository _receivingCardRepository;
  final MasterRepository _masterRepository;
  String stockBarcode = '';

  @override
  Future<void> initData() {
    return launch(() async {
      final receivingCard =
          await _receivingCardRepository.getRCConvertByStock(stockBarcode);

      final printerDevices = await _masterRepository.getPrinterDevices();
      final selectedPrinterDevice =
          _masterRepository.getPreviousPrinterDevice();

      emit(
        state.copyWith(
          receivingCard: receivingCard,
          printerDevices: printerDevices.$2,
          selectedPrinterDevice: selectedPrinterDevice,
        ),
      );
    });
  }

  void changePrinterDevice(PrinterDevice? printerDevice) {
    emit(state.copyWith(selectedPrinterDevice: printerDevice));
  }

  Future<void> printReceivingCard() {
    return launch(() async {
      if (state.receivingCard == null) {
        throw ValidationError(type: ValidationErrorType.receivingCardNull);
      }

      final device = state.selectedPrinterDevice;
      if (device == null) {
        throw ValidationError(type: ValidationErrorType.connectPrinterError);
      }

      ReceivingCard? rcConvert = state.receivingCard;
      rcConvert =
          rcConvert?.copyWith(rcCurrentType: ReceivingCardPrinterType.rcConvert);

      final printer = getIt<Printer>();
      await printer.connect(device);
      await printer.print(device, rcConvert!.command);
    });
  }
}
