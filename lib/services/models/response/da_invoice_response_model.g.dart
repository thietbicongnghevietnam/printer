// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'da_invoice_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DAInvoiceResponseModel _$DAInvoiceResponseModelFromJson(
        Map<String, dynamic> json) =>
    DAInvoiceResponseModel(
      (json['type'] as num).toInt(),
      (json['id'] as num).toInt(),
      json['no'] as String,
      json['globalCode'] as String? ?? '',
      json['deliveryDate'] as String? ?? '',
      json['createdDate'] as String?,
      json['updatedDate'] as String?,
      json['vendorCode'] as String? ?? '',
      (json['quantity'] as num?)?.toInt(),
      (json['details'] as List<dynamic>?)
          ?.map((e) =>
              DAInvoiceDetailResponseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DAInvoiceResponseModelToJson(
        DAInvoiceResponseModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'id': instance.id,
      'no': instance.no,
      'globalCode': instance.globalCode,
      'vendorCode': instance.vendorCode,
      'deliveryDate': instance.deliveryDate,
      'createdDate': instance.createdDate,
      'updatedDate': instance.updatedDate,
      'quantity': instance.quantity,
      'details': instance.details,
    };
