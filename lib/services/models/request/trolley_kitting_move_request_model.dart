import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_request_model.dart';

part 'trolley_kitting_move_request_model.g.dart';

@JsonSerializable()
class TrolleyKittingMoveRequestModel extends BaseRequestModel  {
  const TrolleyKittingMoveRequestModel({
    this.trolleyOld,
    this.trolleyNew,
     this.barCodeKittingList = const [],
  });

  factory TrolleyKittingMoveRequestModel.fromJson(Map<String, dynamic> json) =>
      _$TrolleyKittingMoveRequestModelFromJson(json);

  @JsonKey(name: 'barCodeTrolleyOld')
  final String? trolleyOld;

  @JsonKey(name: 'barCodeTrolleyNew')
  final String? trolleyNew;

  @JsonKey(name: 'barCodeKittingList')
  final List<String> barCodeKittingList;

  @override
  Map<String, dynamic> toJson() => _$TrolleyKittingMoveRequestModelToJson(this);
}
