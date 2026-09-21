// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'box_quantity_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoxQuantityResponseModel _$BoxQuantityResponseModelFromJson(
        Map<String, dynamic> json) =>
    BoxQuantityResponseModel(
      material: json['material'] as String?,
      barcode: json['barcode'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      quantityBox: (json['quantityBox'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BoxQuantityResponseModelToJson(
        BoxQuantityResponseModel instance) =>
    <String, dynamic>{
      'material': instance.material,
      'barcode': instance.barcode,
      'quantity': instance.quantity,
      'quantityBox': instance.quantityBox,
    };
