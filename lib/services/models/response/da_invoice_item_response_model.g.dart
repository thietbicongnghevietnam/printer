// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'da_invoice_item_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DAInvoiceItemResponseModel _$DAInvoiceItemResponseModelFromJson(
        Map<String, dynamic> json) =>
    DAInvoiceItemResponseModel(
      (json['daInvoiceDetailId'] as num).toInt(),
      json['poItem'] as String,
      json['poNo'] as String,
      json['daInvoiceItem'] as String,
      (json['planQuantity'] as num).toInt(),
      (json['actualQuantity'] as num).toInt(),
      (json['poPendingQuantity'] as num?)?.toInt(),
    );

Map<String, dynamic> _$DAInvoiceItemResponseModelToJson(
        DAInvoiceItemResponseModel instance) =>
    <String, dynamic>{
      'daInvoiceDetailId': instance.daInvoiceDetailId,
      'poItem': instance.poItem,
      'poNo': instance.poNo,
      'daInvoiceItem': instance.daInvoiceItem,
      'planQuantity': instance.planQuantity,
      'actualQuantity': instance.actualQuantity,
      'poPendingQuantity': instance.poPendingQuantity,
    };
