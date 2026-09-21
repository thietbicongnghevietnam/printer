// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor_map_info_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FloorMapInfoResponseModel _$FloorMapInfoResponseModelFromJson(
        Map<String, dynamic> json) =>
    FloorMapInfoResponseModel(
      id: (json['id'] as num?)?.toInt(),
      floorId: (json['floorId'] as num?)?.toInt(),
      floorName: json['floorName'] as String?,
      floorCode: json['floorCode'] as String?,
    );

Map<String, dynamic> _$FloorMapInfoResponseModelToJson(
        FloorMapInfoResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'floorId': instance.floorId,
      'floorName': instance.floorName,
      'floorCode': instance.floorCode,
    };
