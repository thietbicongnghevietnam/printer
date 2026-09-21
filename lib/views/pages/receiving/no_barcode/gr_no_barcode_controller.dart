import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/barcode/barcode.dart';
import 'package:smart_warehouse/entities/barcode/box_card_barcode.dart';
import 'package:smart_warehouse/entities/delivery_plan.dart';
import 'package:smart_warehouse/entities/delivery_plan_detail.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/entities/receiving_card_item.dart';
import 'package:smart_warehouse/enums/delivery_type.dart';
import 'package:smart_warehouse/enums/storage_location.dart';
import 'package:smart_warehouse/repositories/delivery_plan_repository.dart';
import 'package:smart_warehouse/repositories/master_repository.dart';
import 'package:smart_warehouse/repositories/material_repository.dart';
import 'package:smart_warehouse/repositories/receiving_card_repository.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';
import 'package:smart_warehouse/subsystem/printer/printer.dart';
import 'package:smart_warehouse/views/pages/receiving/index/good_receipt_controller.dart';

import 'gr_no_barcode_state.dart';

@injectable
class GRNoBarcodeController extends GoodReceiptController<GRNoBarcodeState> {
  GRNoBarcodeController(
    ReceivingCardRepository receivingCardRepository,
    DeliveryPlanRepository deliveryPlanRepository,
    MasterRepository masterRepository,
    this._materialRepository,
  ) : super(
          GRNoBarcodeState(),
          receivingCardRepository,
          deliveryPlanRepository,
          masterRepository,
        );

  final MaterialRepository _materialRepository;
  late DeliveryPlan deliveryPlan;
  String? material;

  @override
  Future<void> initData() {
    return launch(() async {
      await super.initData();
      await updateDAInvoice(deliveryPlan);
      if (material != null) {
        updateItemByMaterial(material.value());
      }
      if (receivingCard != null) {
        final material = receivingCard?.material;
        final deliveryPlanItem = state.deliveryPlan?.details.firstWhereOrNull(
          (element) => element.material == material,
        );
        emit(
          state.copyWith(
            selectItem: deliveryPlanItem,
            quantity: receivingCard?.currentQuantity ?? 0,
            gredQuantity: deliveryPlanItem?.gredQuantity,
            totalQuantity: deliveryPlanItem?.totalQuantity,
            standardPacking: receivingCard?.box ?? 1,
          ),
        );
      }
    });
  }

  Future<void> scanBarcode(String barcode) {
    return launch(() async {
      final detail = state.deliveryPlan?.details
          .firstWhereOrNull((element) => barcode.contains(element.material));
      if (detail != null) {
        updateItem(detail);
      }
    });
  }

  Future<void> updateDAInvoice([DeliveryPlan? deliveryPlan]) {
    return launch(() async {
      final newDeliveryPlan = await deliveryPlanRepository
          .getDeliveryPlanDetail(deliveryPlan ?? state.deliveryPlan);

      emit(state.copyWith(deliveryPlan: newDeliveryPlan));
    });
  }

  void updateItemByMaterial(String material) {
    final selectedItem = state.deliveryPlan?.details
        .firstWhereOrNull((element) => element.material.contains(material));

    updateItem(selectedItem);
  }

  void updateIsPrintBoxCard(bool isPrintBoxCard) {
    emit(state.copyWith(isPrintBoxCard: isPrintBoxCard));
  }

  Future<void> updateItem(DeliveryPlanDetail? selectedItem) {
    return launch(() async {
      final totalQuantity = selectedItem?.totalQuantity ?? 0;
      final gredQuantity = selectedItem?.gredQuantity ?? 0;
      final suggestQuantity = totalQuantity - gredQuantity;

      emit(
        state.copyWith(
          selectItem: selectedItem,
          quantity: suggestQuantity,
          totalQuantity: totalQuantity,
          gredQuantity: gredQuantity,
        ),
      );
      updateBox();
      await _getMaterialInfo();
    });
  }

  void updateQuantity(int quantity) {
    emit(state.copyWith(quantity: quantity));
    updateBox();
  }

