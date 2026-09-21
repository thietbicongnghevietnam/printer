import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_request_model.dart';

part 'create_balance_qty_request_model.g.dart';

@JsonSerializable()
class CreateBalanceQtyRequestModel extends BaseRequestModel {
  const CreateBalanceQtyRequestModel({
    this.plant,
    this.sloc,
    this.material,
    this.qtyBalance,
    this.qtySystem,
    this.note,
  });

  factory CreateBalanceQtyRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CreateBalanceQtyRequestModelFromJson(json);

  @JsonKey(name: 'plant')
  final String? plant;

  @JsonKey(name: 'sloc')
  final String? sloc;

  @JsonKey(name: 'material')
  final String? material;
  final String? note;

  final int? qtyBalance;
  final int? qtySystem;

  @override
  Map<String, dynamic> toJson() => _$CreateBalanceQtyRequestModelToJson(this);
}
