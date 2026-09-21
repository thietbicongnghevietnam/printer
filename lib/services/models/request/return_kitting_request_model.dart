import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/services/models/request/base_request_model.dart';

part 'return_kitting_request_model.g.dart';

@JsonSerializable()
class ReturnKittingRequestModel extends BaseRequestModel {
  ReturnKittingRequestModel({
    this.isPreview,
    this.quantity,
    this.barcode,
    this.returnKittingType,
    this.material,
    this.plant,
    this.sloc,
    this.category,
  });

  factory ReturnKittingRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ReturnKittingRequestModelFromJson(json);

  final List<String>? barcode;
  final int? quantity;
  final bool? isPreview;
  final String? returnKittingType;
  final String? material;
  final String? plant;
  final String? sloc;
  final String? category;

  @override
  Map<String, dynamic> toJson() => _$ReturnKittingRequestModelToJson(this);
}
