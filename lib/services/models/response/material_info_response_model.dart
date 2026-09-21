import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/services/models/response/base_response_model.dart';

part 'material_info_response_model.g.dart';

@JsonSerializable()
class MaterialInfoResponseModel extends BaseResponseModel {
  const MaterialInfoResponseModel(
    this.urgent,
    this.samplingCheck,
    this.rohsCheck,
    this.material,
    this.rosh,
    this.iqcpl,
    this.type,
    this.frequency,
    this.qtyStandardPacking,
    this.typeSloc,
    this.category,
  );

  factory MaterialInfoResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MaterialInfoResponseModelFromJson(json);

  final String material;
  final String? urgent;
  final int? samplingCheck;
  final int? rohsCheck;
  final String? rosh;
  final String? iqcpl;
  final String? type;
  final String? frequency;
  final int? qtyStandardPacking;
  final String? typeSloc;
  final String? category;

  @override
  Map<String, dynamic> toJson() => _$MaterialInfoResponseModelToJson(this);
}
