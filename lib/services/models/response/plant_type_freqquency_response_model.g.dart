// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plant_type_freqquency_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PlantTypeFrequencyResponseModel _$PlantTypeFrequencyResponseModelFromJson(
        Map<String, dynamic> json) =>
    PlantTypeFrequencyResponseModel(
      plant: json['plant'] as String?,
      slocs: (json['slocs'] as List<dynamic>?)
          ?.map((e) => SlocInfoFromPlantResponseModel.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PlantTypeFrequencyResponseModelToJson(
        PlantTypeFrequencyResponseModel instance) =>
    <String, dynamic>{
      'plant': instance.plant,
      'slocs': instance.slocs,
    };
