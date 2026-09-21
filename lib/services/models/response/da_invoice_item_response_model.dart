import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_response_model.dart';

part 'da_invoice_item_response_model.g.dart';

@JsonSerializable()
class DAInvoiceItemResponseModel extends BaseResponseModel {
  DAInvoiceItemResponseModel(
    this.daInvoiceDetailId,
    this.poItem,
    this.poNo,
    this.daInvoiceItem,
    this.planQuantity,
    this.actualQuantity,
    this.poPendingQuantity,
  );

  factory DAInvoiceItemResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DAInvoiceItemResponseModelFromJson(json);

  final int daInvoiceDetailId;
  final String poItem;
  final String poNo;
  final String daInvoiceItem;
  final int planQuantity;
  final int actualQuantity;
  final int? poPendingQuantity;

  @override
  Map<String, dynamic> toJson() => _$DAInvoiceItemResponseModelToJson(this);
}