  void updateStandardPacking(int standardPacking) {
    emit(state.copyWith(standardPacking: standardPacking));
    updateBox();
  }

  void updateBox() {
    if (state.standardPacking == null || state.standardPacking == 0) {
      emit(state.copyWith(box: 0));
      return;
    }
    final totalBox = (state.quantity / state.standardPacking.value()).ceil();

    emit(state.copyWith(box: totalBox));
  }

  Future<void> _getMaterialInfo() async {
    if (state.deliveryPlan?.type == DeliveryPlanType.orderPlan) {
      return;
    }

    final material = state.selectItem?.material;
    final vendorCode = state.deliveryPlan?.vendorCode;
    final plant = state.selectItem?.plant;
    final sloc = state.selectItem?.sloc;

    materialInfo = await _materialRepository.getMaterialInfo(
      material: material.value(),
      plant: plant.value(),
      sloc: sloc.value(),
      vendorCode: vendorCode.value(),
    );

    emit(
      state.copyWith(
        materialInfo: materialInfo,
        standardPacking: materialInfo?.standardPacking,
      ),
    );
    updateBox();
  }

  void saveBoxCard(List<Barcode> barcodes) {
    emit(state.copyWith(
      barcodes: barcodes,
      box: barcodes.length,
      receivingCardItems:
          barcodes.map((e) => ReceivingCardItem.fromBarcode(e)).toList(),
    ));
  }

  Future<List<Barcode>> createBoxCard() {
    return launch(() async {
      if (state.standardPacking == null || state.standardPacking == 0) {
        throw ValidationError(type: ValidationErrorType.boxIsRequired);
      }

      if (state.barcodes.length == state.box &&
          state.barcodes.first.quantity == state.standardPacking) {
        return state.barcodes;
      }

      final detail = state.selectItem.value<DeliveryPlanDetail>();
      final surplusQuantity = state.quantity % (state.standardPacking ?? 1);

      final vendorResponse = await masterRepository.getVendors();

      final vendor = vendorResponse.$2
              .firstWhereOrNull(
                (element) =>
                    element.vendorCode == state.deliveryPlan?.vendorCode,
              )
              ?.vendorNameShort ??
          state.deliveryPlan?.vendorCode;

      final list = List.generate(
        state.box,
        (index) => BoxCardBarcode(
          material: detail.material,
          quantity: index == state.box - 1 && surplusQuantity != 0
              ? surplusQuantity
              : state.standardPacking ?? 0,
          unitNo: '${index + 1}',
          plant: detail.plant,
          sloc: detail.sloc,
          box: state.box,
          deliveryPlan: state.deliveryPlan,
          type: state.materialInfo?.type,
          frequency: state.materialInfo?.frequency,
          vendor: vendor,
        ),
      ).toList();
      emit(
        state.copyWith(
          barcodes: list,
          receivingCardItems:
              list.map((e) => ReceivingCardItem.fromBarcode(e)).toList(),
        ),
      );
      return list;
    });
  }

  @override
  Future<ReceivingCard> createReceivingCard({
    bool isPreview = false,
    bool useCurrentDate = false,
    bool samplingCheck = false,
    bool roshCheck = false,
  }) async {
    return launch(() async {
      _validateReceivingCard();
      final material = state.selectItem?.material;

      await createBoxCard();

      var receivingCard = await receivingCardRepository.createReceivingCard(
        deliveryPlan: deliveryPlan,
        material: material.value(),
        quantity: state.quantity,
        deliveryPlanDetail: state.selectItem.value(),
        isPreview: isPreview,
        useCurrentDate: useCurrentDate,
        listMaterial: state.materialInfo?.storageLocation != StorageLocation.smt
            ? state.receivingCardItems
            : null,
        box: state.box,
        isGiaoBu: isOffsetGoods,
        samplingCheck: isOffsetGoods ? samplingCheck : null,
        roshCheck: isOffsetGoods ? roshCheck : null,
      );

      receivingCard = receivingCard.copyWith(items: state.receivingCardItems);
      return receivingCard;
    });
  }

