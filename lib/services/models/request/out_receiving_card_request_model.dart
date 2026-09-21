import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_request_model.dart';

part 'out_receiving_card_request_model.g.dart';

@JsonSerializable()
class OutReceivingCardRequestModel extends BaseRequestModel {
  const OutReceivingCardRequestModel({
    this.barcode,
  });

  factory OutReceivingCardRequestModel.fromJson(Map<String, dynamic> json) =>
      _$OutReceivingCardRequestModelFromJson(json);

  @JsonKey(name: 'barcode')
  final String? barcode;

  @override
  Map<String, dynamic> toJson() => _$OutReceivingCardRequestModelToJson(this);
}
