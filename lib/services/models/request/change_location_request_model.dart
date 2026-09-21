import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_request_model.dart';

part 'change_location_request_model.g.dart';

@JsonSerializable()
class ChangeLocationRequestModel extends BaseRequestModel {
  const ChangeLocationRequestModel({
    required this.locationNameOld,
    required this.locationNameNew,
  });

  factory ChangeLocationRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ChangeLocationRequestModelFromJson(json);

  @JsonKey(name: 'locationNameOld')
  final String locationNameOld;

  @JsonKey(name: 'locationNameNew')
  final String locationNameNew;

  @override
  Map<String, dynamic> toJson() => _$ChangeLocationRequestModelToJson(this);
}
