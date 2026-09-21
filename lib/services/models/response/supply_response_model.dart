import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/services/models/response/base_response_model.dart';

part 'supply_response_model.g.dart';

@JsonSerializable()
class SupplyResponseModel extends BaseResponseModel {
  SupplyResponseModel({
    this.trolleyName,
    this.barCode,
    this.actionStatus,
    this.description,
    this.time,
    this.deliveryDate,
    this.model,
    this.line,
    this.modelQuantity,
    this.category,
    this.kittingTimeType,
    this.pic,
    this.total,
  });
  factory SupplyResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SupplyResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SupplyResponseModelToJson(this);

  final String? trolleyName;
  final String? barCode;
  final int? actionStatus;
  final String? description;
  final String? time;
  final DateTime? deliveryDate;
  final String? model;
  final String? line;
  final int? modelQuantity;
  final String? category;
  final String? kittingTimeType;
  final String? pic;
  final int? total;
}
