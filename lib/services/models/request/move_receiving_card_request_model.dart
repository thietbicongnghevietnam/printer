import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_request_model.dart';

part 'move_receiving_card_request_model.g.dart';

@JsonSerializable()
class MoveReceivingCardRequestModel extends BaseRequestModel  {
  const MoveReceivingCardRequestModel({
    required this.temporaryAreaCodeOld,
    required this.temporaryAreaCodeNew,
  });

  factory MoveReceivingCardRequestModel.fromJson(Map<String, dynamic> json) =>
      _$MoveReceivingCardRequestModelFromJson(json);

  @JsonKey(name: 'temporaryAreaCodeOld')
  final String temporaryAreaCodeOld;

  @JsonKey(name: 'temporaryAreaCodeNew')
  final String temporaryAreaCodeNew;

  @override
  Map<String, dynamic> toJson() => _$MoveReceivingCardRequestModelToJson(this);
}
