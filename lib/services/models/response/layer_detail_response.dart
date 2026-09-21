import 'package:json_annotation/json_annotation.dart';

import 'base_response_model.dart';

part 'layer_detail_response.g.dart';

@JsonSerializable()
class LayerDetailResponseModel extends BaseResponseModel {
  LayerDetailResponseModel({
    this.blockName,
    this.blockId,
    this.isStored,
    this.lastLot,
    this.lastNodeName = '',
    this.pl,
  });

  factory LayerDetailResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LayerDetailResponseModelFromJson(json);

  @JsonKey(name: 'blockId')
  final int? blockId;
  final int? lastLot;

  @JsonKey(name: 'name')
  final String? blockName;

  @JsonKey(name: 'isStored')
  final bool? isStored;
  String? lastNodeName;
  String? pl;

  @override
  Map<String, dynamic> toJson() => _$LayerDetailResponseModelToJson(this);
}
