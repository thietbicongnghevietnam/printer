import 'package:json_annotation/json_annotation.dart';
import 'package:smart_warehouse/services/models/request/receiving_card_model.dart';

import 'base_response_model.dart';

part 'ta_response_model.g.dart';

@JsonSerializable()
class TAResponsesModel extends BaseResponseModel  {
  TAResponsesModel({
    this.status,
    this.data,
    this.message,
  });

  factory TAResponsesModel.fromJson(Map<String, dynamic> json) =>
      _$TAResponsesModelFromJson(json);

  final int? status;
  final List<ReceivingCardModel>? data;
  final String? message;

  @override
  Map<String, dynamic> toJson() => _$TAResponsesModelToJson(this);
}
