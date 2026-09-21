// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receiving_card_by_stock_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceivingCardByStockRequestModel _$ReceivingCardByStockRequestModelFromJson(
        Map<String, dynamic> json) =>
    ReceivingCardByStockRequestModel(
      receivingCardTime: json['receivingCardTime'] as String?,
      plant: json['plant'] as String?,
      receivingCardDate: json['receivingCardDate'] as String?,
      urgent: json['urgent'] as String?,
      ulcoc: json['ulcoc'] as String?,
      material: json['material'] as String?,
      materialType: json['materialType'] as String?,
      materialFrequency: json['materialFrequency'] as String?,
      daInvNo: json['daInvNo'] as String?,
      vendorCode: json['vendorCode'] as String?,
      category: json['category'] as String?,
      totalQuantity: (json['totalQuantity'] as num?)?.toInt(),
      currentQuantity: (json['currentQuantity'] as num?)?.toInt(),
      pl: json['pl'] as String?,
      rohs: json['rohs'] as String?,
      sloc: json['sloc'] as String?,
      vendorName: json['vendorName'] as String?,
      samplingCheck: (json['samplingCheck'] as num?)?.toInt(),
      rohsCheck: (json['rohsCheck'] as num?)?.toInt(),
      box: (json['box'] as num?)?.toInt(),
      listMaterial: (json['listMaterial'] as List<dynamic>?)
          ?.map((e) => MaterialRequestModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      barcodeStockCard: json['barcodeStockCard'] as String?,
    );

Map<String, dynamic> _$ReceivingCardByStockRequestModelToJson(
        ReceivingCardByStockRequestModel instance) =>
    <String, dynamic>{
      'totalQuantity': instance.totalQuantity,
      'currentQuantity': instance.currentQuantity,
      'samplingCheck': instance.samplingCheck,
      'rohsCheck': instance.rohsCheck,
      'box': instance.box,
      'receivingCardTime': instance.receivingCardTime,
      'plant': instance.plant,
      'receivingCardDate': instance.receivingCardDate,
      'urgent': instance.urgent,
      'ulcoc': instance.ulcoc,
      'material': instance.material,
      'materialType': instance.materialType,
      'materialFrequency': instance.materialFrequency,
      'daInvNo': instance.daInvNo,
      'vendorCode': instance.vendorCode,
      'category': instance.category,
      'pl': instance.pl,
      'rohs': instance.rohs,
      'sloc': instance.sloc,
      'vendorName': instance.vendorName,
      'barcodeStockCard': instance.barcodeStockCard,
      'listMaterial': instance.listMaterial,
    };
