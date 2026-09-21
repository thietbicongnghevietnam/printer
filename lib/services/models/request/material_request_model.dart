import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_request_model.dart';

part 'material_request_model.g.dart';

@JsonSerializable()
class MaterialRequestModel extends BaseRequestModel {
  const MaterialRequestModel({
    this.id,
    required this.barcode,
    this.codeDate,
    required this.unitNo,
    required this.quantity,
    this.lotNo,
    this.poNo,
    this.daIvnItem,
    this.poItem,
  });

  factory MaterialRequestModel.fromJson(Map<String, dynamic> json) =>
      _$MaterialRequestModelFromJson(json);

  @JsonKey(name: 'receivingCardDetailID', includeIfNull: false)
  final int? id;
  final String barcode;
  final String? codeDate;
  final String? unitNo;
  final int quantity;
  final String? lotNo;
  final String? poNo;
  final String? poItem;
  final String? daIvnItem;

  @override
  Map<String, dynamic> toJson() => _$MaterialRequestModelToJson(this);
}
