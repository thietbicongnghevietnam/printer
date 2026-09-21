// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'da_invoice_material_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DAInvoiceMaterialResponseModel _$DAInvoiceMaterialResponseModelFromJson(
        Map<String, dynamic> json) =>
    DAInvoiceMaterialResponseModel(
      json['material'] as String,
      (json['gRedTotalQuantity'] as num).toInt(),
      (json['daInvItems'] as List<dynamic>)
          .map((e) =>
              DAInvoiceItemResponseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DAInvoiceMaterialResponseModelToJson(
        DAInvoiceMaterialResponseModel instance) =>
    <String, dynamic>{
      'material': instance.material,
      'gRedTotalQuantity': instance.gredTotalQuantity,
      'daInvItems': instance.daInvItems,
    };
