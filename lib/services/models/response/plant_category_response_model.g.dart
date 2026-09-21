// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant_category_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlantCategoryResponseModel _$PlantCategoryResponseModelFromJson(
        Map<String, dynamic> json) =>
    PlantCategoryResponseModel(
      plant: json['plant'] as String?,
      sloc: json['sloc'] as String?,
      category: json['category'] as String?,
      specialPart: json['specialPart'] as String?,
    );

Map<String, dynamic> _$PlantCategoryResponseModelToJson(
        PlantCategoryResponseModel instance) =>
    <String, dynamic>{
      'plant': instance.plant,
      'sloc': instance.sloc,
      'category': instance.category,
      'specialPart': instance.specialPart,
    };
