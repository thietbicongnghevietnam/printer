import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_request_model.dart';

part 'combine_location_request_model.g.dart';

@JsonSerializable()
class CombineLocationRequestModel extends BaseRequestModel {
  const CombineLocationRequestModel({
    required this.receivingCardIds,
    required this.locationNameNew,
  });

  factory CombineLocationRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CombineLocationRequestModelFromJson(json);

  @JsonKey(name: 'receivingCardIds')
  final String receivingCardIds;

  @JsonKey(name: 'locationNameNew')
  final String locationNameNew;

  @override
  Map<String, dynamic> toJson() => _$CombineLocationRequestModelToJson(this);
}
