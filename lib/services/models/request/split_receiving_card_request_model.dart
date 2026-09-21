import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/services/models/request/base_request_model.dart';

import 'material_request_model.dart';

part 'split_receiving_card_request_model.g.dart';

@JsonSerializable()
class SplitReceivingCardRequestModel extends BaseRequestModel {
  SplitReceivingCardRequestModel({
    required this.parentId,
    required this.quantity,
    required this.box,
    required this.sloc,
    required this.isPreview,
    required this.category,
    required this.plant,
    required this.isRecheck,
    this.listMaterial,
    this.material,
    this.isSamplingCheck = false,
  });
  factory SplitReceivingCardRequestModel.fromJson(Map<String, dynamic> json) =>
      _$SplitReceivingCardRequestModelFromJson(json);

  final int parentId;
  final int quantity;
  final int box;
  final String sloc;
  final String category;
  final String plant;
  final String? material;
  final bool isPreview;
  final bool isRecheck;

  @JsonKey(name: 'IsSamplingCheck')
  final bool isSamplingCheck;

  final List<MaterialRequestModel>? listMaterial;

  @override
  Map<String, dynamic> toJson() => _$SplitReceivingCardRequestModelToJson(this);
}
