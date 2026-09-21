// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'da_invoice_detail_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DAInvoiceDetailResponseModel _$DAInvoiceDetailResponseModelFromJson(
        Map<String, dynamic> json) =>
    DAInvoiceDetailResponseModel(
      json['material'] as String,
      (json['daInvDetailId'] as num).toInt(),
      json['plant'] as String,
      json['sloc'] as String,
      (json['totalQuantity'] as num).toInt(),
      (json['gRedTotalQuantity'] as num?)?.toInt(),
      (json['daInvoiceItemDetails'] as List<dynamic>)
          .map((e) =>
              DAInvoiceItemResponseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DAInvoiceDetailResponseModelToJson(
        DAInvoiceDetailResponseModel instance) =>
    <String, dynamic>{
      'material': instance.material,
      'daInvDetailId': instance.daInvDetailId,
      'plant': instance.plant,
      'sloc': instance.sloc,
      'totalQuantity': instance.totalQuantity,
      'gRedTotalQuantity': instance.gredQuantity,
      'daInvoiceItemDetails': instance.daInvoiceItemDetails,
    };
