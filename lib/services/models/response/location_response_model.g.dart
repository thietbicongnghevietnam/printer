// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationResponseModel _$LocationResponseModelFromJson(
        Map<String, dynamic> json) =>
    LocationResponseModel(
      location: json['location'] as String?,
      material: json['material'] as String?,
      currentQuantity: (json['currentQuantity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LocationResponseModelToJson(
        LocationResponseModel instance) =>
    <String, dynamic>{
      'location': instance.location,
      'material': instance.material,
      'currentQuantity': instance.currentQuantity,
    };
