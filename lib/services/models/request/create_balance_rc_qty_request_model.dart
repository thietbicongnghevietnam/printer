import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_request_model.dart';

part 'create_balance_rc_qty_request_model.g.dart';

@JsonSerializable()
class BalanceRcDataRequestModel extends BaseRequestModel {
  const BalanceRcDataRequestModel({
    this.isAll = false,
    this.balanceParents = const [],
  });

  factory BalanceRcDataRequestModel.fromJson(Map<String, dynamic> json) =>
      _$BalanceRcDataRequestModelFromJson(json);

  final bool isAll;

  final List<BalanceParentsRequestModel> balanceParents;

  @override
  Map<String, dynamic> toJson() => _$BalanceRcDataRequestModelToJson(this);
}

@JsonSerializable()
class BalanceParentsRequestModel extends BaseRequestModel {
  const BalanceParentsRequestModel({
    this.quantity = 0,
    this.barcode,
    this.balanceBoxs = const [],
  });

  factory BalanceParentsRequestModel.fromJson(Map<String, dynamic> json) =>
      _$BalanceParentsRequestModelFromJson(json);

  final int quantity;

  final String? barcode;

  final List<BalanceBoxRequestModel> balanceBoxs;

  @override
  Map<String, dynamic> toJson() => _$BalanceParentsRequestModelToJson(this);
}

@JsonSerializable()
class BalanceBoxRequestModel extends BaseRequestModel {
  const BalanceBoxRequestModel({
    this.quantity,
    this.id,
  });

  factory BalanceBoxRequestModel.fromJson(Map<String, dynamic> json) =>
      _$BalanceBoxRequestModelFromJson(json);

  final int? id;
  final int? quantity;


  @override
  Map<String, dynamic> toJson() => _$BalanceBoxRequestModelToJson(this);
}
