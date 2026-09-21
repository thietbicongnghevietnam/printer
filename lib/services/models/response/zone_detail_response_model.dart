import 'package:json_annotation/json_annotation.dart';
import 'package:smart_warehouse/services/models/response/rack_detail_response_model.dart';

import 'base_response_model.dart';

part 'zone_detail_response_model.g.dart';

@JsonSerializable()
class ZoneDetailResponseModel extends BaseResponseModel {
  ZoneDetailResponseModel({
    // this.rackStatus,
    this.zoneId,
    this.listRack,
    this.floorName,
    this.zoneName,
    int? width,
    int? height,
    this.totalStored,
    this.lastLotName,
  })  : width = width?.toDouble(),
        height = height?.toDouble();

  factory ZoneDetailResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ZoneDetailResponseModelFromJson(json);

  final int? zoneId;
  final int? totalStored;

  final double? width;
  final double? height;

  final String? floorName;
  final String? zoneName;
  final String? lastLotName;

  @JsonKey(name: 'racks')
  final List<RackDetailResponseModel>? listRack;

  @override
  Map<String, dynamic> toJson() => _$ZoneDetailResponseModelToJson(this);
}
