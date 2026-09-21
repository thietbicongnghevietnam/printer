import 'package:json_annotation/json_annotation.dart';

import 'base_response_model.dart';

part 'receiving_schedule_response_model.g.dart';

@JsonSerializable()
class ReceivingScheduleResponsesModel extends BaseResponseModel  {
  ReceivingScheduleResponsesModel({
    required this.isBlock,
    this.datePrint,
    this.blockDate,
  });

  factory ReceivingScheduleResponsesModel.fromJson(Map<String, dynamic> json) =>
      _$ReceivingScheduleResponsesModelFromJson(json);

  final bool isBlock;
  final String? datePrint;
  final String? blockDate;

  @override
  Map<String, dynamic> toJson() => _$ReceivingScheduleResponsesModelToJson(this);
}
