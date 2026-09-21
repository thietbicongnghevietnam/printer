// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clone_receiving_card_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CloneReceivingCardRequestModel _$CloneReceivingCardRequestModelFromJson(
        Map<String, dynamic> json) =>
    CloneReceivingCardRequestModel(
      parentId: (json['parentId'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
      box: (json['box'] as num).toInt(),
      sloc: json['sloc'] as String,
      isPreview: json['isPreview'] as bool,
      listMaterial: (json['listMaterial'] as List<dynamic>?)
          ?.map((e) => MaterialRequestModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CloneReceivingCardRequestModelToJson(
        CloneReceivingCardRequestModel instance) =>
    <String, dynamic>{
      'parentId': instance.parentId,
      'quantity': instance.quantity,
      'box': instance.box,
      'sloc': instance.sloc,
      'isPreview': instance.isPreview,
      'listMaterial': instance.listMaterial,
    };
