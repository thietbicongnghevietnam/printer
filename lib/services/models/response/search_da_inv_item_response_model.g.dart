// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_da_inv_item_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchDAInvItemResponseModel _$SearchDAInvItemResponseModelFromJson(
        Map<String, dynamic> json) =>
    SearchDAInvItemResponseModel(
      (json['id'] as num).toInt(),
      json['poItem'] as String,
      json['poNo'] as String,
      json['deliveryPlanNo'] as String,
      json['deliveryPlanItem'] as String,
      (json['planQuantity'] as num).toInt(),
      (json['actualQuantity'] as num).toInt(),
    );

Map<String, dynamic> _$SearchDAInvItemResponseModelToJson(
        SearchDAInvItemResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'poNo': instance.poNo,
      'poItem': instance.poItem,
      'deliveryPlanNo': instance.deliveryPlanNo,
      'deliveryPlanItem': instance.deliveryPlanItem,
      'planQuantity': instance.planQuantity,
      'actualQuantity': instance.actualQuantity,
    };
