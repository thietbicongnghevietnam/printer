// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'layer_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LayerDetailResponseModel _$LayerDetailResponseModelFromJson(
        Map<String, dynamic> json) =>
    LayerDetailResponseModel(
      blockName: json['name'] as String?,
      blockId: (json['blockId'] as num?)?.toInt(),
      isStored: json['isStored'] as bool?,
      lastLot: (json['lastLot'] as num?)?.toInt(),
      lastNodeName: json['lastNodeName'] as String? ?? '',
      pl: json['pl'] as String?,
    );

Map<String, dynamic> _$LayerDetailResponseModelToJson(
        LayerDetailResponseModel instance) =>
    <String, dynamic>{
      'blockId': instance.blockId,
      'lastLot': instance.lastLot,
      'name': instance.blockName,
      'isStored': instance.isStored,
      'lastNodeName': instance.lastNodeName,
      'pl': instance.pl,
    };
