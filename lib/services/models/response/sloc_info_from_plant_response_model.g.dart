// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sloc_info_from_plant_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SlocInfoFromPlantResponseModel _$SlocInfoFromPlantResponseModelFromJson(
        Map<String, dynamic> json) =>
    SlocInfoFromPlantResponseModel(
      sloc: json['sloc'] as String?,
      type: json['type'] as String?,
      frequency: json['frequency'] as String?,
      category: (json['category'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      specialPart: json['specialPart'] as String?,
    );

Map<String, dynamic> _$SlocInfoFromPlantResponseModelToJson(
        SlocInfoFromPlantResponseModel instance) =>
    <String, dynamic>{
      'sloc': instance.sloc,
      'type': instance.type,
      'frequency': instance.frequency,
      'specialPart': instance.specialPart,
      'category': instance.category,
    };
