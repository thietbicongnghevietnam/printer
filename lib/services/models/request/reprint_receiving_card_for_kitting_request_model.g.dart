// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reprint_receiving_card_for_kitting_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReprintReceivingCardForKittingRequestModel
    _$ReprintReceivingCardForKittingRequestModelFromJson(
            Map<String, dynamic> json) =>
        ReprintReceivingCardForKittingRequestModel(
          quantity: (json['quantity'] as num?)?.toInt(),
          isPreview: json['isPreview'] as bool?,
          barcode: json['barcode'] as String?,
        );

Map<String, dynamic> _$ReprintReceivingCardForKittingRequestModelToJson(
        ReprintReceivingCardForKittingRequestModel instance) =>
    <String, dynamic>{
      'barcode': instance.barcode,
      'quantity': instance.quantity,
      'isPreview': instance.isPreview,
    };
