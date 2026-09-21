// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'move_out_store_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoveOutStoreRequestModel _$MoveOutStoreRequestModelFromJson(
        Map<String, dynamic> json) =>
    MoveOutStoreRequestModel(
      receivingCardId: (json['receivingCardId'] as num?)?.toInt(),
      reasonOutStorage: json['reasonOutStorage'] as String?,
    );

Map<String, dynamic> _$MoveOutStoreRequestModelToJson(
        MoveOutStoreRequestModel instance) =>
    <String, dynamic>{
      'receivingCardId': instance.receivingCardId,
      'reasonOutStorage': instance.reasonOutStorage,
    };
