// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_plan_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderPlanResponseModel _$OrderPlanResponseModelFromJson(
        Map<String, dynamic> json) =>
    OrderPlanResponseModel(
      json['planOrderNumber'] as String,
      json['plant'] as String,
      json['material'] as String,
      json['sloc'] as String,
      (json['planOrderQuantity'] as num).toInt(),
      (json['grQuantity'] as num).toInt(),
      json['postingDate'] as String?,
    );

Map<String, dynamic> _$OrderPlanResponseModelToJson(
        OrderPlanResponseModel instance) =>
    <String, dynamic>{
      'planOrderNumber': instance.planOrderNumber,
      'plant': instance.plant,
      'material': instance.material,
      'sloc': instance.sloc,
      'planOrderQuantity': instance.planOrderQuantity,
      'grQuantity': instance.grQuantity,
      'postingDate': instance.postingDate,
    };
