// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receiving_card_kitting_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceivingCardKittingResponsesModel _$ReceivingCardKittingResponsesModelFromJson(
        Map<String, dynamic> json) =>
    ReceivingCardKittingResponsesModel(
      rcid: (json['rcid'] as num?)?.toInt(),
      locationName: json['locationName'] as String?,
      material: json['material'] as String?,
    );

Map<String, dynamic> _$ReceivingCardKittingResponsesModelToJson(
        ReceivingCardKittingResponsesModel instance) =>
    <String, dynamic>{
      'rcid': instance.rcid,
      'locationName': instance.locationName,
      'material': instance.material,
    };
