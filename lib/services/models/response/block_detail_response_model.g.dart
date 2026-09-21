// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'block_detail_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BlockDetailResponseModel _$BlockDetailResponseModelFromJson(
        Map<String, dynamic> json) =>
    BlockDetailResponseModel(
      blockName: json['blockName'] as String?,
      blockId: json['blockId'] as String?,
      blockStatus: (json['blockStatus'] as num?)?.toInt(),
      numberOfLayer: (json['numberOfLayer'] as num?)?.toInt(),
      unit: (json['unit'] as num?)?.toInt(),
      listLayers: (json['layers'] as List<dynamic>?)
              ?.map((e) =>
                  LayerDetailResponseModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$BlockDetailResponseModelToJson(
        BlockDetailResponseModel instance) =>
    <String, dynamic>{
      'blockName': instance.blockName,
      'blockId': instance.blockId,
      'blockStatus': instance.blockStatus,
      'numberOfLayer': instance.numberOfLayer,
      'unit': instance.unit,
      'layers': instance.listLayers,
    };
