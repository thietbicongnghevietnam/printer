// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'confirm_receiving_card_printed_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConfirmReceivingCardPrintedRequestModel
    _$ConfirmReceivingCardPrintedRequestModelFromJson(
            Map<String, dynamic> json) =>
        ConfirmReceivingCardPrintedRequestModel(
          id: (json['id'] as num).toInt(),
          status: (json['status'] as num?)?.toInt() ?? 0,
        );

Map<String, dynamic> _$ConfirmReceivingCardPrintedRequestModelToJson(
        ConfirmReceivingCardPrintedRequestModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
    };
