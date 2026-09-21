// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zone_detail_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ZoneDetailResponseModel _$ZoneDetailResponseModelFromJson(
        Map<String, dynamic> json) =>
    ZoneDetailResponseModel(
      zoneId: (json['zoneId'] as num?)?.toInt(),
      listRack: (json['racks'] as List<dynamic>?)
          ?.map((e) =>
              RackDetailResponseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      floorName: json['floorName'] as String?,
      zoneName: json['zoneName'] as String?,
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      totalStored: (json['totalStored'] as num?)?.toInt(),
      lastLotName: json['lastLotName'] as String?,
    );

Map<String, dynamic> _$ZoneDetailResponseModelToJson(
        ZoneDetailResponseModel instance) =>
    <String, dynamic>{
      'zoneId': instance.zoneId,
      'totalStored': instance.totalStored,
      'width': instance.width,
      'height': instance.height,
      'floorName': instance.floorName,
      'zoneName': instance.zoneName,
      'lastLotName': instance.lastLotName,
      'racks': instance.listRack,
    };
