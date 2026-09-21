import 'package:collection/collection.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/entities/barcode/barcode.dart';
import 'package:smart_warehouse/entities/barcode/standard_barcode.dart';
import 'package:smart_warehouse/entities/delivery_plan.dart';
import 'package:smart_warehouse/entities/delivery_plan_detail.dart';
import 'package:smart_warehouse/entities/draft_receiving_card.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/entities/receiving_card_item.dart';
import 'package:smart_warehouse/entities/storage_card.dart';
import 'package:smart_warehouse/entities/storing/qty_qc_history.dart';
import 'package:smart_warehouse/enums/delivery_type.dart';
import 'package:smart_warehouse/enums/receiving_card_reason.dart';
import 'package:smart_warehouse/services/api_service.dart';
import 'package:smart_warehouse/services/models/request/clone_receiving_card_request_model.dart';
import 'package:smart_warehouse/services/models/request/create_receiving_card_request_model.dart';
import 'package:smart_warehouse/services/models/request/qc_borrow_rc_request_model.dart';
import 'package:smart_warehouse/services/models/request/split_receiving_card_request_model.dart';
import 'package:smart_warehouse/services/models/request/update_receiving_card_request_model.dart';
import 'package:smart_warehouse/services/models/response/result_receiving_qc.dart';
import 'package:smart_warehouse/services/translators/qty_qc_history_tranlator.dart';
import 'package:smart_warehouse/services/translators/receiving_card_translator.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/extensions/iterable_extensions.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';

@injectable
class ReceivingCardRepository {
  ReceivingCardRepository(this._apiService);

  final ApiService _apiService;
  final box = Hive.box<DraftReceivingCard>('draft_receiving_card');

  Future<List<ReceivingCard>> searchReceivingCards({
    DeliveryPlan? deliveryPlan,
    String? material,
    String? barcode,
    String? pallet,
    int? parentId,
    String? planOrderNumber,
  }) async {
    final response = await _apiService.searchReceivingCard(
      material: material,
      daInvType: deliveryPlan?.type.code,
      daInvId: deliveryPlan?.id,
      barcode: barcode,
      pallet: pallet,
      parentID: parentId,
      planOrderNumber: planOrderNumber,
    );
    return response.map((e) => e.toEntity()).where((element) => element.currentQuantity != 0).toList();
  }
  //
  Future<List<ReceivingCard>> searchReceivingCardsTA({
    DeliveryPlan? deliveryPlan,
    String? material,
    String? barcode,
    String? pallet,
    int? parentId,
    String? planOrderNumber,
  }) async {
    final response = await _apiService.searchReceivingCardTA(
      material: material,
      daInvType: deliveryPlan?.type.code,
      daInvId: deliveryPlan?.id,
      barcode: barcode,
      pallet: pallet,
      parentID: parentId,
      planOrderNumber: planOrderNumber,
    );
    return response.map((e) => e.toEntity()).where((element) => element.currentQuantity != 0).toList();
  }


  Future<List<ReceivingCardItem>> searchReceivingCardDetails(
      String barcode) async {
    final response = await _apiService.searchReceivingCardDetailsByBarcode(
      barcode: barcode,
    );

    return response.map((e) => e.toEntity()).toList();
  }

  Future<List<ReceivingCardItem>> getScannedBarcode({
    ReceivingCard? oldReceivingCard,
    required DeliveryPlan deliveryPlan,
    DeliveryPlanDetail? deliveryPlanDetail,
    required String material,
    String? orderPlanNumber,
  }) async {
    final receivingCards = await searchReceivingCards(
      deliveryPlan: deliveryPlan,
      material: material.value(),
      planOrderNumber: deliveryPlan.type == DeliveryPlanType.orderPlan
          ? deliveryPlanDetail?.items.firstOrNull?.poNo
          : null,
    );

    receivingCards.removeWhere(
      (element) => element.daInvDetailId != deliveryPlanDetail?.id,
    );

    final scannedItems =
        receivingCards.expand((element) => element.items).toList();
    oldReceivingCard?.items.forEach((receivingCardItem) {
      scannedItems.removeWhere(
        (element) => element.barcode == receivingCardItem.barcode,
      );
    });

    return scannedItems;
  }

