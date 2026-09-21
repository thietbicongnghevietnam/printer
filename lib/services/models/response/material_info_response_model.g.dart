// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material_info_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaterialInfoResponseModel _$MaterialInfoResponseModelFromJson(
        Map<String, dynamic> json) =>
    MaterialInfoResponseModel(
      json['urgent'] as String?,
      (json['samplingCheck'] as num?)?.toInt(),
      (json['rohsCheck'] as num?)?.toInt(),
      json['material'] as String,
      json['rosh'] as String?,
      json['iqcpl'] as String?,
      json['type'] as String?,
      json['frequency'] as String?,
      (json['qtyStandardPacking'] as num?)?.toInt(),
      json['typeSloc'] as String?,
      json['category'] as String?,
    );

Map<String, dynamic> _$MaterialInfoResponseModelToJson(
        MaterialInfoResponseModel instance) =>
    <String, dynamic>{
      'material': instance.material,
      'urgent': instance.urgent,
      'samplingCheck': instance.samplingCheck,
      'rohsCheck': instance.rohsCheck,
      'rosh': instance.rosh,
      'iqcpl': instance.iqcpl,
      'type': instance.type,
      'frequency': instance.frequency,
      'qtyStandardPacking': instance.qtyStandardPacking,
      'typeSloc': instance.typeSloc,
      'category': instance.category,
    };
