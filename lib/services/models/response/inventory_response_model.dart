import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_response_model.dart';

part 'inventory_response_model.g.dart';

@JsonSerializable()
class InventoryResponseModel extends BaseResponseModel {
  InventoryResponseModel({
     this.material,
     this.total,
     this.goodReceiptQuantity,
     this.storedQuantity,
     this.movedOutQuantity,
  });
  factory InventoryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$InventoryResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$InventoryResponseModelToJson(this);

  final String? material;
  final int? total;
  final int? goodReceiptQuantity;
  final int? storedQuantity;
  final int? movedOutQuantity;
}
