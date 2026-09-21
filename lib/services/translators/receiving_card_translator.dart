import 'package:smart_warehouse/entities/barcode/barcode.dart';
import 'package:smart_warehouse/entities/delivery_plan.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/entities/receiving_card_item.dart';
import 'package:smart_warehouse/enums/delivery_type.dart';
import 'package:smart_warehouse/enums/receiving_card_reason.dart';
import 'package:smart_warehouse/enums/receving_card_type.dart';
import 'package:smart_warehouse/services/models/request/material_request_model.dart';
import 'package:smart_warehouse/services/models/response/material_response_model.dart';
import 'package:smart_warehouse/services/models/response/receiving_card_response_model.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';

extension ReceivingCardTranslator on ReceivingCardResponseModel {
  ReceivingCard toEntity({
    bool hasDeliveryPlan = true,
    String? daInvByStock,
  }) {
    return ReceivingCard(
      id: receivingCardID ?? 0,
      samplingCheck: samplingCheck == 1,
      rohsCheck: rohsCheck == 1,
      totalQuantity: totalQuantity ?? 0,
      currentQuantity: currentQuantity ?? 0,
      plant: plant,
      receivingCardTime: receivingCardTime,
      urgent: urgent,
      ulcoc: ulcoc,
      material: material ?? '',
      materialType: materialType,
      materialFrequency: materialFrequency,
      codeDate: codeDate,
      isNG: isNG,
      deliveryPlan: hasDeliveryPlan
          ? DeliveryPlan(
              id: daInvId,
              no: daInvNo ?? '',
              type: DeliveryPlanType.fromCode(receivingType ?? 0),
            )
          : null,
      reason: ReceivingCardReason.fromCode(reason),
      pl: ['A1', 'A2'].contains(pl) ? 'PL*    $pl' : pl,
      rohs: rohs,
      receivingCardDate: receivingCardDate,
      vendorCode: vendorCode,
      vendorName: vendorName,
      sloc: sloc,
      barcode: barcode ?? '',
      temporaryAreaCode: temporaryAreaCode,
      haveBarcode: haveBarcode ?? true,
      category: category,
      qtyDAInv: qtyDAInv,
      daInvDetailId: daInvDetailId,
      items: receivingCardDetails
              ?.map((e) => e.toEntity(receivingDate: receivingCardDate))
              .toList() ??
          [],
      daInvNoFromStock: !hasDeliveryPlan ? daInvByStock : null,
      box: boxQuantity,
      inforLastLot: inforLastLot,
      location: location,
      isOverdue: isOverdue,
      receivingType: receivingType,
      rcType: ReceivingCardPrinterType.fromCode(convertRcType(receivingType ?? 0)),
    );
  }

  int convertRcType(int receivingType) {
    if (receivingType == 0 || receivingType == 1 || receivingType == 2) {
      return 0;
    } else if (receivingType == 3) {
      return 3;
    } else if (receivingType == 4) {
      return 4;
    }
    return 0;
  }
}

extension ReceivingCardItemTranslator on MaterialResponseModel {
  ReceivingCardItem toEntity({DateTime? receivingDate}) {
    return ReceivingCardItem(
      id: receivingCardDetailID,
      receivingCardID: receivingCardID,
      material: material,
      dateCode: codeDate,
      unitNo: unitNo,
      totalQuantity: totalQuantity,
      currentQuantity: currentQuantity,
      partCard: Barcode.fromBarcode(barcode),
      receivingDate: receivingDate,
    );
  }
}

extension ReceivingCardItemRequestTranslator on ReceivingCardItem {
  MaterialRequestModel toRequestModel() {
    return MaterialRequestModel(
      id: id,
      barcode: barcode,
      unitNo: unitNo,
      quantity: currentQuantity,
      poNo: poNo,
      poItem: poItem,
      daIvnItem: daIvnItem,
    );
  }
}
