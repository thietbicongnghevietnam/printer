// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fifo_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FifoResponseModel _$FifoResponseModelFromJson(Map<String, dynamic> json) =>
    FifoResponseModel(
      (json['id'] as num?)?.toInt(),
      json['barcode'] as String?,
    );

Map<String, dynamic> _$FifoResponseModelToJson(FifoResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'barcode': instance.barcode,
    };
