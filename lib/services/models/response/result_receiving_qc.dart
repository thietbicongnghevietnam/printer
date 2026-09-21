import 'package:json_annotation/json_annotation.dart';

import 'base_response_model.dart';

part 'result_receiving_qc.g.dart';

@JsonSerializable()
class ResultReceivingQCResponsesModel extends BaseResponseModel  {
  ResultReceivingQCResponsesModel({
    this.result,
  });

  factory ResultReceivingQCResponsesModel.fromJson(Map<String, dynamic> json) =>
      _$ResultReceivingQCResponsesModelFromJson(json);

  final int? result;

  @override
  Map<String, dynamic> toJson() => _$ResultReceivingQCResponsesModelToJson(this);
}
