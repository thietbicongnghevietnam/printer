// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_receiving_card_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateReceivingCardRequestModel _$UpdateReceivingCardRequestModelFromJson(
        Map<String, dynamic> json) =>
    UpdateReceivingCardRequestModel(
      (json['receivingCardId'] as num).toInt(),
      (json['quantity'] as num).toInt(),
      (json['box'] as num).toInt(),
      (json['lstIdDetailDelete'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      (json['lstReceivingCardDetail'] as List<dynamic>?)
          ?.map((e) => MaterialRequestModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$UpdateReceivingCardRequestModelToJson(
        UpdateReceivingCardRequestModel instance) =>
    <String, dynamic>{
      'receivingCardId': instance.receivingCardId,
      'quantity': instance.quantity,
      'box': instance.box,
      'lstIdDetailDelete': instance.lstIdDetailDelete,
      'lstReceivingCardDetail': instance.lstReceivingCardDetail,
    };
