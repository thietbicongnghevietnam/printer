import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/barcode/barcode.dart';
import 'package:smart_warehouse/entities/barcode/local_barcode.dart';
import 'package:smart_warehouse/entities/barcode/pmd_barcode.dart';
import 'package:smart_warehouse/entities/barcode/standard_barcode.dart';
import 'package:smart_warehouse/entities/delivery_plan.dart';
import 'package:smart_warehouse/entities/delivery_plan_detail.dart';
import 'package:smart_warehouse/entities/draft_receiving_card.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/entities/receiving_card_item.dart';
import 'package:smart_warehouse/enums/delivery_type.dart';
import 'package:smart_warehouse/enums/scan_type.dart';
import 'package:smart_warehouse/repositories/barcode_repository.dart';
import 'package:smart_warehouse/repositories/delivery_plan_repository.dart';
import 'package:smart_warehouse/repositories/master_repository.dart';
import 'package:smart_warehouse/repositories/material_repository.dart';
import 'package:smart_warehouse/repositories/receiving_card_repository.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/constants.dart';
import 'package:smart_warehouse/shared/extensions/iterable_extensions.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';
import 'package:smart_warehouse/subsystem/printer/printer.dart';
import 'package:smart_warehouse/views/pages/receiving/index/good_receipt_controller.dart';
import 'package:sprintf/sprintf.dart';

import 'gr_have_barcode_state.dart';

