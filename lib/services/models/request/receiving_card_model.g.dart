// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receiving_card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceivingCardModel _$ReceivingCardModelFromJson(Map<String, dynamic> json) =>
    ReceivingCardModel(
      status: (json['status'] as num?)?.toInt(),
      createdDate: json['createdDate'] as String?,
      createdBy: json['createdBy'] as String?,
      updatedDate: json['updatedDate'] as String?,
      updatedBy: json['updatedBy'] as String?,
      receivingCardID: (json['receivingCardID'] as num?)?.toInt(),
      receivingType: (json['receivingType'] as num?)?.toInt(),
      samplingCheck: (json['samplingCheck'] as num?)?.toInt(),
      rohsCheck: (json['rohsCheck'] as num?)?.toInt(),
      daInvDetailID: (json['daInvDetailID'] as num?)?.toInt(),
      totalQuantity: (json['totalQuantity'] as num?)?.toInt(),
      currentQuantity: (json['currentQuantity'] as num?)?.toInt(),
      boxQuantity: (json['boxQuantity'] as num?)?.toInt(),
      plant: json['plant'] as String?,
      receivingCardTime: json['receivingCardTime'] as String?,
      urgent: json['urgent'] as String?,
      ulcoc: json['ulcoc'] as String?,
      material: json['material'] as String?,
      materialType: json['materialType'] as String?,
      materialFrequency: json['materialFrequency'] as String?,
      codeDate: json['codeDate'] as String?,
      daInvNo: json['daInvNo'] as String?,
      reason: json['reason'] as String?,
      pl: json['pl'] as String?,
      rohs: json['rohs'] as String?,
      receivingCardDate: json['receivingCardDate'] as String?,
      vendorCode: json['vendorCode'] as String?,
      sloc: json['sloc'] as String?,
      barcode: json['barcode'] as String?,
      temporaryAreaCode: json['temporaryAreaCode'] as String?,
      category: json['category'] as String?,
      venderName: json['venderName'] as String?,
    );

Map<String, dynamic> _$ReceivingCardModelToJson(ReceivingCardModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'createdDate': instance.createdDate,
      'createdBy': instance.createdBy,
      'updatedDate': instance.updatedDate,
      'updatedBy': instance.updatedBy,
      'receivingCardID': instance.receivingCardID,
      'receivingType': instance.receivingType,
      'samplingCheck': instance.samplingCheck,
      'rohsCheck': instance.rohsCheck,
      'daInvDetailID': instance.daInvDetailID,
      'totalQuantity': instance.totalQuantity,
      'currentQuantity': instance.currentQuantity,
      'boxQuantity': instance.boxQuantity,
      'plant': instance.plant,
      'receivingCardTime': instance.receivingCardTime,
      'urgent': instance.urgent,
      'ulcoc': instance.ulcoc,
      'material': instance.material,
      'materialType': instance.materialType,
      'materialFrequency': instance.materialFrequency,
      'codeDate': instance.codeDate,
      'daInvNo': instance.daInvNo,
      'reason': instance.reason,
      'pl': instance.pl,
      'rohs': instance.rohs,
      'receivingCardDate': instance.receivingCardDate,
      'vendorCode': instance.vendorCode,
      'sloc': instance.sloc,
      'barcode': instance.barcode,
      'temporaryAreaCode': instance.temporaryAreaCode,
      'category': instance.category,
      'venderName': instance.venderName,
    };
