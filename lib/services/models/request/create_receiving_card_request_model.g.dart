// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_receiving_card_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateReceivingCardRequestModel _$CreateReceivingCardRequestModelFromJson(
        Map<String, dynamic> json) =>
    CreateReceivingCardRequestModel(
      quantity: (json['quantity'] as num).toInt(),
      box: (json['box'] as num).toInt(),
      deliveryPlanType: (json['deliveryPlanType'] as num).toInt(),
      daInvDetailId: (json['daInvDetailId'] as num?)?.toInt(),
      isPreview: json['isPreview'] as bool? ?? false,
      reason: json['reason'] as String?,
      material: json['material'] as String?,
      category: json['category'] as String?,
      listMaterial: (json['listMaterial'] as List<dynamic>?)
          ?.map((e) => MaterialRequestModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      isDatePrint: json['isDatePrint'] as bool,
      isGB: json['isGB'] as bool? ?? false,
      samplingCheck: json['samplingCheck'] as bool?,
      roshCheck: json['roshCheck'] as bool?,
    );

Map<String, dynamic> _$CreateReceivingCardRequestModelToJson(
        CreateReceivingCardRequestModel instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
      'box': instance.box,
      'deliveryPlanType': instance.deliveryPlanType,
      'daInvDetailId': instance.daInvDetailId,
      'reason': instance.reason,
      'material': instance.material,
      'category': instance.category,
      'isPreview': instance.isPreview,
      'isDatePrint': instance.isDatePrint,
      'isGB': instance.isGB,
      'samplingCheck': instance.samplingCheck,
      'roshCheck': instance.roshCheck,
      'listMaterial': instance.listMaterial,
    };
