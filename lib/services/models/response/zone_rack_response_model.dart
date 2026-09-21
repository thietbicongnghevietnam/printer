import 'package:json_annotation/json_annotation.dart';

import 'base_response_model.dart';

part 'zone_rack_response_model.g.dart';

@JsonSerializable()
class ZoneRackResponseModel extends BaseResponseModel {
  ZoneRackResponseModel({
    this.offSetX,
    this.offSetY,
    this.rackStatus,
    this.width,
    this.height,
    this.rackType,
    this.unitTotal,
    this.rackRotation,
    this.rackID,
    this.rackCode,
  });

  factory ZoneRackResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ZoneRackResponseModelFromJson(json);

  final int? unitTotal;
  final int? rackStatus;

  final double? width;
  final double? height;
  final double? offSetX;
  final double? offSetY;

  final String? rackType;
  final String? rackRotation;
  final String? rackID;
  final String? rackCode;

  @override
  Map<String, dynamic> toJson() => _$ZoneRackResponseModelToJson(this);
}
