import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_response_model.dart';

part 'vendor_response_model.g.dart';

@JsonSerializable()
class VendorResponseModel extends BaseResponseModel  {
  const VendorResponseModel({
    this.vendorCode,
    this.globalCode,
    this.vendorName,
    this.vendorNameShort,
    this.country,
    this.status,
    this.createdDate,
    this.createdBy,
    this.updatedDate,
    this.updatedBy,
  });

  factory VendorResponseModel.fromJson(Map<String, dynamic> json) =>
      _$VendorResponseModelFromJson(json);

  final String? vendorCode;
  final String? globalCode;
  final String? vendorName;
  final String? vendorNameShort;
  final String? country;
  final int? status;
  final String? createdDate;
  final String? createdBy;
  final String? updatedDate;
  final String? updatedBy;

  @override
  Map<String, dynamic> toJson() => _$VendorResponseModelToJson(this);
}
