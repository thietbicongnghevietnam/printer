import 'package:json_annotation/json_annotation.dart';

import 'base_response_model.dart';
import 'kitting_response_model.dart';

part 'map_trolley_response_model.g.dart';

@JsonSerializable()
class MapTrolleyResponsesModel extends BaseResponseModel {
  MapTrolleyResponsesModel({
    this.content,
    this.contentType,
  });

  factory MapTrolleyResponsesModel.fromJson(Map<String, dynamic> json) =>
      _$MapTrolleyResponsesModelFromJson(json);

  final String? content;

  final String? contentType;

  @override
  Map<String, dynamic> toJson() => _$MapTrolleyResponsesModelToJson(this);
}
