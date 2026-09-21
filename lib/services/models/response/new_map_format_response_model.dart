import 'package:json_annotation/json_annotation.dart';

import 'base_response_model.dart';

part 'new_map_format_response_model.g.dart';

@JsonSerializable()
class NewMapFormatResponseModel extends BaseResponseModel {
  NewMapFormatResponseModel({
    this.id,
    this.floorId,
    this.floorName,
  });

  factory NewMapFormatResponseModel.fromJson(Map<String, dynamic> json) =>
      _$NewMapFormatResponseModelFromJson(json);

  final int? id;
  final int? floorId;
  final String? floorName;

  @override
  Map<String, dynamic> toJson() => _$NewMapFormatResponseModelToJson(this);
}
