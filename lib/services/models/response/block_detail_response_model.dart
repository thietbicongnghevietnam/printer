import 'package:json_annotation/json_annotation.dart';
import 'package:smart_warehouse/services/models/response/layer_detail_response.dart';

import 'base_response_model.dart';

part 'block_detail_response_model.g.dart';

@JsonSerializable()
class BlockDetailResponseModel extends BaseResponseModel {
  BlockDetailResponseModel({
    this.blockName,
    this.blockId,
    this.blockStatus,
    this.numberOfLayer,
    this.unit,
    this.listLayers = const [],
  });

  factory BlockDetailResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BlockDetailResponseModelFromJson(json);

  final String? blockName;
  final String? blockId;

  final int? blockStatus;
  final int? numberOfLayer;

  @JsonKey(name: 'unit')
  final int? unit;

  @JsonKey(name: 'layers')
  List<LayerDetailResponseModel> listLayers;

  @override
  Map<String, dynamic> toJson() => _$BlockDetailResponseModelToJson(this);
}
