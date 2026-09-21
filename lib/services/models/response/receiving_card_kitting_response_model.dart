import 'package:json_annotation/json_annotation.dart';

import 'base_response_model.dart';

part 'receiving_card_kitting_response_model.g.dart';

@JsonSerializable()
class ReceivingCardKittingResponsesModel extends BaseResponseModel  {
  ReceivingCardKittingResponsesModel({
    this.rcid, this.locationName, this.material,
  });

  factory ReceivingCardKittingResponsesModel.fromJson(Map<String, dynamic> json) =>
      _$ReceivingCardKittingResponsesModelFromJson(json);

  final int? rcid;
  final String? locationName;
  final String? material;

  @override
  Map<String, dynamic> toJson() => _$ReceivingCardKittingResponsesModelToJson(this);
}
