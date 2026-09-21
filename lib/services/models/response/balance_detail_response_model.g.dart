// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance_detail_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BalanceDetailResponseModel _$BalanceDetailResponseModelFromJson(
        Map<String, dynamic> json) =>
    BalanceDetailResponseModel(
      plant: json['plant'] as String?,
      sloc: json['sloc'] as String?,
      category: json['category'] as String?,
      material: json['material'] as String?,
      createdDate: json['createdDate'] as String?,
      updatedDate: json['updatedDate'] as String?,
      createdBy: json['createdBy'] as String?,
      updatedBy: json['updatedBy'] as String?,
      standardPrice: (json['standardPrice'] as num?)?.toDouble(),
      perQuantity: (json['perQuantity'] as num?)?.toInt(),
      sapQuantity: (json['sapQuantity'] as num?)?.toInt(),
      currentQuantity: (json['currentQuantity'] as num?)?.toInt(),
      status: (json['status'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BalanceDetailResponseModelToJson(
        BalanceDetailResponseModel instance) =>
    <String, dynamic>{
      'plant': instance.plant,
      'sloc': instance.sloc,
      'category': instance.category,
      'material': instance.material,
      'createdDate': instance.createdDate,
      'updatedDate': instance.updatedDate,
      'createdBy': instance.createdBy,
      'updatedBy': instance.updatedBy,
      'standardPrice': instance.standardPrice,
      'perQuantity': instance.perQuantity,
      'sapQuantity': instance.sapQuantity,
      'currentQuantity': instance.currentQuantity,
      'status': instance.status,
    };
