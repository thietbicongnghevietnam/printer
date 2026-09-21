// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material_sample_responses_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaterialSampleResponseModel _$MaterialSampleResponseModelFromJson(
        Map<String, dynamic> json) =>
    MaterialSampleResponseModel(
      name: json['name'] as String?,
      material: json['material'] as String?,
      id: (json['id'] as num?)?.toInt(),
      description: json['description'] as String?,
      filePath: json['filePath'] as String?,
      fileBase64: json['fileBase64'] as String?,
    );

Map<String, dynamic> _$MaterialSampleResponseModelToJson(
        MaterialSampleResponseModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'material': instance.material,
      'description': instance.description,
      'filePath': instance.filePath,
      'fileBase64': instance.fileBase64,
      'id': instance.id,
    };
