// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'move_receiving_card_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MoveReceivingCardRequestModel _$MoveReceivingCardRequestModelFromJson(
        Map<String, dynamic> json) =>
    MoveReceivingCardRequestModel(
      temporaryAreaCodeOld: json['temporaryAreaCodeOld'] as String,
      temporaryAreaCodeNew: json['temporaryAreaCodeNew'] as String,
    );

Map<String, dynamic> _$MoveReceivingCardRequestModelToJson(
        MoveReceivingCardRequestModel instance) =>
    <String, dynamic>{
      'temporaryAreaCodeOld': instance.temporaryAreaCodeOld,
      'temporaryAreaCodeNew': instance.temporaryAreaCodeNew,
    };
