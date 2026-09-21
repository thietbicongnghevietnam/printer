import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_request_model.dart';

part 'move_out_store_request_model.g.dart';

@JsonSerializable()
class MoveOutStoreRequestModel extends BaseRequestModel {
  const MoveOutStoreRequestModel({
    this.receivingCardId,
    this.reasonOutStorage,
  });

  factory MoveOutStoreRequestModel.fromJson(Map<String, dynamic> json) =>
      _$MoveOutStoreRequestModelFromJson(json);

  @JsonKey(name: 'receivingCardId')
  final int? receivingCardId;

  @JsonKey(name: 'reasonOutStorage')
  final String? reasonOutStorage;

  @override
  Map<String, dynamic> toJson() => _$MoveOutStoreRequestModelToJson(this);
}
