import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_request_model.dart';

part 'store_recard_request_model.g.dart';

@JsonSerializable()
class StoreReCardRequestModel extends BaseRequestModel {
  StoreReCardRequestModel({
    required this.location,
    required this.receivingCardId,
  });

  factory StoreReCardRequestModel.fromJson(Map<String, dynamic> json) =>
      _$StoreReCardRequestModelFromJson(json);

  final String location;
  final int receivingCardId;

  @override
  Map<String, dynamic> toJson() => _$StoreReCardRequestModelToJson(this);
}