  Future<ReceivingCard> getReceivingCard(int id) async {
    final response = await _apiService.getReceivingCard(id);
    return response.toEntity();
  }

  Future<ReceivingCard> getRCConvertByStock(String barcodeStock) async {
    final response = await _apiService.getRCConvertByStock(barcodeStock);
    return response.toEntity();
  }

  Future<void> confirmReceivingCard({required int id}) async {
    _apiService.confirmReceivingCard(id);
  }

  Future<ReceivingCard> createReceivingCard({
    required DeliveryPlan deliveryPlan,
    required String material,
    required int quantity,
    required int box,
    String? category,
    required DeliveryPlanDetail deliveryPlanDetail,
    List<ReceivingCardItem>? listMaterial,
    ReceivingCardReason? reason,
    bool isPreview = false,
    bool useCurrentDate = false,
    bool isGiaoBu = false,
    bool? samplingCheck,
    bool? roshCheck,
  }) async {
    final type = deliveryPlan.type.code;
    final deliveryPlanItemId = deliveryPlanDetail.id;

    final request = CreateReceivingCardRequestModel(
      quantity: quantity,
      deliveryPlanType: type.value(),
      daInvDetailId: deliveryPlanItemId.value(),
      material: material,
      category: category,
      isPreview: isPreview,
      listMaterial: listMaterial?.map((e) => e.toRequestModel()).toList(),
      reason: reason?.name,
      isDatePrint: useCurrentDate,
      box: box,
      isGB: isGiaoBu,
      samplingCheck: samplingCheck,
      roshCheck: roshCheck,
    );
    final response = await _apiService.createReceivingCard(request);
    return response.toEntity();
  }

  Future<ReceivingCard> updateReceivingCard({
    required ReceivingCard oldReceivingCard,
    required DeliveryPlan deliveryPlan,
    required int quantity,
    required int box,
    List<ReceivingCardItem>? listMaterial,
  }) async {
    final receivingCardDetails =
        listMaterial?.map((e) => e.toRequestModel()).toList();
    final listIdDetailDelete = oldReceivingCard.items
        .map((e) => e.id)
        .leftOuterJoin(listMaterial?.map((e) => e.id) ?? []);
    final request = UpdateReceivingCardRequestModel(
      oldReceivingCard.id.value(),
      quantity,
      box,
      listIdDetailDelete,
      receivingCardDetails,
    );
    final response = await _apiService.updateReceivingCard(request);
    return response.toEntity();
  }

  Future<void> revertReceivingCard(int id) {
    return _apiService.revertReceivingCard(id);
  }

  Future<ReceivingCard> cloneReceivingCard({
    required int parentId,
    required int quantity,
    required int box,
    required String sloc,
    List<ReceivingCardItem>? listMaterial,
    bool isPreview = false,
  }) async {
    final request = CloneReceivingCardRequestModel(
      parentId: parentId,
      quantity: quantity,
      box: box,
      sloc: sloc,
      isPreview: isPreview,
      listMaterial: listMaterial?.map((e) => e.toRequestModel()).toList(),
    );
    final response = await _apiService.cloneReceivingCard(request);
    return response.toEntity();
  }

  Future<void> confirmCloneReceivingCard({
    required int parentId,
    required int id,
    int status = 0,
  }) {
    return _apiService.confirmCloneReceivingCard(parentId, id, status);
  }

  Future<bool> checkHaveReceivingSchedule() async {
    final response = await _apiService.getReceivingSchedule();

    return response.isBlock;
  }

  List<DraftReceivingCard> saveDraftReceivingCard(
    DraftReceivingCard receivingCard,
  ) {
    box.put(receivingCard.key, receivingCard);

    return box.values.toList();
  }

  List<DraftReceivingCard> removeDraftReceivingCard(
    DraftReceivingCard draftReceivingCard,
  ) {
    box.delete(draftReceivingCard.key);
    return box.values.toList();
  }

