import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_request_model.dart';

part 'input_trolley_request_model.g.dart';

@JsonSerializable()
class InputTrolleyRequestModel extends BaseRequestModel  {
  const InputTrolleyRequestModel({
    required this.kittingList,
    required this.trolley,
  });

  factory InputTrolleyRequestModel.fromJson(Map<String, dynamic> json) =>
      _$InputTrolleyRequestModelFromJson(json);

  @JsonKey(name: 'barCodeKittingList')
  final List<String> kittingList;

  @JsonKey(name: 'barCodeTrolley')
  final List<String> trolley;

  @override
  Map<String, dynamic> toJson() => _$InputTrolleyRequestModelToJson(this);
}
