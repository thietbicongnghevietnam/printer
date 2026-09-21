import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_request_model.dart';

part 'input_location_request_model.g.dart';

@JsonSerializable()
class InputLocationRequestModel extends BaseRequestModel  {
  const InputLocationRequestModel({
    required this.temporaryAreaCode,
    required this.receivingCardIds,
  });

  factory InputLocationRequestModel.fromJson(Map<String, dynamic> json) =>
      _$InputLocationRequestModelFromJson(json);

  @JsonKey(name: 'temporaryAreaCode')
  final String temporaryAreaCode;

  @JsonKey(name: 'receivingCardIds')
  final List<int> receivingCardIds;

  @override
  Map<String, dynamic> toJson() => _$InputLocationRequestModelToJson(this);
}
