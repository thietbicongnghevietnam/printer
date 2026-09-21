// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receiving_card_by_block_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceivingCardByBlockResponseModel _$ReceivingCardByBlockResponseModelFromJson(
        Map<String, dynamic> json) =>
    ReceivingCardByBlockResponseModel(
      receivingCardId: (json['receivingCardID'] as num?)?.toInt(),
      createdDate: json['createdDate'] as String?,
      updatedDate: json['updatedDate'] as String?,
      currentQuantity: (json['currentQuantity'] as num?)?.toInt(),
      barCode: json['barCode'] as String?,
    );

Map<String, dynamic> _$ReceivingCardByBlockResponseModelToJson(
        ReceivingCardByBlockResponseModel instance) =>
    <String, dynamic>{
      'createdDate': instance.createdDate,
      'updatedDate': instance.updatedDate,
      'barCode': instance.barCode,
      'receivingCardID': instance.receivingCardId,
      'currentQuantity': instance.currentQuantity,
    };
