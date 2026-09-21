import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_response_model.dart';

part 'box_quantity_response_model.g.dart';

@JsonSerializable()
class BoxQuantityResponseModel extends BaseResponseModel {
  const BoxQuantityResponseModel({
    this.material,
    this.barcode,
    this.quantity,
    this.quantityBox,
  });

  factory BoxQuantityResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BoxQuantityResponseModelFromJson(json);

  @JsonKey(name: 'material')
  final String? material;
  @JsonKey(name: 'barcode')
  final String? barcode;

  @JsonKey(name: 'quantity')
  final int? quantity;
  @JsonKey(name: 'quantityBox')
  final int? quantityBox;

  @override
  Map<String, dynamic> toJson() => _$BoxQuantityResponseModelToJson(this);
}
