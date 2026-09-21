// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_recard_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreReCardRequestModel _$StoreReCardRequestModelFromJson(
        Map<String, dynamic> json) =>
    StoreReCardRequestModel(
      location: json['location'] as String,
      receivingCardId: (json['receivingCardId'] as num).toInt(),
    );

Map<String, dynamic> _$StoreReCardRequestModelToJson(
        StoreReCardRequestModel instance) =>
    <String, dynamic>{
      'location': instance.location,
      'receivingCardId': instance.receivingCardId,
    };
