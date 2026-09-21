// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zone_floor_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ZoneFloorResponseModel _$ZoneFloorResponseModelFromJson(
        Map<String, dynamic> json) =>
    ZoneFloorResponseModel(
      zoneId: (json['zoneId'] as num?)?.toInt(),
      zoneName: json['zoneName'] as String?,
      createdDate: json['createdDate'] as String?,
      backgroundColor: json['backgroundColor'] as String?,
      zoneType: json['zoneType'] as String?,
      imageName: json['imageName'] as String?,
      isSuggested: json['isSuggested'] as bool?,
      isActive: json['isActive'] as bool?,
      isLastLot: json['isLastLot'] as bool?,
      listRack: (json['listRack'] as List<dynamic>?)
          ?.map((e) =>
              ZoneDetailResponseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      isJIT: json['isJIT'] as bool?,
      category: json['category'] as String?,
      offsetY: (json['y'] as num?)?.toInt(),
      offsetX: (json['x'] as num?)?.toInt(),
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ZoneFloorResponseModelToJson(
        ZoneFloorResponseModel instance) =>
    <String, dynamic>{
      'zoneId': instance.zoneId,
      'width': instance.width,
      'height': instance.height,
      'x': instance.offsetX,
      'y': instance.offsetY,
      'zoneName': instance.zoneName,
      'createdDate': instance.createdDate,
      'backgroundColor': instance.backgroundColor,
      'zoneType': instance.zoneType,
      'imageName': instance.imageName,
      'category': instance.category,
      'isSuggested': instance.isSuggested,
      'isActive': instance.isActive,
      'isJIT': instance.isJIT,
      'isLastLot': instance.isLastLot,
      'listRack': instance.listRack,
    };
