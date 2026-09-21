import 'package:json_annotation/json_annotation.dart';

import 'base_response_model.dart';
import 'zone_detail_response_model.dart';

part 'zone_floor_response_model.g.dart';

@JsonSerializable()
class ZoneFloorResponseModel extends BaseResponseModel {
  ZoneFloorResponseModel({
    this.zoneId,
    this.zoneName,
    this.createdDate,
    this.backgroundColor,
    this.zoneType,
    this.imageName,
    this.isSuggested,
    this.isActive,
    this.isLastLot,
    this.listRack,
    this.isJIT,
    this.category,
    int? offsetY,
    int? offsetX,
    int? width,
    int? height,
  })  : offsetX = offsetX?.toDouble(),
        offsetY = offsetY?.toDouble(),
        width = width?.toDouble(),
        height = height?.toDouble();

  factory ZoneFloorResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ZoneFloorResponseModelFromJson(json);

  final int? zoneId;

  final double? width;
  final double? height;
  @JsonKey(name: 'x')
  final double? offsetX;
  @JsonKey(name: 'y')
  final double? offsetY;

  final String? zoneName;
  final String? createdDate;
  final String? backgroundColor;
  final String? zoneType;
  final String? imageName;
  final String? category;

  final bool? isSuggested;
  final bool? isActive;
  final bool? isJIT;
  final bool? isLastLot;

  List<ZoneDetailResponseModel>? listRack;

  @override
  Map<String, dynamic> toJson() => _$ZoneFloorResponseModelToJson(this);
}
