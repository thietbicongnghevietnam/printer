import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/services/models/response/base_response_model.dart';

part 'material_response_model.g.dart';

@JsonSerializable()
class MaterialResponseModel extends BaseResponseModel {
  const MaterialResponseModel({
    required this.receivingCardDetailID,
    required this.receivingCardID,
    required this.barcode,
    this.codeDate,
    required this.unitNo,
    required this.totalQuantity,
    required this.currentQuantity,
    this.lotNo,
    required this.material,
  });

  factory MaterialResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MaterialResponseModelFromJson(json);

  final int receivingCardDetailID;
  final int receivingCardID;
  final String barcode;
  final String? codeDate;
  final String? unitNo;
  final int totalQuantity;
  final int currentQuantity;
  final String? lotNo;
  final String material;

  @override
  Map<String, dynamic> toJson() => _$MaterialResponseModelToJson(this);
}
