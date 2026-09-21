// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_map_format_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewMapFormatResponseModel _$NewMapFormatResponseModelFromJson(
        Map<String, dynamic> json) =>
    NewMapFormatResponseModel(
      id: (json['id'] as num?)?.toInt(),
      floorId: (json['floorId'] as num?)?.toInt(),
      floorName: json['floorName'] as String?,
    );

Map<String, dynamic> _$NewMapFormatResponseModelToJson(
        NewMapFormatResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'floorId': instance.floorId,
      'floorName': instance.floorName,
    };
