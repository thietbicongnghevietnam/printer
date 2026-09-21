// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_map_widget_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BoundingBoxResponse _$BoundingBoxResponseFromJson(Map<String, dynamic> json) =>
    BoundingBoxResponse(
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
    );

Map<String, dynamic> _$BoundingBoxResponseToJson(
        BoundingBoxResponse instance) =>
    <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
      'width': instance.width,
      'height': instance.height,
    };

NewMapWidgetResponseModel _$NewMapWidgetResponseModelFromJson(
        Map<String, dynamic> json) =>
    NewMapWidgetResponseModel(
      floorId: (json['floorId'] as num?)?.toInt(),
      floorName: json['floorName'] as String?,
      id: (json['id'] as num?)?.toInt(),
      fontSize: (json['fontSize'] as num?)?.toInt(),
      type: (json['type'] as num?)?.toInt(),
      status: (json['status'] as num?)?.toInt(),
      boundingBox: json['boundingBox'] == null
          ? null
          : BoundingBoxResponse.fromJson(
              json['boundingBox'] as Map<String, dynamic>),
      radius: (json['radius'] as num?)?.toInt(),
      x: (json['x'] as num?)?.toDouble(),
      y: (json['y'] as num?)?.toDouble(),
      borderWidth: (json['borderWidth'] as num?)?.toDouble(),
      scaleX: (json['scaleX'] as num?)?.toDouble(),
      scaleY: (json['scaleY'] as num?)?.toDouble(),
      border: json['border'] as String?,
      fill: json['fill'] as String?,
      label: json['label'] as String?,
      rotation: (json['rotation'] as num?)?.toDouble(),
      points: (json['points'] as List<dynamic>?)
          ?.map((e) =>
              SuggestPathResponseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      widgets: (json['widgets'] as List<dynamic>?)
          ?.map((e) =>
              NewMapWidgetResponseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      width: (json['width'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
      linkID: (json['linkID'] as num?)?.toInt(),
      parentID: (json['parentID'] as num?)?.toInt(),
      level: (json['level'] as num?)?.toInt(),
      text: json['text'] as String?,
      createdDate: json['createdDate'] as String?,
      createdBy: json['createdBy'] as String?,
      updatedDate: json['updatedDate'] as String?,
      updatedBy: json['updatedBy'] as String?,
      isLock: json['isLock'] as bool?,
      isJIT: json['isJIT'] as bool?,
      isSuggested: json['isSuggested'] as bool?,
      zoneId: (json['zoneId'] as num?)?.toInt(),
      zoneName: json['zoneName'] as String?,
      rackCode: json['rackCode'] as String?,
      category: json['category'] as String?,
      rackType: json['rackType'] as String?,
      rackTypeDetail: json['rackTypeDetail'] as String?,
      numberOfUnit: (json['numberOfUnit'] as num?)?.toInt(),
      numberOfLayer: (json['numberOfLayer'] as num?)?.toInt(),
      rackID: (json['rackID'] as num?)?.toInt(),
      data: json['data'] as String?,
      isDIP: json['isDIP'] as bool?,
      pl: json['pl'] as String?,
    );

Map<String, dynamic> _$NewMapWidgetResponseModelToJson(
        NewMapWidgetResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'fontSize': instance.fontSize,
      'type': instance.type,
      'status': instance.status,
      'radius': instance.radius,
      'linkID': instance.linkID,
      'parentID': instance.parentID,
      'level': instance.level,
      'x': instance.x,
      'y': instance.y,
      'borderWidth': instance.borderWidth,
      'scaleX': instance.scaleX,
      'scaleY': instance.scaleY,
      'rotation': instance.rotation,
      'width': instance.width,
      'height': instance.height,
      'border': instance.border,
      'fill': instance.fill,
      'label': instance.label,
      'text': instance.text,
      'createdDate': instance.createdDate,
      'createdBy': instance.createdBy,
      'updatedDate': instance.updatedDate,
      'updatedBy': instance.updatedBy,
      'isLock': instance.isLock,
      'isJIT': instance.isJIT,
      'isSuggested': instance.isSuggested,
      'floorId': instance.floorId,
      'floorName': instance.floorName,
      'zoneId': instance.zoneId,
      'zoneName': instance.zoneName,
      'isDIP': instance.isDIP,
      'rackID': instance.rackID,
      'rackCode': instance.rackCode,
      'category': instance.category,
      'rackType': instance.rackType,
      'rackTypeDetail': instance.rackTypeDetail,
      'pl': instance.pl,
      'numberOfUnit': instance.numberOfUnit,
      'numberOfLayer': instance.numberOfLayer,
      'data': instance.data,
      'points': instance.points,
      'widgets': instance.widgets,
      'boundingBox': instance.boundingBox,
    };
