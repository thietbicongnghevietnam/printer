import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_response_model.dart';

part 'balance_detail_response_model.g.dart';

@JsonSerializable()
class BalanceDetailResponseModel extends BaseResponseModel {
  const BalanceDetailResponseModel({
    this.plant,
    this.sloc,
    this.category,
    this.material,
    this.createdDate,
    this.updatedDate,
    this.createdBy,
    this.updatedBy,
    this.standardPrice,
    this.perQuantity,
    this.sapQuantity,
    this.currentQuantity,
    this.status,
  });

  factory BalanceDetailResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BalanceDetailResponseModelFromJson(json);

  final String? plant;
  final String? sloc;
  final String? category;
  final String? material;
  final String? createdDate;
  final String? updatedDate;
  final String? createdBy;
  final String? updatedBy;

  final double? standardPrice;

  final int? perQuantity;
  final int? sapQuantity;
  final int? currentQuantity;
  final int? status;

  @override
  Map<String, dynamic> toJson() => _$BalanceDetailResponseModelToJson(this);
}
