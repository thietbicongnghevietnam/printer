import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_response_model.dart';

part 'po_item_response_model.g.dart';

@JsonSerializable()
class POItemResponseModel extends BaseResponseModel {
  const POItemResponseModel(
    this.poItem,
    this.material,
    this.totalQuantity,
    this.gredQuantity,
    this.poNo,
  );

  factory POItemResponseModel.fromJson(Map<String, dynamic> json) =>
      _$POItemResponseModelFromJson(json);

  final String poNo;
  final String poItem;
  final String material;
  final int totalQuantity;
  final int gredQuantity;

  @override
  Map<String, dynamic> toJson() => _$POItemResponseModelToJson(this);
}
