// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inventory_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InventoryResponseModel _$InventoryResponseModelFromJson(
        Map<String, dynamic> json) =>
    InventoryResponseModel(
      material: json['material'] as String?,
      total: (json['total'] as num?)?.toInt(),
      goodReceiptQuantity: (json['goodReceiptQuantity'] as num?)?.toInt(),
      storedQuantity: (json['storedQuantity'] as num?)?.toInt(),
      movedOutQuantity: (json['movedOutQuantity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$InventoryResponseModelToJson(
        InventoryResponseModel instance) =>
    <String, dynamic>{
      'material': instance.material,
      'total': instance.total,
      'goodReceiptQuantity': instance.goodReceiptQuantity,
      'storedQuantity': instance.storedQuantity,
      'movedOutQuantity': instance.movedOutQuantity,
    };
