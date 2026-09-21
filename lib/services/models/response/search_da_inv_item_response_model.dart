import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_response_model.dart';

part 'search_da_inv_item_response_model.g.dart';

@JsonSerializable()
class SearchDAInvItemResponseModel extends BaseResponseModel {
  SearchDAInvItemResponseModel(
      this.id,
      this.poItem,
      this.poNo,
      this.deliveryPlanNo,
      this.deliveryPlanItem,
      this.planQuantity,
      this.actualQuantity,
      );

  factory SearchDAInvItemResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SearchDAInvItemResponseModelFromJson(json);

  final int id;
  final String poNo;
  final String poItem;
  final String deliveryPlanNo;
  final String deliveryPlanItem;
  final int planQuantity;
  final int actualQuantity;

  @override
  Map<String, dynamic> toJson() => _$SearchDAInvItemResponseModelToJson(this);
}
