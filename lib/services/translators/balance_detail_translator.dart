import 'package:smart_warehouse/entities/inventory/balance_detail.dart';
import 'package:smart_warehouse/services/models/response/balance_detail_response_model.dart';

extension BalanceDetailTranslator on BalanceDetailResponseModel {
  BalanceDetail toEntity() {
    return BalanceDetail(
      plant: plant,
      sloc: sloc,
      category: category,
      material: material,
      createdDate: createdDate,
      updatedDate: updatedDate,
      createdBy: createdBy,
      updatedBy: updatedBy,
      standardPrice: standardPrice,
      perQuantity: perQuantity,
      sapQuantity: sapQuantity,
      currentQuantity: currentQuantity,
      status: status,
    );
  }
}
