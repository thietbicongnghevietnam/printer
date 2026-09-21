// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'return_kitting_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReturnKittingRequestModel _$ReturnKittingRequestModelFromJson(
        Map<String, dynamic> json) =>
    ReturnKittingRequestModel(
      isPreview: json['isPreview'] as bool?,
      quantity: (json['quantity'] as num?)?.toInt(),
      barcode:
          (json['barcode'] as List<dynamic>?)?.map((e) => e as String).toList(),
      returnKittingType: json['returnKittingType'] as String?,
      material: json['material'] as String?,
      plant: json['plant'] as String?,
      sloc: json['sloc'] as String?,
      category: json['category'] as String?,
    );

Map<String, dynamic> _$ReturnKittingRequestModelToJson(
        ReturnKittingRequestModel instance) =>
    <String, dynamic>{
      'barcode': instance.barcode,
      'quantity': instance.quantity,
      'isPreview': instance.isPreview,
      'returnKittingType': instance.returnKittingType,
      'material': instance.material,
      'plant': instance.plant,
      'sloc': instance.sloc,
      'category': instance.category,
    };
