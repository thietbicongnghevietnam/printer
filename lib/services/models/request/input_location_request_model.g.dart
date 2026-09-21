// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'input_location_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InputLocationRequestModel _$InputLocationRequestModelFromJson(
        Map<String, dynamic> json) =>
    InputLocationRequestModel(
      temporaryAreaCode: json['temporaryAreaCode'] as String,
      receivingCardIds: (json['receivingCardIds'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$InputLocationRequestModelToJson(
        InputLocationRequestModel instance) =>
    <String, dynamic>{
      'temporaryAreaCode': instance.temporaryAreaCode,
      'receivingCardIds': instance.receivingCardIds,
    };
