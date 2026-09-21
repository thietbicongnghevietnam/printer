import 'package:json_annotation/json_annotation.dart';

import 'base_response_model.dart';

part 'floor_map_info_response_model.g.dart';

@JsonSerializable()
class FloorMapInfoResponseModel extends BaseResponseModel {
  FloorMapInfoResponseModel({
    this.id,
    this.floorId,
    this.floorName,
    this.floorCode,
  });

  factory FloorMapInfoResponseModel.fromJson(Map<String, dynamic> json) =>
      _$FloorMapInfoResponseModelFromJson(json);

  final int? id;
  final int? floorId;

  final String? floorName;
  final String? floorCode;

  @override
  Map<String, dynamic> toJson() => _$FloorMapInfoResponseModelToJson(this);
}
