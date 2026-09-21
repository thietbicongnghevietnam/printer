import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_response_model.dart';

part 'kitting_response_model.g.dart';

@JsonSerializable()
class KittingResponseModel extends BaseResponseModel {
  KittingResponseModel(
  {this.id,
      this.createdDate,
      this.createdBy,
      this.updatedDate,
      this.updateBy,
      this.plant,
      this.reservationNo,
      this.line,
      this.time,
      this.model,
      this.modelQuantity,
      this.deliverydate,
      this.category,
      this.barcode,
      this.quantity,
      this.kittingType,
      this.kittingTimeType,
      this.status});
  factory KittingResponseModel.fromJson(Map<String, dynamic> json) =>
      _$KittingResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$KittingResponseModelToJson(this);

  final int? id;
  final DateTime? createdDate;
  final String? createdBy;
  final DateTime? updatedDate;
  final String? updateBy;
  final String? plant;
  final String? reservationNo;
  final String? line;
  final String? time;
  final String? model;
  final int? modelQuantity;
  final DateTime? deliverydate;
  final String? category;
  final String? barcode;
  final int? quantity;
  final int? kittingType;
  final String? kittingTimeType;
  final int? status;
}
