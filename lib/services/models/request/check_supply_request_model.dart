import 'package:json_annotation/json_annotation.dart';
import 'package:smart_warehouse/services/models/request/base_request_model.dart';

part 'check_supply_request_model.g.dart';

@JsonSerializable()
class CheckSupplyRequestModel extends BaseRequestModel {

  CheckSupplyRequestModel({
    this.kittingListId,
    this.isSupplyLack,
  });
  factory CheckSupplyRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CheckSupplyRequestModelFromJson(json);

  final int? kittingListId;
  final bool? isSupplyLack;

  @override
  Map<String, dynamic> toJson() => _$CheckSupplyRequestModelToJson(this);
}