@injectable
class GRHaveBarcodeController
    extends GoodReceiptController<GRHaveBarcodeState> {
  GRHaveBarcodeController(
    ReceivingCardRepository receivingCardRepository,
    DeliveryPlanRepository deliveryPlanRepository,
    MasterRepository masterRepository,
    this._materialRepository,
    this._barCodeRepository,
  ) : super(
          GRHaveBarcodeState(),
          receivingCardRepository,
          deliveryPlanRepository,
          masterRepository,
        );

  final MaterialRepository _materialRepository;
  final BarCodeRepository _barCodeRepository;

  Barcode? newBarcode;

  @override
  Future<void> initData() {
    return launch(() async {
      await super.initData();

      emit(
        state.copyWith(
          draftReceivingCards: receivingCardRepository.getDraftReceivingCard(),
        ),
      );
      if (receivingCard != null) {
        final receivingCardItems = receivingCard?.items ?? [];
        final scanningItem = receivingCardItems.last;
        newBarcode = Barcode.fromBarcode(scanningItem.barcode);
        await receivingCard?.deliveryPlan.let((that) async {
          final newDeliveryPlan =
              await deliveryPlanRepository.getDeliveryPlanDetail(that);
          final deliveryPlanDetail = newDeliveryPlan.details.firstWhereOrNull(
            (element) => element.id == receivingCard?.daInvDetailId,
          );

          final scannedBarcode =
              await receivingCardRepository.getScannedBarcode(
            deliveryPlan: newDeliveryPlan,
            material: scanningItem.material,
            deliveryPlanDetail: deliveryPlanDetail,
            oldReceivingCard: receivingCard,
          );
          emit(
            state.copyWith(
              scannedItems: scannedBarcode,
              deliveryPlan: newDeliveryPlan,
              receivingCardItems: receivingCardItems,
              scanningItem: scanningItem,
              deliveryPlanDetail: deliveryPlanDetail,
            ),
          );
        });
      }
    });
  }

  Future<void> updateScanType([ScanType? scanType]) {
    return launch(() async {
      if (state.scanningItem != null) {
        throw ValidationError(type: ValidationErrorType.draftReceivingCard);
      }
      emit(state.copyWith(scanType: scanType ?? state.scanType.swap()));
    });
  }

  Future<void> _updateDeliveryPlan({
    DeliveryPlan? deliveryPlan,
    Barcode? barcode,
  }) async {
    final dp = deliveryPlan ?? barcode?.deliveryPlan;

    final checkSameDeliveryPlan = state.deliveryPlan?.compare(dp) ?? false;

    final newDeliveryPlan = checkSameDeliveryPlan
        ? state.deliveryPlan
        : await deliveryPlanRepository.getDeliveryPlanDetail(
            dp,
            barcode: barcode,
          );

    emit(state.copyWith(deliveryPlan: newDeliveryPlan));

    final detail =
        newDeliveryPlan?.getDeliveryPlanDetail(barcode: newBarcode.value());

    emit(state.copyWith(deliveryPlanDetail: detail));
  }


  //Tuấn Anh thêm
  Future<bool> checkexistsbarcodeinServer({ required String barcode}) async{
       final rs = await deliveryPlanRepository.checkexistBarcode(barcode: barcode);
       return rs;
  }





  Future<List<ReceivingCardItem>> _getScannedBarcode(
    DeliveryPlan deliveryPlan, [
    String? material,
  ]) async {
    final materialTmp = material ?? newBarcode?.material;
    final scannedBarcode = await receivingCardRepository.getScannedBarcode(
      deliveryPlan: deliveryPlan,
      deliveryPlanDetail: state.deliveryPlanDetail,
      orderPlanNumber: deliveryPlan.type == DeliveryPlanType.orderPlan
          ? deliveryPlan.no
          : null,
      material: materialTmp.value(),
    );
    emit(state.copyWith(scannedItems: scannedBarcode));
    return scannedBarcode;
  }

  Future<void> chooseDeliveryPlan(DeliveryPlan? deliveryPlan) {
    return launch(() async {
      await _updateDeliveryPlan(deliveryPlan: deliveryPlan);
      await _getScannedBarcode(deliveryPlan.value());
      _validateBarcode(newBarcode.value(), state.deliveryPlan);
      await _addBarcode(newBarcode.value());
    });
  }

  void chooseDeliveryPlanDetail([DeliveryPlanDetail? detail]) {
    emit(state.copyWith(deliveryPlanDetail: detail));
    _addBarcode(newBarcode.value());
  }

  Future<void> scanBarcode(String code) {
    return launch(() async {
      final barcode = Barcode.fromBarcode(code);

      // Tuấn Anh Thêm check barcode tồn tại trên server
      // bool rscheck = await checkexistsbarcodeinServer(barcode: code);
      //  if( rscheck && barcode is! StandardBarcode)  {
      //    throw ValidationError(type: ValidationErrorType.BarcodeExistsInServer);
      //  }
      //
      newBarcode = barcode;
      _validateBarcode(barcode);

      if (state.deliveryPlan == null) {
        await _updateDeliveryPlan(barcode: barcode);
        await _getScannedBarcode(state.deliveryPlan.value());
      }

      _validateBarcode(barcode, state.deliveryPlan);

      if (state.receivingCardItems.isEmpty) {
        final draftReceivingCard = await _checkExistDraftReceivingCard(barcode);

        if (draftReceivingCard != null) {
          await _restoreReceivingCard(draftReceivingCard);
        } else {
          await _addBarcode(barcode);
        }
      } else {
        await _addBarcode(barcode);
      }
    });
  }

  void _validateBarcode(Barcode barcode, [DeliveryPlan? deliveryPlan]) {
    if (deliveryPlan == null) {
      // Kiểm tra barcode có được hỗ trợ tính năng Scan By Lot không?
      final checkScanByLotSupported = state.scanType != ScanType.scanByLot ||
          Constants.globalCodeScanByLotListSupported.contains(
            barcode.as<LocalBarcode>()?.globalCode,
          );

      if (!checkScanByLotSupported) {
        throw ValidationError(
          type: ValidationErrorType.barcodeNotTypeScanByLot,
        );
      }

      // Kiểm tra mã của barcode có giống với mã đã quét trước đó
      final checkSameMaterial =
          state.scanningItem?.material == barcode.material;
      if (state.scanningItem != null && !checkSameMaterial) {
        throw ValidationError(type: ValidationErrorType.barcodeNotSame);
      }

      // Kiểm tra barcode đã được quét chưa?
      final checkExistInScannedList = state.scannedItems
          .any((element) => element.barcode == barcode.barcode);
      final checkSameKey = state.receivingCardItems
          .any((element) => element.partCard.key == barcode.key);

      if (barcode is! StandardBarcode && (checkSameKey || checkExistInScannedList)) {
        throw ValidationError(type: ValidationErrorType.barcodeScanned);
      }

      // Kiểm tra barcode có cùng Delivery Plan với barcode đã quét không
      if (barcode.deliveryPlan?.no != null &&
          state.deliveryPlan != null &&
          state.deliveryPlan?.no != barcode.deliveryPlan?.no) {
        throw ValidationError(type: ValidationErrorType.barcodeNotSame);
      }
    } else {
      final deliveryPlanDetail =
          deliveryPlan.getDeliveryPlanDetail(barcode: barcode);

      // Kiểm tra barcode đang quét có chung Plant và Sloc với barcode đã quét không
      if (barcode.po != null &&
          barcode.poItem != null &&
          state.deliveryPlanDetail != null) {
        if (deliveryPlanDetail.id != state.deliveryPlanDetail?.id) {
          throw ValidationError(type: ValidationErrorType.barcodeNotSame);
        }
      }

      // Kiểm tra barcode có đang tồn tại trong 1 receiving khác không
      if (barcode is! StandardBarcode) {
        final checkBarcodeExist = state.scannedItems
            .any((element) => element.barcode == barcode.barcode);

        if (checkBarcodeExist) {
          clearData();
          throw ValidationError(type: ValidationErrorType.barcodeExisted);
        }
      }


      final isDAInv = [
        DeliveryPlanType.dispatchAdvice,
        DeliveryPlanType.invoice,
      ].contains(deliveryPlan.type);

      if (isDAInv) {
        // Kiểm tra barcode có trong delivery plan hay không
        final item = state.deliveryPlan?.getDeliveryPlanItem(barcode: barcode);
        if (item == null) {
          throw ValidationError(
            type: ValidationErrorType.materialNotExistInDAInvoice,
          );
        }

        // Kiểm tra vượt quá PO
        if (barcode is HasPO) {
          final sumQuantitySamePO = state.receivingCardItems
              .where(
                (element) =>
            element.poNo == barcode.po &&
                element.poItem == barcode.poItem,
          )
              .sumBy((e) => e.totalQuantity ?? 0);
          if (item.poPendingQuantity != null &&
              item.poPendingQuantity! < sumQuantitySamePO + barcode.quantity) {
            if (state.receivingCardItems.isEmpty) {
              clearData();
            }

            throw ValidationError(type: ValidationErrorType.exceedPO, message: 'Số lượng vượt quá số lượng PO!\nSố lượng PO là: ${item.poPendingQuantity!}\nSố lượng đã nhận: ${sumQuantitySamePO + barcode.quantity}');
          }
        }

        // Kiểm tra vượt quá số lượng theo kế hoạch
        final totalQuantity = deliveryPlanDetail.totalQuantity;

        final exceedPlan =
            ((scannedQuantity ?? 0) + barcode.quantity) > totalQuantity;

        if (exceedPlan) {
          if (state.receivingCardItems.isEmpty) {
            clearData();
          }
          throw ValidationError(
            type: ValidationErrorType.receivingCardMoreQuantity,
          );
        }
      }
    }
  }

  Future<void> discardReceivingCard() {
    return launch(() async {
      await saveDraftReceivingCard();

      // Kiểm tra barcode mới có trong receiving card đã lưu hay không?
      final barcode = newBarcode.value<Barcode>();

      clearData(removeDeliveryPlan: false);
      await _updateDeliveryPlan(barcode: barcode);

      final draftReceivingCard = await _checkExistDraftReceivingCard(barcode);

      if (draftReceivingCard != null) {
        await _restoreReceivingCard(draftReceivingCard);
      } else {
        await _getScannedBarcode(state.deliveryPlan.value());
        _validateBarcode(barcode, state.deliveryPlan);
        await _addBarcode(barcode);
      }
    });
  }

  Future<void> saveDraftReceivingCard() {
    return launch(() async {
      final material = state.scanningItem?.material;

      if (material == null) {
        return;
      }

      final draftReceivingCards =
          receivingCardRepository.saveDraftReceivingCard(
        DraftReceivingCard(
          material: material,
          deliveryPlan: state.deliveryPlan.value(),
          barcodes: state.receivingCardItems.map((e) => e.barcode).toList(),
          deliveryPlanDetailId: state.deliveryPlanDetail?.id,
        ),
      );
      emit(state.copyWith(draftReceivingCards: draftReceivingCards));
    });
  }

  Future<void> _restoreReceivingCard(DraftReceivingCard draftReceivingCard) {
    return launch(() async {
      await saveDraftReceivingCard();

      receivingCardRepository.removeDraftReceivingCard(draftReceivingCard);

      await _getScannedBarcode(
        draftReceivingCard.deliveryPlan,
        draftReceivingCard.material,
      );

      draftReceivingCard.barcodes.removeWhere(
        (element) => state.scannedItems.any((e) => e.barcode == element),
      );

      final barcodes = draftReceivingCard.barcodes
          .map((e) => Barcode.fromBarcode(e))
          .toList();

      final receivingCardItems = barcodes.map((barcode) {
        return ReceivingCardItem.fromBarcode(barcode);
      }).toList();

      await _getMaterialInfo();

      emit(
        state.copyWith(
          scanningItem: receivingCardItems.lastOrNull,
          receivingCardItems: receivingCardItems,
        ),
      );

      // Nếu barcode không tồn tại trong danh sách Receiving Card được lưu thì thêm mới
      final checkBarcodeExistInDraftReceivingCard =
          draftReceivingCard.barcodes.contains(newBarcode?.barcode);
      if (!checkBarcodeExistInDraftReceivingCard && newBarcode != null) {
        draftReceivingCard.addBarcode(newBarcode!.barcode);
        await _addBarcode(newBarcode.value());
      }
    });
  }

  Future<void> clearDraftReceivingCard() {
    return launch(() async {
      receivingCardRepository.clearDraftReceivingCard();
      emit(state.copyWith(draftReceivingCards: []));
    });
  }

  Future<DraftReceivingCard?> _checkExistDraftReceivingCard(
    Barcode barcode,
  ) async {
    final checkSameDeliveryPlan =
        state.deliveryPlan?.compare(barcode.deliveryPlan) ?? false;

    final newDeliveryPlan = checkSameDeliveryPlan
        ? state.deliveryPlan
        : await deliveryPlanRepository.getDeliveryPlanDetail(
            barcode.deliveryPlan,
            barcode: barcode,
          );

    final deliveryPlanDetail =
        newDeliveryPlan?.getDeliveryPlanDetail(barcode: barcode);

    return receivingCardRepository
        .getDraftReceivingCard(
          material: barcode.material,
          deliveryPlan: newDeliveryPlan,
          deliveryPlanDetailId: deliveryPlanDetail?.id,
        )
        .singleOrNull;
  }

  Future<void> _getMaterialInfo() async {
    final material = newBarcode?.material;
    final vendorCode = state.deliveryPlan?.vendorCode;
    final detail = state.deliveryPlanDetail ??
        state.deliveryPlan?.getDeliveryPlanDetail(barcode: newBarcode.value());
    final plant = detail?.plant;
    final sloc = detail?.sloc;

    materialInfo = state.materialInfo ??
        await _materialRepository.getMaterialInfo(
          material: material.value(),
          plant: plant.value(),
          sloc: sloc.value(),
          vendorCode: vendorCode,
        );

    emit(state.copyWith(materialInfo: materialInfo));
  }

  Future<void> _addBarcode(Barcode barcode) async {
    final receivingCardItems = state.receivingCardItems.clone();

    var receivingCardItem = ReceivingCardItem.fromBarcode(barcode);

    // Lây số lượng thực tế của barcode PMD
    if (barcode is PMDBarcode) {
      final actualQuantity =
          await _barCodeRepository.getActualQuantityPMDBarcode(barcode.barcode);
      receivingCardItem = receivingCardItem.copyWith(quantity: actualQuantity);
    }

    // Scan by lot
    switch (state.scanType) {
      case ScanType.scanByBox:
        receivingCardItems.add(receivingCardItem);
      case ScanType.scanByLot:
        receivingCardItems.addAll(
          List.generate(
            barcode.box.value(),
            (index) => receivingCardItem.copyWith(unitNo: '${index + 1}'),
          ),
        );
    }

    await _getMaterialInfo();

    emit(
      state.copyWith(
        scanningItem: receivingCardItem,
        receivingCardItems: receivingCardItems,
      ),
    );
  }

  void updateQuantityBarcode(int index, int quantity) {
    final newList = state.receivingCardItems.clone();
    newList[index] = newList[index].copyWith(quantity: quantity);
    emit(state.copyWith(receivingCardItems: newList));
  }

  void removeBarcode(int index) {
    final newList = state.receivingCardItems.clone()..removeAt(index);
    if (newList.isEmpty) {
      clearData();
    }
    emit(state.copyWith(receivingCardItems: newList));
  }

  @override
  Future<ReceivingCard> createReceivingCard({
    bool isPreview = false,
    bool useCurrentDate = false,
    bool samplingCheck = false,
    bool roshCheck = false,
  }) {
    return launch(() async {
      _validateReceivingCard();

      final material = state.scanningItem?.material;

      final category = state.materialInfo?.category;

      var receivingCard = await receivingCardRepository.createReceivingCard(
        deliveryPlan: state.deliveryPlan.value(),
        material: material.value(),
        box: state.receivingCardItems.length,
        quantity: state.receivingCardItems.sumBy((e) => e.currentQuantity),
        deliveryPlanDetail: state.deliveryPlanDetail.value(),
        isPreview: isPreview,
        listMaterial: state.receivingCardItems,
        category: category,
        useCurrentDate: useCurrentDate,
      );
      receivingCard = receivingCard.copyWith(items: state.receivingCardItems);
      return receivingCard;
    });
  }

  @override
  Future<ReceivingCard> updateReceivingCard() {
    return launch(() async {
      _validateReceivingCard();

      final newRC = receivingCard?.copyWith(quantity: scannedQuantity);

      return newRC.value();
    });
  }

  @override
  Future<void> confirmUpdateReceivingCard({
    required PrinterDevice printerDevice,
  }) {
    return launch(() async {
      final receivingCard = this.receivingCard;
      if (receivingCard == null) {
        return;
      }

      await printer.connect(printerDevice);

      var newReceivingCard =
          await receivingCardRepository.updateReceivingCard(
        oldReceivingCard: receivingCard,
        deliveryPlan: state.deliveryPlan.value(),
        box: state.receivingCardItems.length,
        quantity: state.receivingCardItems.sumBy((e) => e.currentQuantity),
        listMaterial: state.receivingCardItems,
      );

      newReceivingCard = newReceivingCard.copyWith(items: state.receivingCardItems);

      await printReceivingCard(
        receivingCard: newReceivingCard,
        printerDevice: printerDevice,
      );
    });
  }

  void _validateReceivingCard() {
    if (state.receivingCardItems.isEmpty) {
      throw ValidationError(type: ValidationErrorType.receivingCardNull);
    }
  }

  int? get scannedBox {
    final scanningBox = state.receivingCardItems.length;
    final scannedBox = state.scannedItems.length;
    final sum = scanningBox + scannedBox;

    return sum > 0 && state.scanningItem != null ? sum : null;
  }

  int? get scannedQuantity {
    final scanningQuantity =
        state.receivingCardItems.sumBy((e) => e.currentQuantity);

    final scannedQuantity =
        state.scannedItems.sumBy((e) => e.totalQuantity ?? 0);

    return state.scanningItem != null
        ? scanningQuantity + scannedQuantity
        : null;
  }

  int? get totalQuantity => state.deliveryPlanDetail?.totalQuantity;

  @override
  Future<void> clearData({bool removeDeliveryPlan = true}) async {
    emit(
      state.copyWith(
        scanningItem: null,
        deliveryPlan: removeDeliveryPlan ? null : state.deliveryPlan,
        deliveryPlanDetail:
            removeDeliveryPlan ? null : state.deliveryPlanDetail,
        scannedItems: [],
        receivingCardItems: [],
        materialInfo: null,
      ),
    );
  }
}
