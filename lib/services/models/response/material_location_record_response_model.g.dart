// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material_location_record_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaterialLocationRecordResponseModel
    _$MaterialLocationRecordResponseModelFromJson(Map<String, dynamic> json) =>
        MaterialLocationRecordResponseModel(
          currentQuantity: (json['currentQuantity'] as num?)?.toInt(),
          totalQuantity: (json['totalQuantity'] as num?)?.toInt(),
          blockName: json['blockName'] as String?,
          zoneName: json['zoneName'] as String?,
          rackCode: json['rackCode'] as String?,
          floorName: json['floorName'] as String?,
        );

Map<String, dynamic> _$MaterialLocationRecordResponseModelToJson(
        MaterialLocationRecordResponseModel instance) =>
    <String, dynamic>{
      'currentQuantity': instance.currentQuantity,
      'totalQuantity': instance.totalQuantity,
      'blockName': instance.blockName,
      'zoneName': instance.zoneName,
      'rackCode': instance.rackCode,
      'floorName': instance.floorName,
    };
