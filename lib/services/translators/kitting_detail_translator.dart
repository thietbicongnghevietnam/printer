import 'package:smart_warehouse/entities/kitting/kitting_detail.dart';
import 'package:smart_warehouse/services/models/response/kitting_detail_response_model.dart';

extension KittingDetailTranslator on KittingDetailResponseModel {
  KittingDetail toEntity() {
    return KittingDetail(
      id: id,
      kittingListID: kittingListID,
      material: material,
      quantity:
          quantity + (kittingStatus != 1 || material == materialReplace ? 0 : (quantityReplace ?? 0)),
      unit: unit,
      sloc: sloc ?? '',
      descriptions: descriptions,
      locationName: locationName ?? '',
      picUser: picUser,
      barcode: barcode,
      kittingStatus: kittingStatus,
      supplyStatus: supplyStatus,
      kittingTimeType: kittingTimeType,
      kittingType: kittingType,
      model: model,
      location: location ?? '',
      time: time ?? '',
      pickedQuantity: pickedQuantity,
      frequency: frequency ?? '',
      plant: plant ?? '',
      category: category ?? '',
      countQtyKittingEnough: countQtyKittingEnough ?? 0,
      deliveryDate: deliveryDate,
      pl: pl,
      line: line,
      uploadNo: uploadNo,
      reason: reason,
      isOverdue: isOverdue,
      missingItem: missingItem,
      sameMaterial: sameMaterial,
    );
  }
}
