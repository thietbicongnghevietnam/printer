// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_location_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChangeLocationRequestModel _$ChangeLocationRequestModelFromJson(
        Map<String, dynamic> json) =>
    ChangeLocationRequestModel(
      locationNameOld: json['locationNameOld'] as String,
      locationNameNew: json['locationNameNew'] as String,
    );

Map<String, dynamic> _$ChangeLocationRequestModelToJson(
        ChangeLocationRequestModel instance) =>
    <String, dynamic>{
      'locationNameOld': instance.locationNameOld,
      'locationNameNew': instance.locationNameNew,
    };
