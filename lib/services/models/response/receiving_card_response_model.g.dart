// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receiving_card_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceivingCardResponseModel _$ReceivingCardResponseModelFromJson(
        Map<String, dynamic> json) =>
    ReceivingCardResponseModel(
      qtyDAInv: (json['qtyDAInv'] as num?)?.toInt(),
      status: (json['status'] as num?)?.toInt(),
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
      receivingCardDate: json['receivingCardDate'] == null
          ? null
          : DateTime.parse(json['receivingCardDate'] as String),
      vendorCode: json['vendorCode'] as String?,
      vendorName: json['vendorName'] as String?,
      sloc: json['sloc'] as String?,
      barcode: json['barcode'] as String?,
      temporaryAreaCode: json['temporaryAreaCode'] as String?,
      haveBarcode: json['haveBarcode'] as bool?,
      receivingCardDetails: (json['receivingCardDetails'] as List<dynamic>?)
          ?.map(
              (e) => MaterialResponseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      daInvId: (json['daInvId'] as num?)?.toInt(),
      category: json['category'] as String?,
      daInvDetailId: (json['daInvDetailId'] as num?)?.toInt(),
      isSpecial: json['isSpecial'] as bool? ?? false,
      inforLastLot: json['inforLastLot'] == null
          ? null
          : InfoLastLotResponseModel.fromJson(
              json['inforLastLot'] as Map<String, dynamic>),
      location: json['location'] as String?,
      isOverdue: json['isOverdue'] as bool? ?? false,
      isNG: json['isNG'] as bool? ?? false,
    );

Map<String, dynamic> _$ReceivingCardResponseModelToJson(
        ReceivingCardResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
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
      'daInvId': instance.daInvId,
      'daInvNo': instance.daInvNo,
      'reason': instance.reason,
      'pl': instance.pl,
      'rohs': instance.rohs,
      'receivingCardDate': instance.receivingCardDate?.toIso8601String(),
      'vendorCode': instance.vendorCode,
      'vendorName': instance.vendorName,
      'sloc': instance.sloc,
      'barcode': instance.barcode,
      'temporaryAreaCode': instance.temporaryAreaCode,
      'haveBarcode': instance.haveBarcode,
      'category': instance.category,
      'receivingCardDetails': instance.receivingCardDetails,
      'qtyDAInv': instance.qtyDAInv,
      'daInvDetailId': instance.daInvDetailId,
      'isSpecial': instance.isSpecial,
      'isNG': instance.isNG,
      'inforLastLot': instance.inforLastLot,
      'location': instance.location,
      'isOverdue': instance.isOverdue,
    };
