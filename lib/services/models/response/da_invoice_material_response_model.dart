import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/services/models/response/da_invoice_item_response_model.dart';

import 'base_response_model.dart';

part 'da_invoice_material_response_model.g.dart';

@JsonSerializable()
class DAInvoiceMaterialResponseModel extends BaseResponseModel {
  DAInvoiceMaterialResponseModel(
    this.material,
    this.gredTotalQuantity,
    this.daInvItems,
  );

  factory DAInvoiceMaterialResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DAInvoiceMaterialResponseModelFromJson(json);

  final String material;
  @JsonKey(name: 'gRedTotalQuantity')
  final int gredTotalQuantity;
  final List<DAInvoiceItemResponseModel> daInvItems;

  @override
  Map<String, dynamic> toJson() => _$DAInvoiceMaterialResponseModelToJson(this);
}
