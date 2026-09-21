import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_response_model.dart';

part 'info_last_lot_response_model.g.dart';

@JsonSerializable()
class InfoLastLotResponseModel extends BaseResponseModel {
  InfoLastLotResponseModel({
    this.floorId,
    this.zoneLastLot,
  });
  factory InfoLastLotResponseModel.fromJson(Map<String, dynamic> json) =>
      _$InfoLastLotResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$InfoLastLotResponseModelToJson(this);

  final int? floorId;

  final ZoneLastLotResponseModel? zoneLastLot;
}

@JsonSerializable()
class ZoneLastLotResponseModel extends BaseResponseModel {
  ZoneLastLotResponseModel({
    this.zoneId,
    this.lastLot,
    this.rackLastLot,
  });
  factory ZoneLastLotResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ZoneLastLotResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ZoneLastLotResponseModelToJson(this);

  final int? zoneId;

  final String? lastLot;

  final RackLastLotResponseModel? rackLastLot;
}

@JsonSerializable()
class RackLastLotResponseModel extends BaseResponseModel {
  RackLastLotResponseModel({
    this.rackId,
    this.lastLot,
    this.blockLastLot,
  });
  factory RackLastLotResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RackLastLotResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RackLastLotResponseModelToJson(this);

  final int? rackId;

  final String? lastLot;

  final BlockLastLotResponseModel? blockLastLot;
}

@JsonSerializable()
class BlockLastLotResponseModel extends BaseResponseModel {
  BlockLastLotResponseModel({
    this.blockId,
    this.lastLot,
  });
  factory BlockLastLotResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BlockLastLotResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BlockLastLotResponseModelToJson(this);

  final int? blockId;

  final String? lastLot;
}