// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_block_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderBlockResponseModel _$OrderBlockResponseModelFromJson(
        Map<String, dynamic> json) =>
    OrderBlockResponseModel(
      name: json['name'] as String?,
      x: (json['x'] as num?)?.toDouble(),
      y: (json['y'] as num?)?.toDouble(),
      width: (json['width'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$OrderBlockResponseModelToJson(
        OrderBlockResponseModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'x': instance.x,
      'y': instance.y,
      'width': instance.width,
      'height': instance.height,
    };
