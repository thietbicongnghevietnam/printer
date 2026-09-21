import 'package:json_annotation/json_annotation.dart';

import 'base_response_model.dart';

part 'receiving_card_by_block_response_model.g.dart';

@JsonSerializable()
class ReceivingCardByBlockResponseModel extends BaseResponseModel {
  ReceivingCardByBlockResponseModel({
    this.receivingCardId,
    this.createdDate,
    this.updatedDate,
    this.currentQuantity,
    this.barCode,
  });

  factory ReceivingCardByBlockResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$ReceivingCardByBlockResponseModelFromJson(json);

  final String? createdDate;
  final String? updatedDate;
  final String? barCode;

  @JsonKey(name: 'receivingCardID')
  final int? receivingCardId;
  final int? currentQuantity;

  @override
  Map<String, dynamic> toJson() =>
      _$ReceivingCardByBlockResponseModelToJson(this);
}
