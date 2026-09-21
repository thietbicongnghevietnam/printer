// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'combine_location_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CombineLocationRequestModel _$CombineLocationRequestModelFromJson(
        Map<String, dynamic> json) =>
    CombineLocationRequestModel(
      receivingCardIds: json['receivingCardIds'] as String,
      locationNameNew: json['locationNameNew'] as String,
    );

Map<String, dynamic> _$CombineLocationRequestModelToJson(
        CombineLocationRequestModel instance) =>
    <String, dynamic>{
      'receivingCardIds': instance.receivingCardIds,
      'locationNameNew': instance.locationNameNew,
    };
