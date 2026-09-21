import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_request_model.dart';

part 'store_recard_jit_request_model.g.dart';

@JsonSerializable()
class StoreReCardJITRequestModel extends BaseRequestModel {
  StoreReCardJITRequestModel({
    required this.zoneName,
    required this.receivingCardIds,
  });

  factory StoreReCardJITRequestModel.fromJson(Map<String, dynamic> json) =>
      _$StoreReCardJITRequestModelFromJson(json);

  final String zoneName;
  final String receivingCardIds;

  @override
  Map<String, dynamic> toJson() => _$StoreReCardJITRequestModelToJson(this);
}
