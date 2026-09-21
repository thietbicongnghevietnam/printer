import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_request_model.dart';

part 'move_out_all_storage_request_model.g.dart';

@JsonSerializable()
class MoveOutAllStoreRequestModel extends BaseRequestModel {
  const MoveOutAllStoreRequestModel({
    this.locationName,
    this.reasonOutStorage,
  });

  factory MoveOutAllStoreRequestModel.fromJson(Map<String, dynamic> json) =>
      _$MoveOutAllStoreRequestModelFromJson(json);

  @JsonKey(name: 'locationName')
  final String? locationName;

  @JsonKey(name: 'reasonOutStorage')
  final String? reasonOutStorage;

  @override
  Map<String, dynamic> toJson() => _$MoveOutAllStoreRequestModelToJson(this);
}
