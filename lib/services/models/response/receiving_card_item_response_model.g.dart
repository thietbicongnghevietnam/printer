// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'receiving_card_item_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReceivingCardItemResponseModel _$ReceivingCardItemResponseModelFromJson(
        Map<String, dynamic> json) =>
    ReceivingCardItemResponseModel(
      status: (json['status'] as num?)?.toInt(),
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      createdBy: json['createdBy'] as String?,
      updatedDate: json['updatedDate'] == null
          ? null
          : DateTime.parse(json['updatedDate'] as String),
      updatedBy: json['updatedBy'] as String?,
      receivingCardDetailID: (json['receivingCardDetailID'] as num?)?.toInt(),
      receivingCardID: (json['receivingCardID'] as num?)?.toInt(),
      material: json['material'] as String,
      barcode: json['barcode'] as String,
      dateCode: json['dateCode'] as String?,
      unitNo: json['unitNo'] as String,
      totalQuantity: (json['totalQuantity'] as num?)?.toInt(),
      currentQuantity: (json['currentQuantity'] as num).toInt(),
      lotNo: json['lotNo'] as String?,
      isPOPending: json['isPOPending'] as bool?,
      daInvoiceItemDetailID: (json['daInvoiceItemDetailID'] as num?)?.toInt(),
      location: json['location'] as String?,
      isOverdue: json['isOverdue'] as bool? ?? false,
    );

Map<String, dynamic> _$ReceivingCardItemResponseModelToJson(
        ReceivingCardItemResponseModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'createdDate': instance.createdDate?.toIso8601String(),
      'createdBy': instance.createdBy,
      'updatedDate': instance.updatedDate?.toIso8601String(),
      'updatedBy': instance.updatedBy,
      'receivingCardDetailID': instance.receivingCardDetailID,
      'receivingCardID': instance.receivingCardID,
      'material': instance.material,
      'barcode': instance.barcode,
      'dateCode': instance.dateCode,
      'unitNo': instance.unitNo,
      'totalQuantity': instance.totalQuantity,
      'currentQuantity': instance.currentQuantity,
      'lotNo': instance.lotNo,
      'isPOPending': instance.isPOPending,
      'daInvoiceItemDetailID': instance.daInvoiceItemDetailID,
      'location': instance.location,
      'isOverdue': instance.isOverdue,
    };
