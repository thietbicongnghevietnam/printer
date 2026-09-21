// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'zone_rack_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ZoneRackResponseModel _$ZoneRackResponseModelFromJson(
        Map<String, dynamic> json) =>
    ZoneRackResponseModel(
      offSetX: (json['offSetX'] as num?)?.toDouble(),
      offSetY: (json['offSetY'] as num?)?.toDouble(),
      rackStatus: (json['rackStatus'] as num?)?.toInt(),
      width: (json['width'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
      rackType: json['rackType'] as String?,
      unitTotal: (json['unitTotal'] as num?)?.toInt(),
      rackRotation: json['rackRotation'] as String?,
      rackID: json['rackID'] as String?,
      rackCode: json['rackCode'] as String?,
    );

Map<String, dynamic> _$ZoneRackResponseModelToJson(
        ZoneRackResponseModel instance) =>
    <String, dynamic>{
      'unitTotal': instance.unitTotal,
      'rackStatus': instance.rackStatus,
      'width': instance.width,
      'height': instance.height,
      'offSetX': instance.offSetX,
      'offSetY': instance.offSetY,
      'rackType': instance.rackType,
      'rackRotation': instance.rackRotation,
      'rackID': instance.rackID,
      'rackCode': instance.rackCode,
    };
