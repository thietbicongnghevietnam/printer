// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_recard_jit_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreReCardJITRequestModel _$StoreReCardJITRequestModelFromJson(
        Map<String, dynamic> json) =>
    StoreReCardJITRequestModel(
      zoneName: json['zoneName'] as String,
      receivingCardIds: json['receivingCardIds'] as String,
    );

Map<String, dynamic> _$StoreReCardJITRequestModelToJson(
        StoreReCardJITRequestModel instance) =>
    <String, dynamic>{
      'zoneName': instance.zoneName,
      'receivingCardIds': instance.receivingCardIds,
    };
