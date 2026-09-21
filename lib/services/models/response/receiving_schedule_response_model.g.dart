// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receiving_schedule_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceivingScheduleResponsesModel _$ReceivingScheduleResponsesModelFromJson(
        Map<String, dynamic> json) =>
    ReceivingScheduleResponsesModel(
      isBlock: json['isBlock'] as bool,
      datePrint: json['datePrint'] as String?,
      blockDate: json['blockDate'] as String?,
    );

Map<String, dynamic> _$ReceivingScheduleResponsesModelToJson(
        ReceivingScheduleResponsesModel instance) =>
    <String, dynamic>{
      'isBlock': instance.isBlock,
      'datePrint': instance.datePrint,
      'blockDate': instance.blockDate,
    };
