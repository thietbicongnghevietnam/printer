// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor_map_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FloorMapResponseModel _$FloorMapResponseModelFromJson(
        Map<String, dynamic> json) =>
    FloorMapResponseModel(
      floorId: (json['floorId'] as num?)?.toInt(),
      floorName: json['floorName'] as String?,
      zoneList: (json['zones'] as List<dynamic>?)
          ?.map(
              (e) => ZoneFloorResponseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      totalStored: (json['totalStored'] as num?)?.toInt(),
      totalTemporary: (json['totalTemporary'] as num?)?.toInt(),
      lastLotName: json['lastLotName'] as String?,
    );

Map<String, dynamic> _$FloorMapResponseModelToJson(
        FloorMapResponseModel instance) =>
    <String, dynamic>{
      'floorId': instance.floorId,
      'totalStored': instance.totalStored,
      'totalTemporary': instance.totalTemporary,
      'width': instance.width,
      'height': instance.height,
      'floorName': instance.floorName,
      'lastLotName': instance.lastLotName,
      'zones': instance.zoneList,
    };
