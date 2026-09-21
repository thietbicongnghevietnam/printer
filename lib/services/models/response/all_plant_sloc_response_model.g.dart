// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_plant_sloc_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AllPlantSlocResponseModel _$AllPlantSlocResponseModelFromJson(
        Map<String, dynamic> json) =>
    AllPlantSlocResponseModel(
      records: (json['records'] as List<dynamic>?)
          ?.map(
              (e) => PlantSlocResponseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AllPlantSlocResponseModelToJson(
        AllPlantSlocResponseModel instance) =>
    <String, dynamic>{
      'records': instance.records,
    };

PlantSlocResponseModel _$PlantSlocResponseModelFromJson(
        Map<String, dynamic> json) =>
    PlantSlocResponseModel(
      plant: json['plant'] as String?,
      material: json['material'] as String?,
      sloc: json['sloc'] as String?,
      type: json['type'] as String?,
      specialPart: json['specialPart'] as String?,
      frequency: json['frequency'] as String?,
      category: json['category'] as String?,
    );

Map<String, dynamic> _$PlantSlocResponseModelToJson(
        PlantSlocResponseModel instance) =>
    <String, dynamic>{
      'plant': instance.plant,
      'material': instance.material,
      'sloc': instance.sloc,
      'type': instance.type,
      'specialPart': instance.specialPart,
      'frequency': instance.frequency,
      'category': instance.category,
    };
