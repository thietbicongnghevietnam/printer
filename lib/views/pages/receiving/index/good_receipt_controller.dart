import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/material_info.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/repositories/delivery_plan_repository.dart';
import 'package:smart_warehouse/repositories/master_repository.dart';
import 'package:smart_warehouse/repositories/receiving_card_repository.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';
import 'package:smart_warehouse/subsystem/printer/printer.dart';

abstract class GoodReceiptController<S extends BaseState> extends BaseCubit<S> {
  GoodReceiptController(
    super.initialState,
    this.receivingCardRepository,
    this.deliveryPlanRepository,
    this.masterRepository,
  );

  final DeliveryPlanRepository deliveryPlanRepository;
  final ReceivingCardRepository receivingCardRepository;
  final MasterRepository masterRepository;

  late ReceivingCard? receivingCard;
  List<PrinterDevice>? printerDevices;
  PrinterDevice? savedPrinterDevice;
  ReceivingCard? savedReceivingCard;
  MaterialInfo? materialInfo;
  bool isOffsetGoods = false;
  final printer = getIt<Printer>();

  @override
  Future<void> initData() async {
    final response = await masterRepository.getPrinterDevices();
    printerDevices = response.$2;
    savedPrinterDevice = masterRepository.getPreviousPrinterDevice();
  }

  Future<ReceivingCard> createReceivingCard({
    bool isPreview = false,
    bool useCurrentDate,
    bool samplingCheck,
    bool roshCheck,
  });

  Future<ReceivingCard> confirmPrintReceivingCard({
    required PrinterDevice printerDevice,
    required bool useCurrentDate,
    required bool samplingCheck,
    required bool roshCheck,
  }) {
    return launch(() async {
      await printer.connect(printerDevice);
      final receivingCard =
          await createReceivingCard(useCurrentDate: useCurrentDate);
      await printReceivingCard(
        receivingCard: receivingCard,
        printerDevice: printerDevice,
      );
      return receivingCard;
    });
  }

  Future<ReceivingCard> updateReceivingCard();

  Future<void> confirmUpdateReceivingCard({
    required PrinterDevice printerDevice,
  });

  Future<void> printReceivingCard({
    required ReceivingCard receivingCard,
    required PrinterDevice printerDevice,
  }) {
    return launch(() async {
      savedPrinterDevice = printerDevice;
      savedReceivingCard = receivingCard;
      await printer.print(printerDevice, receivingCard.command);
    });
  }

  Future<void> reprintReceivingCard() {
    return launch(() async {
      if (savedPrinterDevice == null || savedReceivingCard == null) {
        return;
      }

      await printer.connect(savedPrinterDevice.value());

      await printReceivingCard(
        receivingCard: savedReceivingCard.value(),
        printerDevice: savedPrinterDevice.value(),
      );
    });
  }

  Future<bool> checkHaveReceivingSchedule() {
    return launch(() => receivingCardRepository.checkHaveReceivingSchedule());
  }

  Future<void> clearData();
}
