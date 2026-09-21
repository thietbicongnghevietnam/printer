// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaterialResponseModel _$MaterialResponseModelFromJson(
        Map<String, dynamic> json) =>
    MaterialResponseModel(
      receivingCardDetailID: (json['receivingCardDetailID'] as num).toInt(),
      receivingCardID: (json['receivingCardID'] as num).toInt(),
      barcode: json['barcode'] as String,
      codeDate: json['codeDate'] as String?,
      unitNo: json['unitNo'] as String?,
      totalQuantity: (json['totalQuantity'] as num).toInt(),
      currentQuantity: (json['currentQuantity'] as num).toInt(),
      lotNo: json['lotNo'] as String?,
      material: json['material'] as String,
    );

Map<String, dynamic> _$MaterialResponseModelToJson(
        MaterialResponseModel instance) =>
    <String, dynamic>{
      'receivingCardDetailID': instance.receivingCardDetailID,
      'receivingCardID': instance.receivingCardID,
      'barcode': instance.barcode,
      'codeDate': instance.codeDate,
      'unitNo': instance.unitNo,
      'totalQuantity': instance.totalQuantity,
      'currentQuantity': instance.currentQuantity,
      'lotNo': instance.lotNo,
      'material': instance.material,
    };
