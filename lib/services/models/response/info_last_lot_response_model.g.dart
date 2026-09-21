// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'info_last_lot_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InfoLastLotResponseModel _$InfoLastLotResponseModelFromJson(
        Map<String, dynamic> json) =>
    InfoLastLotResponseModel(
      floorId: (json['floorId'] as num?)?.toInt(),
      zoneLastLot: json['zoneLastLot'] == null
          ? null
          : ZoneLastLotResponseModel.fromJson(
              json['zoneLastLot'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InfoLastLotResponseModelToJson(
        InfoLastLotResponseModel instance) =>
    <String, dynamic>{
      'floorId': instance.floorId,
      'zoneLastLot': instance.zoneLastLot,
    };

ZoneLastLotResponseModel _$ZoneLastLotResponseModelFromJson(
        Map<String, dynamic> json) =>
    ZoneLastLotResponseModel(
      zoneId: (json['zoneId'] as num?)?.toInt(),
      lastLot: json['lastLot'] as String?,
      rackLastLot: json['rackLastLot'] == null
          ? null
          : RackLastLotResponseModel.fromJson(
              json['rackLastLot'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ZoneLastLotResponseModelToJson(
        ZoneLastLotResponseModel instance) =>
    <String, dynamic>{
      'zoneId': instance.zoneId,
      'lastLot': instance.lastLot,
      'rackLastLot': instance.rackLastLot,
    };

RackLastLotResponseModel _$RackLastLotResponseModelFromJson(
        Map<String, dynamic> json) =>
    RackLastLotResponseModel(
      rackId: (json['rackId'] as num?)?.toInt(),
      lastLot: json['lastLot'] as String?,
      blockLastLot: json['blockLastLot'] == null
          ? null
          : BlockLastLotResponseModel.fromJson(
              json['blockLastLot'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RackLastLotResponseModelToJson(
        RackLastLotResponseModel instance) =>
    <String, dynamic>{
      'rackId': instance.rackId,
      'lastLot': instance.lastLot,
      'blockLastLot': instance.blockLastLot,
    };

BlockLastLotResponseModel _$BlockLastLotResponseModelFromJson(
        Map<String, dynamic> json) =>
    BlockLastLotResponseModel(
      blockId: (json['blockId'] as num?)?.toInt(),
      lastLot: json['lastLot'] as String?,
    );

Map<String, dynamic> _$BlockLastLotResponseModelToJson(
        BlockLastLotResponseModel instance) =>
    <String, dynamic>{
      'blockId': instance.blockId,
      'lastLot': instance.lastLot,
    };
