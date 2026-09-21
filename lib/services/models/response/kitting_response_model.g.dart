// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kitting_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KittingResponseModel _$KittingResponseModelFromJson(
        Map<String, dynamic> json) =>
    KittingResponseModel(
      id: (json['id'] as num?)?.toInt(),
      createdDate: json['createdDate'] == null
          ? null
          : DateTime.parse(json['createdDate'] as String),
      createdBy: json['createdBy'] as String?,
      updatedDate: json['updatedDate'] == null
          ? null
          : DateTime.parse(json['updatedDate'] as String),
      updateBy: json['updateBy'] as String?,
      plant: json['plant'] as String?,
      reservationNo: json['reservationNo'] as String?,
      line: json['line'] as String?,
      time: json['time'] as String?,
      model: json['model'] as String?,
      modelQuantity: (json['modelQuantity'] as num?)?.toInt(),
      deliverydate: json['deliverydate'] == null
          ? null
          : DateTime.parse(json['deliverydate'] as String),
      category: json['category'] as String?,
      barcode: json['barcode'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      kittingType: (json['kittingType'] as num?)?.toInt(),
      kittingTimeType: json['kittingTimeType'] as String?,
      status: (json['status'] as num?)?.toInt(),
    );

Map<String, dynamic> _$KittingResponseModelToJson(
        KittingResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdDate': instance.createdDate?.toIso8601String(),
      'createdBy': instance.createdBy,
      'updatedDate': instance.updatedDate?.toIso8601String(),
      'updateBy': instance.updateBy,
      'plant': instance.plant,
      'reservationNo': instance.reservationNo,
      'line': instance.line,
      'time': instance.time,
      'model': instance.model,
      'modelQuantity': instance.modelQuantity,
      'deliverydate': instance.deliverydate?.toIso8601String(),
      'category': instance.category,
      'barcode': instance.barcode,
      'quantity': instance.quantity,
      'kittingType': instance.kittingType,
      'kittingTimeType': instance.kittingTimeType,
      'status': instance.status,
    };
