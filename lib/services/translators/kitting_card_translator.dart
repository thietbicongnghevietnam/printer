import 'package:smart_warehouse/entities/kitting/kitting_card.dart';
import 'package:smart_warehouse/services/models/response/kitting_card_response_model.dart';

extension KittingCardTranslator on KittingCardResponseModel {
  KittingCard toEntity() {
    return KittingCard(
      id: kittingCardID,
      rcDetailID: rcDetailID,
      rcid: rcid,
      kittingListDetailId: kittingListDetailId,
      material: partNo,
      model: model,
      quantity: quantity,
      sloc: sloc,
      barcode: barcode ?? '',
      kittingTimeType: kittingTimeType,
      kittingHour: time,
      kittingDate: dateTimeKitting,
      line: line,
      posMcs: posMCS ?? '',
      posFA: posFA,
      pic: picUser,
      plant: plant,
      pl: pl ?? '',
      qtyTotal: qtyTotal,
      status: status,
      kittingType: kittingType,
      category: category,
      receiptSloc: receiptSloc,
      kittingFrom: kittingFrom,
      reason: reason,
      remark: remark,
      pullID: pullID,
    );
  }
}
