// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'po_item_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

POItemResponseModel _$POItemResponseModelFromJson(Map<String, dynamic> json) =>
    POItemResponseModel(
      json['poItem'] as String,
      json['material'] as String,
      (json['totalQuantity'] as num).toInt(),
      (json['gredQuantity'] as num).toInt(),
      json['poNo'] as String,
    );

Map<String, dynamic> _$POItemResponseModelToJson(
        POItemResponseModel instance) =>
    <String, dynamic>{
      'poNo': instance.poNo,
      'poItem': instance.poItem,
      'material': instance.material,
      'totalQuantity': instance.totalQuantity,
      'gredQuantity': instance.gredQuantity,
    };
