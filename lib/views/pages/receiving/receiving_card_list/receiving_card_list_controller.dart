import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/delivery_plan.dart';
import 'package:smart_warehouse/repositories/master_repository.dart';
import 'package:smart_warehouse/repositories/receiving_card_repository.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/subsystem/printer/printer.dart';

import 'receiving_card_list_state.dart';

@injectable
class ReceivingCardListController extends BaseCubit<ReceivingCardListState> {
  ReceivingCardListController(
    this._receivingCardRepository,
    this._masterRepository,
  ) : super(ReceivingCardListState());

  final ReceivingCardRepository _receivingCardRepository;
  final MasterRepository _masterRepository;
  DeliveryPlan? deliveryPlan;
  String? material;
  int? parentId;

  @override
  Future<void> initData() {
    return launch(() async {
      final receivingCards =
          await _receivingCardRepository.searchReceivingCards(
        deliveryPlan: deliveryPlan,
        material: material,
        parentId: parentId,
      );

      final printerDevices = await _masterRepository.getPrinterDevices();
      final selectedPrinterDevice =
          _masterRepository.getPreviousPrinterDevice();

      emit(
        state.copyWith(
          receivingCards: receivingCards,
          printerDevices: printerDevices.$2,
          selectedPrinterDevice: selectedPrinterDevice,
        ),
      );
    });
  }

  void changePrinterDevice(PrinterDevice? printerDevice) {
    emit(state.copyWith(selectedPrinterDevice: printerDevice));
  }

  Future<void> printReceivingCard(int index) {
    return launch(() async {
      if (state.receivingCards.isEmpty) {
        throw ValidationError(type: ValidationErrorType.receivingCardNull);
      }

      final device = state.selectedPrinterDevice;
      if (device == null) {
        throw ValidationError(type: ValidationErrorType.connectPrinterError);
      }

      final printer = getIt<Printer>();
      await printer.connect(device);
      await printer.print(device, state.receivingCards[index].command);
    });
  }
}
