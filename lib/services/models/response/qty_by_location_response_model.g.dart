// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qty_by_location_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QtyByLocationResponseModel _$QtyByLocationResponseModelFromJson(
        Map<String, dynamic> json) =>
    QtyByLocationResponseModel(
      name: json['name'] as String?,
      totalQty: (json['totalQty'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$QtyByLocationResponseModelToJson(
        QtyByLocationResponseModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'totalQty': instance.totalQty,
    };
