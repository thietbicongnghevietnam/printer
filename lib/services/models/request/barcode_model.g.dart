// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'barcode_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BarCodeModel _$BarCodeModelFromJson(Map<String, dynamic> json) => BarCodeModel(
      daInvNo: json['daInvNo'] as String?,
      daInvId: (json['daInvId'] as num?)?.toInt(),
      vendorCode: json['vendorCode'] as String?,
      deliveryDate: json['deliveryDate'] == null
          ? null
          : DateTime.parse(json['deliveryDate'] as String),
      unitNo: json['unitNo'] as String?,
      poNo: json['poNo'] as String?,
      poItem: json['poItem'] as String?,
      lotNo: json['lotNo'] as String?,
      barcode: json['barcode'] as String?,
      material: json['material'] as String,
      materialType: json['materialType'] as String?,
      plant: json['plant'] as String?,
      sloc: json['sloc'] as String?,
      totalQuantity: (json['totalQuantity'] as num?)?.toInt(),
      currentQuantity: (json['currentQuantity'] as num?)?.toInt(),
      boxQuantity: (json['boxQuantity'] as num?)?.toInt(),
      totalBox: (json['totalBox'] as num?)?.toInt(),
      reason: json['reason'] as String?,
    );

Map<String, dynamic> _$BarCodeModelToJson(BarCodeModel instance) =>
    <String, dynamic>{
      'daInvNo': instance.daInvNo,
      'daInvId': instance.daInvId,
      'vendorCode': instance.vendorCode,
      'deliveryDate': instance.deliveryDate?.toIso8601String(),
      'unitNo': instance.unitNo,
      'poNo': instance.poNo,
      'poItem': instance.poItem,
      'lotNo': instance.lotNo,
      'barcode': instance.barcode,
      'material': instance.material,
      'materialType': instance.materialType,
      'plant': instance.plant,
      'sloc': instance.sloc,
      'totalQuantity': instance.totalQuantity,
      'currentQuantity': instance.currentQuantity,
      'boxQuantity': instance.boxQuantity,
      'totalBox': instance.totalBox,
      'reason': instance.reason,
    };
