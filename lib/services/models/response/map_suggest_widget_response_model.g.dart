// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_suggest_widget_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapSuggestWidgetResponseModel _$MapSuggestWidgetResponseModelFromJson(
        Map<String, dynamic> json) =>
    MapSuggestWidgetResponseModel(
      floorId: (json['floorId'] as num?)?.toInt(),
      swmsZones: (json['swmsZones'] as List<dynamic>?)
          ?.map((e) => ZoneSuggestWidgetResponseModel.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      isSuggested: json['isSuggested'] as bool? ?? false,
      totalStoredQty: (json['totalStoredQty'] as num?)?.toInt(),
      floorName: json['floorName'] as String?,
      lastLotName: json['lastLotName'] as String?,
      totalTemp: (json['totalTemp'] as num?)?.toInt(),
      floorCode: json['floorCode'] as String?,
    );

Map<String, dynamic> _$MapSuggestWidgetResponseModelToJson(
        MapSuggestWidgetResponseModel instance) =>
    <String, dynamic>{
      'floorId': instance.floorId,
      'totalStoredQty': instance.totalStoredQty,
      'totalTemp': instance.totalTemp,
      'isSuggested': instance.isSuggested,
      'floorName': instance.floorName,
      'floorCode': instance.floorCode,
      'lastLotName': instance.lastLotName,
      'swmsZones': instance.swmsZones,
    };

ZoneSuggestWidgetResponseModel _$ZoneSuggestWidgetResponseModelFromJson(
        Map<String, dynamic> json) =>
    ZoneSuggestWidgetResponseModel(
      zoneId: (json['zoneId'] as num?)?.toInt(),
      isSuggested: json['isSuggested'] as bool?,
      totalStoredQty: (json['totalStoredQty'] as num?)?.toInt(),
      totalTemp: (json['totalTemp'] as num?)?.toInt(),
      lastLotName: json['lastLotName'] as String?,
      isJIT: json['isJIT'] as bool?,
      swmsRacks: (json['swmsRacks'] as List<dynamic>?)
          ?.map((e) => RackSuggestWidgetResponseModel.fromJson(
              e as Map<String, dynamic>))
          .toList(),
      isDIP: json['isDIP'] as bool?,
    );

Map<String, dynamic> _$ZoneSuggestWidgetResponseModelToJson(
        ZoneSuggestWidgetResponseModel instance) =>
    <String, dynamic>{
      'zoneId': instance.zoneId,
      'totalStoredQty': instance.totalStoredQty,
      'totalTemp': instance.totalTemp,
      'isJIT': instance.isJIT,
      'isSuggested': instance.isSuggested,
      'isDIP': instance.isDIP,
      'lastLotName': instance.lastLotName,
      'swmsRacks': instance.swmsRacks,
    };

RackSuggestWidgetResponseModel _$RackSuggestWidgetResponseModelFromJson(
        Map<String, dynamic> json) =>
    RackSuggestWidgetResponseModel(
      rackId: (json['rackId'] as num?)?.toInt(),
      rackDetailType: json['rackDetailType'] as String?,
      isSuggested: json['isSuggested'] as bool?,
      lastLotName: json['lastLotName'] as String?,
      isJIT: json['isJIT'] as bool?,
    );

Map<String, dynamic> _$RackSuggestWidgetResponseModelToJson(
        RackSuggestWidgetResponseModel instance) =>
    <String, dynamic>{
      'rackId': instance.rackId,
      'isSuggested': instance.isSuggested,
      'isJIT': instance.isJIT,
      'lastLotName': instance.lastLotName,
      'rackDetailType': instance.rackDetailType,
    };
