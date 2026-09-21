import 'package:json_annotation/json_annotation.dart';

import 'base_response_model.dart';
import 'zone_floor_response_model.dart';

part 'floor_map_response_model.g.dart';

@JsonSerializable()
class FloorMapResponseModel extends BaseResponseModel {
  FloorMapResponseModel({
    this.floorId,
    this.floorName,
    this.zoneList,
    int? width,
    int? height,
    this.totalStored,
    this.totalTemporary,
    this.lastLotName,
  })  : width = width?.toDouble(),
        height = height?.toDouble();

  factory FloorMapResponseModel.fromJson(Map<String, dynamic> json) =>
      _$FloorMapResponseModelFromJson(json);

  final int? floorId;
  final int? totalStored;
  final int? totalTemporary;

  final double? width;
  final double? height;

  final String? floorName;
  final String? lastLotName;

  @JsonKey(name: 'zones')
  final List<ZoneFloorResponseModel>? zoneList;

  @override
  Map<String, dynamic> toJson() => _$FloorMapResponseModelToJson(this);
}