  @override
  Future<ReceivingCard> confirmPrintReceivingCard({
    required PrinterDevice printerDevice,
    required bool useCurrentDate,
    required bool samplingCheck,
    required bool roshCheck,
  }) {
    return launch(() async {
      final printer = getIt<Printer>();
      await printer.connect(printerDevice);
      var receivingCard = await createReceivingCard(
        useCurrentDate: useCurrentDate,
        samplingCheck: samplingCheck,
        roshCheck: roshCheck,
      );
      receivingCard = receivingCard.copyWith(items: state.receivingCardItems);

      savedPrinterDevice = printerDevice;
      savedReceivingCard = receivingCard;

      final commands = [receivingCard.command];

      if (state.materialInfo?.storageLocation != StorageLocation.smt &&
          state.isPrintBoxCard) {
        commands.addAll(state.barcodes.map((e) => e.command));
      }

      await printer.multiPrint(printerDevice, commands);
      return receivingCard;
    });
  }

  @override
  Future<void> reprintReceivingCard() {
    return launch(() async {
      final receivingCard = savedReceivingCard;
      if (savedPrinterDevice == null || receivingCard == null) {
        return;
      }

      await printer.connect(savedPrinterDevice.value());
      await printer.multiPrint(
        savedPrinterDevice.value(),
        [receivingCard.command, ...state.barcodes.map((e) => e.command)],
      );
    });
  }

  @override
  Future<ReceivingCard> updateReceivingCard() {
    return launch(() async {
      _validateReceivingCard();

      final newReceivingCard =
          receivingCard?.copyWith(quantity: state.quantity);

      return newReceivingCard.value();
    });
  }

  @override
  Future<void> confirmUpdateReceivingCard({
    required PrinterDevice printerDevice,
  }) {
    return launch(() async {
      if (receivingCard == null) {
        return;
      }

      await printer.connect(printerDevice);

      var newReceivingCard = await receivingCardRepository.updateReceivingCard(
        oldReceivingCard: receivingCard.value(),
        deliveryPlan: deliveryPlan,
        quantity: state.quantity,
        box: state.box,
        listMaterial: state.materialInfo?.storageLocation != StorageLocation.smt
            ? state.receivingCardItems
            : null,
      );

      newReceivingCard =
          newReceivingCard.copyWith(items: state.receivingCardItems);

      printReceivingCard(
        receivingCard: newReceivingCard,
        printerDevice: printerDevice,
      );
    });
  }

  void _validateReceivingCard() {
    final rcQuantity = receivingCard?.totalQuantity ?? 0;
    final gredQuantity = state.gredQuantity ?? 0;
    final totalQuantity = state.totalQuantity ?? 0;
    if (state.quantity + gredQuantity - rcQuantity > totalQuantity) {
      throw ValidationError(type: ValidationErrorType.inputMoreQuantity);
    }

    if (state.standardPacking == null || state.standardPacking == 0) {
      throw ValidationError(type: ValidationErrorType.boxIsRequired);
    }
  }

  @override
  Future<void> clearData() {
    return launch(() async {
      await updateDAInvoice(deliveryPlan);

      final newSelectedItem = state.deliveryPlan?.details.firstWhereOrNull(
        (element) =>
            element.material == state.selectItem?.material &&
            element.plant == state.selectItem?.plant &&
            element.sloc == state.selectItem?.sloc,
      );

      final gredQuantity = newSelectedItem?.gredQuantity ?? 0;
      final totalQuantity = newSelectedItem?.totalQuantity ?? 0;

      if (gredQuantity < totalQuantity) {
        emit(state.copyWith(standardPacking: null, box: 0, barcodes: []));
        updateItem(newSelectedItem ?? state.selectItem);
      } else {
        emit(
          state.copyWith(
            selectItem: null,
            quantity: 0,
            barcodes: [],
            totalQuantity: null,
            gredQuantity: null,
            standardPacking: null,
            materialInfo: null,
            box: 0,
          ),
        );
      }
    });
  }
}
