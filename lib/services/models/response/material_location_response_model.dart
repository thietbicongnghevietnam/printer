import 'package:json_annotation/json_annotation.dart';

import 'base_response_model.dart';

part 'material_location_response_model.g.dart';

@JsonSerializable()
class MaterialLocationResponseModel extends BaseResponseModel {
  MaterialLocationResponseModel({
    this.receivingCardID,
    this.material,
    this.totalCurrentQuantity,
    this.position,
    this.createdBy,
    this.createdDate,
    this.receivingCardTime,
    this.receivingCardDate,
    this.sloc,
    this.qtyTemp,
    this.qtyKitting,
  });

  factory MaterialLocationResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MaterialLocationResponseModelFromJson(json);

  final int? receivingCardID;
  final String? material;
  final String? position;
  final String? createdBy;
  final String? createdDate;
  final String? receivingCardTime;
  final String? receivingCardDate;
  final String? sloc;

  final int? totalCurrentQuantity;
  final int? qtyTemp;
  final int? qtyKitting;

  @override
  Map<String, dynamic> toJson() => _$MaterialLocationResponseModelToJson(this);
}