  List<DraftReceivingCard> getDraftReceivingCard({
    String? material,
    DeliveryPlan? deliveryPlan,
    int? deliveryPlanDetailId,
  }) {
    final list = box.values.toList();

    if (material != null) {
      list.removeWhere((element) => element.material != material);
    }
    ;

    if (deliveryPlan != null) {
      list.removeWhere(
        (element) =>
            element.deliveryPlan.id != deliveryPlan.id ||
            element.deliveryPlan.type != deliveryPlan.type,
      );
    }

    if (deliveryPlanDetailId != null) {
      list.removeWhere(
        (element) => element.deliveryPlanDetailId != deliveryPlanDetailId,
      );
    }

    return list;
  }

  Future<ResultReceivingQCResponsesModel?> receivingCardRcCheck({
    required int receivingCardId,
  }) async {
    return _apiService.receivingCardRcCheck(receivingCardId);
  }

  Future<StorageCard> getStorageCard(String barcode, bool isSub) async {
    if (!ReceivingCard.validate(barcode) && !Barcode.validate(barcode)) {
      throw ValidationError(type: ValidationErrorType.barcodeInvalid);
    }

    if (Barcode.validate(barcode)) {
      if (isSub) {
        throw ValidationError(type: ValidationErrorType.receivingCardInvalid);
      }


      // Tuấn Anh check truong hop trung barcode
      if (StandardBarcode.validate(barcode)) {
        throw ValidationError(type: ValidationErrorType.soMuchPartCard);
      }

      final card = Barcode.fromBarcode(barcode);

      //Tuấn Anh sửa cho Kitting không bị trùng
      final receivingCards = await searchReceivingCardsTA(barcode: barcode, material: card.material);
      //Tuấn Anh Trùng Box card
      if (receivingCards.isEmpty) {
        throw ValidationError(type: ValidationErrorType.barcodeNotGR);
      } else if (receivingCards.length == 1) {
        final rc = receivingCards.single;
        return rc.items
                .singleWhereOrNull((element) => element.barcode == barcode) ??
            rc;
      } else {
        const a = '123';
        throw ValidationError(type: ValidationErrorType.soMuchPartCard);
      }
    } else {
      final receivingCardId = ReceivingCard.getReceivingCardID(barcode);
      final receivingCard = await getReceivingCard(receivingCardId);

      if (!isSub && receivingCard.items.isNotEmpty && receivingCard.items.every((element) => element.partCard is! StandardBarcode)) {
        throw ValidationError(type: ValidationErrorType.receivingCardNull);
      }

      return receivingCard;
    }
  }

  void clearDraftReceivingCard() {
    box.clear();
  }

  Future<ReceivingCard> splitReceivingCard({
    required int parentId,
    required int quantity,
    required int box,
    required String sloc,
    required String category,
    required String plant,
    String? material,
    List<ReceivingCardItem>? listMaterial,
    bool isPreview = false,
    bool isRecheck = false,
    bool isSamplingCheck = false,
  }) async {
    final request = SplitReceivingCardRequestModel(
      parentId: parentId,
      quantity: quantity,
      box: box,
      sloc: sloc,
      isPreview: isPreview,
      isRecheck: isRecheck,
      listMaterial: listMaterial?.map((e) => e.toRequestModel()).toList(),
      category: category,
      plant: plant,
      material: material,
      isSamplingCheck: isSamplingCheck,
    );
    final response = await _apiService.splitReceivingCard(request);
    return response.toEntity();
  }

  Future<void> qcBorrowReceivingCard(QCBorrowRcRequestModel body) {
    return _apiService.qcBorrowReceivingCard(body);
  }

  Future<List<QtyQCHistory>> getQtyQCHistory({
    required String material,
    required String plant,
    required String sloc,
  }) async {
    final res = await _apiService.getQtyQCHistory(
      material: material,
      plant: plant,
      sloc: sloc,
    );
    if(res != null && res.isNotEmpty){
      return res.map((e) => e.toEntity()).toList();
    }
    return [];
  }
}
