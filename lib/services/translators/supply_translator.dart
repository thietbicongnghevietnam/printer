import 'package:smart_warehouse/entities/supply.dart';
import 'package:smart_warehouse/services/models/response/supply_response_model.dart';

extension SupplyTranslator on SupplyResponseModel {
  Supply toEntity() {
    return Supply(
      trolleyName: trolleyName,
      barCode: barCode,
      actionStatus: actionStatus,
      description: description,
      time: time,
      deliveryDate: deliveryDate,
      model: model,
      line: line,
      modelQuantity: modelQuantity,
      category: category,
      kittingTimeType: kittingTimeType,
      pic: pic,
      total: total
    );
  }
}
