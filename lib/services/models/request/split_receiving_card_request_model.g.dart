// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'split_receiving_card_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SplitReceivingCardRequestModel _$SplitReceivingCardRequestModelFromJson(
        Map<String, dynamic> json) =>
    SplitReceivingCardRequestModel(
      parentId: (json['parentId'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
      box: (json['box'] as num).toInt(),
      sloc: json['sloc'] as String,
      isPreview: json['isPreview'] as bool,
      category: json['category'] as String,
      plant: json['plant'] as String,
      isRecheck: json['isRecheck'] as bool,
      listMaterial: (json['listMaterial'] as List<dynamic>?)
          ?.map((e) => MaterialRequestModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      material: json['material'] as String?,
      isSamplingCheck: json['IsSamplingCheck'] as bool? ?? false,
    );

Map<String, dynamic> _$SplitReceivingCardRequestModelToJson(
        SplitReceivingCardRequestModel instance) =>
    <String, dynamic>{
      'parentId': instance.parentId,
      'quantity': instance.quantity,
      'box': instance.box,
      'sloc': instance.sloc,
      'category': instance.category,
      'plant': instance.plant,
      'material': instance.material,
      'isPreview': instance.isPreview,
      'isRecheck': instance.isRecheck,
      'IsSamplingCheck': instance.isSamplingCheck,
      'listMaterial': instance.listMaterial,
    };
