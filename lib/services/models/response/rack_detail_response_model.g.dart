// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rack_detail_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RackDetailResponseModel _$RackDetailResponseModelFromJson(
        Map<String, dynamic> json) =>
    RackDetailResponseModel(
      rackId: (json['rackID'] as num?)?.toInt(),
      rackCode: json['rackCode'] as String?,
      columnRackData: (json['columnRackData'] as List<dynamic>?)
          ?.map((e) =>
              ColumnRackResponseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      numberOfLayer: (json['numberOfLayer'] as num?)?.toInt(),
      numberOfUnit: (json['numberOfUnit'] as num?)?.toInt(),
      numberOfRow: (json['numberOfRow'] as num?)?.toInt(),
      numberOfColumn: (json['numberOfColumn'] as num?)?.toInt(),
      blockList: (json['blocks'] as List<dynamic>?)
          ?.map((e) =>
              BlockDetailResponseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      rackType: json['rackType'] as String?,
      offsetX: (json['x'] as num?)?.toInt(),
      offsetY: (json['y'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      width: (json['width'] as num?)?.toInt(),
      isSuggested: json['isSuggested'] as bool?,
      zoneID: (json['zoneID'] as num?)?.toInt(),
      lastLot: (json['lastLot'] as num?)?.toInt(),
    );

Map<String, dynamic> _$RackDetailResponseModelToJson(
        RackDetailResponseModel instance) =>
    <String, dynamic>{
      'rackCode': instance.rackCode,
      'rackType': instance.rackType,
      'rackID': instance.rackId,
      'zoneID': instance.zoneID,
      'numberOfLayer': instance.numberOfLayer,
      'numberOfUnit': instance.numberOfUnit,
      'numberOfRow': instance.numberOfRow,
      'numberOfColumn': instance.numberOfColumn,
      'lastLot': instance.lastLot,
      'x': instance.offsetX,
      'y': instance.offsetY,
      'height': instance.height,
      'width': instance.width,
      'isSuggested': instance.isSuggested,
      'blocks': instance.blockList,
      'columnRackData': instance.columnRackData,
    };
