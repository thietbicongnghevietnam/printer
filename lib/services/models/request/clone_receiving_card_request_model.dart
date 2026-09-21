import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/services/models/request/base_request_model.dart';

import 'material_request_model.dart';

part 'clone_receiving_card_request_model.g.dart';

@JsonSerializable()
class CloneReceivingCardRequestModel extends BaseRequestModel {
  CloneReceivingCardRequestModel({
    required this.parentId,
    required this.quantity,
    required this.box,
    required this.sloc,
    required this.isPreview,
    this.listMaterial,
  });
  factory CloneReceivingCardRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CloneReceivingCardRequestModelFromJson(json);

  final int parentId;
  final int quantity;
  final int box;
  final String sloc;
  final bool isPreview;
  final List<MaterialRequestModel>? listMaterial;

  @override
  Map<String, dynamic> toJson() => _$CloneReceivingCardRequestModelToJson(this);
}
