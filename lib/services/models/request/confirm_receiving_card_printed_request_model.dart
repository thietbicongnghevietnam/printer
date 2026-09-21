import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/services/models/request/material_request_model.dart';

import 'base_request_model.dart';

part 'confirm_receiving_card_printed_request_model.g.dart';

@JsonSerializable()
class ConfirmReceivingCardPrintedRequestModel extends BaseRequestModel {
  const ConfirmReceivingCardPrintedRequestModel({
    required this.id,
    this.status = 0,
  });

  factory ConfirmReceivingCardPrintedRequestModel.fromJson(
          Map<String, dynamic> json) =>
      _$ConfirmReceivingCardPrintedRequestModelFromJson(json);

  final int id;
  final int status;

  @override
  Map<String, dynamic> toJson() =>
      _$ConfirmReceivingCardPrintedRequestModelToJson(this);
}
