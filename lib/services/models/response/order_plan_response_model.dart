import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/services/models/response/base_response_model.dart';

part 'order_plan_response_model.g.dart';

@JsonSerializable()
class OrderPlanResponseModel extends BaseResponseModel {
  const OrderPlanResponseModel(
    this.planOrderNumber,
    this.plant,
    this.material,
    this.sloc,
    this.planOrderQuantity,
    this.grQuantity,
    this.postingDate,
  );

  factory OrderPlanResponseModel.fromJson(Map<String, dynamic> json) =>
      _$OrderPlanResponseModelFromJson(json);

  final String planOrderNumber;
  final String plant;
  final String material;
  final String sloc;
  final int planOrderQuantity;
  final int grQuantity;
  final String? postingDate;

  @override
  Map<String, dynamic> toJson() => _$OrderPlanResponseModelToJson(this);
}
