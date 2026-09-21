import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_request_model.dart';

part 'create_trolleykitting_request_model.g.dart';

@JsonSerializable()
class CreateTrolleyKittingRequestModel extends BaseRequestModel  {
  const CreateTrolleyKittingRequestModel({
    this.kittingList = const [],
    required this.trolley,
  });

  factory CreateTrolleyKittingRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CreateTrolleyKittingRequestModelFromJson(json);

  @JsonKey(name: 'barCodeKittingList')
  final List<String> kittingList;

  @JsonKey(name: 'barCodeTrolley')
  final String trolley;

  @override
  Map<String, dynamic> toJson() => _$CreateTrolleyKittingRequestModelToJson(this);
}
