import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_response_model.dart';
import 'da_invoice_detail_response_model.dart';

part 'da_invoice_response_model.g.dart';

@JsonSerializable()
class DAInvoiceResponseModel extends BaseResponseModel {
  const DAInvoiceResponseModel(
    this.type,
    this.id,
    this.no,
    this.globalCode,
    this.deliveryDate,
    this.createdDate,
    this.updatedDate,
    this.vendorCode,
    this.quantity,
    this.details,
  );

  factory DAInvoiceResponseModel.fromJson(Map<String, dynamic> json) =>
      _$DAInvoiceResponseModelFromJson(json);

  final int type;
  final int id;
  final String no;
  @JsonKey(defaultValue: '')
  final String globalCode;
  @JsonKey(defaultValue: '')
  final String vendorCode;
  @JsonKey(defaultValue: '')
  final String deliveryDate;
  final String? createdDate;
  final String? updatedDate;
  final int? quantity;
  final List<DAInvoiceDetailResponseModel>? details;

  @override
  Map<String, dynamic> toJson() => _$DAInvoiceResponseModelToJson(this);
}
