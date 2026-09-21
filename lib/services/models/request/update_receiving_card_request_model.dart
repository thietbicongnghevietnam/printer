import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/services/models/request/material_request_model.dart';

import 'base_request_model.dart';

part 'update_receiving_card_request_model.g.dart';

@JsonSerializable()
class UpdateReceivingCardRequestModel extends BaseRequestModel {
  const UpdateReceivingCardRequestModel(
    this.receivingCardId,
    this.quantity,
    this.box,
    this.lstIdDetailDelete,
    this.lstReceivingCardDetail,
  );

  factory UpdateReceivingCardRequestModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateReceivingCardRequestModelFromJson(json);

  final int receivingCardId;
  final int quantity;
  final int box;
  final List<int> lstIdDetailDelete;
  final List<MaterialRequestModel>? lstReceivingCardDetail;

  @override
  Map<String, dynamic> toJson() =>
      _$UpdateReceivingCardRequestModelToJson(this);
}
