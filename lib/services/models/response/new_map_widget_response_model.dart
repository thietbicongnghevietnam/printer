import 'package:json_annotation/json_annotation.dart';

import 'base_response_model.dart';
import 'suggest_path_response_model.dart';

part 'new_map_widget_response_model.g.dart';

@JsonSerializable()
class BoundingBoxResponse {

  BoundingBoxResponse({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  });

  // Chuyển đổi từ JSON sang đối tượng Dart
  factory BoundingBoxResponse.fromJson(Map<String, dynamic> json) => _$BoundingBoxResponseFromJson(json);
  final double x;
  final double y;
  final double width;
  final double height;

  // Chuyển đổi từ đối tượng Dart sang JSON
  Map<String, dynamic> toJson() => _$BoundingBoxResponseToJson(this);
}

@JsonSerializable()
class NewMapWidgetResponseModel extends BaseResponseModel {
  NewMapWidgetResponseModel( {
    this.floorId,
    this.floorName,
    this.id,
    this.fontSize,
    this.type,
    this.status,
    this.boundingBox,
    this.radius,
    this.x,
    this.y,
    this.borderWidth,
    this.scaleX,
    this.scaleY,
    this.border,
    this.fill,
    this.label,
    this.rotation,
    this.points,
    this.widgets,
    this.width,
    this.height,
    this.linkID,
    this.parentID,
    this.level,
    this.text,
    this.createdDate,
    this.createdBy,
    this.updatedDate,
    this.updatedBy,
    this.isLock,
    this.isJIT,
    this.isSuggested,
    this.zoneId,
    this.zoneName,
    this.rackCode,
    this.category,
    this.rackType,
    this.rackTypeDetail,
    this.numberOfUnit,
    this.numberOfLayer,
    this.rackID,
    this.data,
    this.isDIP,
    this.pl,
  });

  factory NewMapWidgetResponseModel.fromJson(Map<String, dynamic> json) =>
      _$NewMapWidgetResponseModelFromJson(json);

  final int? id;
  final int? fontSize;
  final int? type;
  final int? status;
  final int? radius;
  final int? linkID;
  final int? parentID;
  final int? level;

  final double? x;
  final double? y;
  final double? borderWidth;
  final double? scaleX;
  final double? scaleY;
  final double? rotation;
  final double? width;
  final double? height;

  final String? border;
  final String? fill;
  final String? label;
  final String? text;
  final String? createdDate;
  final String? createdBy;
  final String? updatedDate;
  final String? updatedBy;

  final bool? isLock;
  final bool? isJIT;
  final bool? isSuggested;

  // Floor Info
  final int? floorId;
  final String? floorName;

  // Zone Info
  final int? zoneId;
  final String? zoneName;
  final bool? isDIP;

  // Rack Info
  final int? rackID;
  final String? rackCode;
  final String? category;
  final String? rackType;
  final String? rackTypeDetail;
  final String? pl;
  final int? numberOfUnit;
  final int? numberOfLayer;

  final String? data;

  final List<SuggestPathResponseModel>? points;
  final List<NewMapWidgetResponseModel>? widgets;

  final BoundingBoxResponse? boundingBox;

  @override
  Map<String, dynamic> toJson() => _$NewMapWidgetResponseModelToJson(this);
}
