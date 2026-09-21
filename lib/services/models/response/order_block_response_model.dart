import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/services/models/response/base_response_model.dart';

part 'order_block_response_model.g.dart';

@JsonSerializable()
class OrderBlockResponseModel extends BaseResponseModel {
  const OrderBlockResponseModel({
    this.name,
    this.x,
    this.y,
    this.width,
    this.height,
  });

  factory OrderBlockResponseModel.fromJson(Map<String, dynamic> json) =>
      _$OrderBlockResponseModelFromJson(json);

  final String? name;

  final double? x;
  final double? y;
  final double? width;
  final double? height;

  @override
  Map<String, dynamic> toJson() => _$OrderBlockResponseModelToJson(this);
}
