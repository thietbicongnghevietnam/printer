import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/barcode/barcode.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/entities/receiving_card_item.dart';
import 'package:smart_warehouse/enums/delivery_type.dart';
import 'package:smart_warehouse/repositories/master_repository.dart';
import 'package:smart_warehouse/repositories/material_repository.dart';
import 'package:smart_warehouse/repositories/receiving_card_repository.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';
import 'package:smart_warehouse/subsystem/printer/printer.dart';

import 'open_good_receipt_state.dart';

@injectable
class OpenGoodReceiptController extends BaseCubit<OpenGoodReceiptState> {
  OpenGoodReceiptController(
    this._receivingCardRepository,
    this._masterRepository,
    this._materialRepository,
  ) : super(OpenGoodReceiptState());

  final MaterialRepository _materialRepository;
  final ReceivingCardRepository _receivingCardRepository;
  final MasterRepository _masterRepository;

  @override
  Future<void> initData() {
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

  Future<void> _getMaterialInfo() async {
    if (state.receivingCard?.deliveryPlan?.type == DeliveryPlanType.orderPlan) {
      return;
    }

    final material = state.receivingCard?.material;
    final vendorCode = state.receivingCard?.vendorCode;
    final plant = state.receivingCard?.plant;
    final sloc = state.receivingCard?.sloc;

    final materialInfo = await _materialRepository.getMaterialInfo(
      material: material.value(),
      plant: plant.value(),
      sloc: sloc.value(),
      vendorCode: vendorCode.value(),
    );

    emit(state.copyWith(materialInfo: materialInfo));
  }

  Future<void> loadReceivingCard(String barcode) {
    return launch(() async {
      final receivingCardID = ReceivingCard.getReceivingCardID(barcode);
      final receivingCard = await _receivingCardRepository
          .getReceivingCard(receivingCardID.value());
      emit(state.copyWith(receivingCard: receivingCard));
      await _getMaterialInfo();
    });
  }

  Future<void> openReceivingCard() {
    return launch(() async {
      final receivingCard = state.receivingCard;
      if (receivingCard == null) {
        throw ValidationError(
          type: ValidationErrorType.openReceivingCardError,
        );
      }
    });
  }

  Future<ReceivingCard> cloneReceivingCard({
    required List<Barcode> barcodes,
    required String sloc,
    required int quantity,
    bool createBox = false,
    bool isPreview = false,
  }) {
    return launch(() async {
      final receivingCard = state.receivingCard;
      if (receivingCard == null) {
        throw ValidationError(
          type: ValidationErrorType.openReceivingCardError,
        );
      }

      return _receivingCardRepository.cloneReceivingCard(
        parentId: receivingCard.id.value(),
        quantity: quantity,
        box: barcodes.length,
        sloc: sloc,
        listMaterial: createBox
            ? barcodes.map((e) => ReceivingCardItem.fromBarcode(e)).toList()
            : null,
        isPreview: isPreview,
      );
    });
  }

  Future<ReceivingCard> confirmPrintReceivingCard({
    required List<Barcode> barcodes,
    required String sloc,
    required int quantity,
    bool createBox = false,
    required PrinterDevice printerDevice,
  }) {
    return launch(() async {
      await getIt<Printer>().connect(printerDevice);
      var receivingCard =
          await cloneReceivingCard(barcodes: barcodes, quantity :quantity, sloc: sloc);
      receivingCard = receivingCard.copyWith(
          items:
              barcodes.map((e) => ReceivingCardItem.fromBarcode(e)).toList());

      final commands = [receivingCard.command];
      if (createBox) {
        commands.addAll(barcodes.map((e) => e.command));
      }
      await getIt<Printer>().multiPrint(printerDevice, commands);
      return receivingCard;
    });
  }

  Future printBoxCards({
    required List<Barcode> barcodes,
    required PrinterDevice printerDevice,
  }) {
    return launch(() async {
      await getIt<Printer>().connect(printerDevice);
      await getIt<Printer>()
          .multiPrint(printerDevice, barcodes.map((e) => e.command).toList());
    });
  }

  Future<void> reprintReceivingCard({
    required ReceivingCard receivingCard,
    required PrinterDevice printerDevice,
  }) {
    return launch(() async {
      final printer = getIt<Printer>();
      await printer.connect(printerDevice);
      await printer.print(printerDevice, receivingCard.command);
    });
  }

  Future<void> revertReceivingCard() {
    return launch(() async {
      final receivingCard = state.receivingCard;
      if (receivingCard == null) {
        throw ValidationError(
          type: ValidationErrorType.openReceivingCardError,
        );
      }

      await _receivingCardRepository.revertReceivingCard(
        receivingCard.id.value(),
      );
      emit(state.copyWith(receivingCard: null));
    });
  }

  Future<void> reloadReceivingCard() {
    return launch(() async {
      final receivingCardId = state.receivingCard?.id;
      final receivingCard = await _receivingCardRepository
          .getReceivingCard(receivingCardId.value());
      emit(state.copyWith(receivingCard: receivingCard));
    });
  }

  Future<bool> checkHaveReceivingSchedule() {
    return launch(() => _receivingCardRepository.checkHaveReceivingSchedule());
  }
}
