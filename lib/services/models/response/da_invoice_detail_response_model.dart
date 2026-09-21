import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/services/models/response/da_invoice_item_response_model.dart';

import 'base_response_model.dart';

part 'da_invoice_detail_response_model.g.dart';

@JsonSerializable()
class DAInvoiceDetailResponseModel extends BaseResponseModel {
  DAInvoiceDetailResponseModel(
    this.material,
    this.daInvDetailId,
    this.plant,
    this.sloc,
    this.totalQuantity,
    this.gredQuantity,
    this.daInvoiceItemDetails,
  );

  factory DAInvoiceDetailResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DAInvoiceDetailResponseModelFromJson(json);

  final String material;
  final int daInvDetailId;
  final String plant;
  final String sloc;
  final int totalQuantity;
  @JsonKey(name: 'gRedTotalQuantity')
  final int? gredQuantity;
  final List<DAInvoiceItemResponseModel> daInvoiceItemDetails;

  @override
  Map<String, dynamic> toJson() => _$DAInvoiceDetailResponseModelToJson(this);
}
