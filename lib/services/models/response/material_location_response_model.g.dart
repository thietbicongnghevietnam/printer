// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material_location_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaterialLocationResponseModel _$MaterialLocationResponseModelFromJson(
        Map<String, dynamic> json) =>
    MaterialLocationResponseModel(
      receivingCardID: (json['receivingCardID'] as num?)?.toInt(),
      material: json['material'] as String?,
      totalCurrentQuantity: (json['totalCurrentQuantity'] as num?)?.toInt(),
      position: json['position'] as String?,
      createdBy: json['createdBy'] as String?,
      createdDate: json['createdDate'] as String?,
      receivingCardTime: json['receivingCardTime'] as String?,
      receivingCardDate: json['receivingCardDate'] as String?,
      sloc: json['sloc'] as String?,
      qtyTemp: (json['qtyTemp'] as num?)?.toInt(),
      qtyKitting: (json['qtyKitting'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MaterialLocationResponseModelToJson(
        MaterialLocationResponseModel instance) =>
    <String, dynamic>{
      'receivingCardID': instance.receivingCardID,
      'material': instance.material,
      'position': instance.position,
      'createdBy': instance.createdBy,
      'createdDate': instance.createdDate,
      'receivingCardTime': instance.receivingCardTime,
      'receivingCardDate': instance.receivingCardDate,
      'sloc': instance.sloc,
      'totalCurrentQuantity': instance.totalCurrentQuantity,
      'qtyTemp': instance.qtyTemp,
      'qtyKitting': instance.qtyKitting,
    };
