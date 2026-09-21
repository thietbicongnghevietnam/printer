import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/services/models/request/material_request_model.dart';

import 'base_request_model.dart';

part 'create_receiving_card_request_model.g.dart';

@JsonSerializable()
class CreateReceivingCardRequestModel extends BaseRequestModel {
  CreateReceivingCardRequestModel({
    required this.quantity,
    required this.box,
    required this.deliveryPlanType,
    this.daInvDetailId,
    this.isPreview = false,
    this.reason,
    this.material,
    this.category,
    this.listMaterial,
    required this.isDatePrint,
    this.isGB = false,
    bool? samplingCheck,
    bool? roshCheck,
  }) {
    this.samplingCheck = samplingCheck ?? false ? 1 : 0;
    this.roshCheck = roshCheck ?? false ? 1 : 0;
  }

  factory CreateReceivingCardRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CreateReceivingCardRequestModelFromJson(json);

  final int quantity;

  final int box;

  final int deliveryPlanType;

  final int? daInvDetailId;

  final String? reason;

  final String? material;

  final String? category;

  final bool isPreview;

  final bool isDatePrint;

  final bool isGB;

  late int? samplingCheck;

  late int? roshCheck;

  final List<MaterialRequestModel>? listMaterial;

  @override
  Map<String, dynamic> toJson() =>
      _$CreateReceivingCardRequestModelToJson(this);
}
