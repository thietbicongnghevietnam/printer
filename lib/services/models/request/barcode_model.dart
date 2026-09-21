import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/services/models/request/base_request_model.dart';

part 'barcode_model.g.dart';

@JsonSerializable()
class BarCodeModel extends BaseRequestModel {
  const BarCodeModel({
    this.daInvNo,
    this.daInvId,
    this.vendorCode,
    this.deliveryDate,
    this.unitNo,
    this.poNo,
    this.poItem,
    this.lotNo,
    this.barcode,
    required this.material,
    this.materialType,
    this.plant,
    this.sloc,
    this.totalQuantity,
    this.currentQuantity,
    this.boxQuantity,
    this.totalBox,
    this.reason,
  });

  factory BarCodeModel.fromJson(Map<String, dynamic> json) =>
      _$BarCodeModelFromJson(json);

  @JsonKey(name: 'daInvNo')
  final String? daInvNo;
  @JsonKey(name: 'daInvId')
  final int? daInvId;
  @JsonKey(name: 'vendorCode')
  final String? vendorCode;
  @JsonKey(name: 'deliveryDate')
  final DateTime? deliveryDate;
  @JsonKey(name: 'unitNo')
  final String? unitNo;
  @JsonKey(name: 'poNo')
  final String? poNo;
  @JsonKey(name: 'poItem')
  final String? poItem;
  @JsonKey(name: 'lotNo')
  final String? lotNo;
  @JsonKey(name: 'barcode')
  final String? barcode;
  @JsonKey(name: 'material')
  final String material;
  @JsonKey(name: 'materialType')
  final String? materialType;
  @JsonKey(name: 'plant')
  final String? plant;
  @JsonKey(name: 'sloc')
  final String? sloc;
  @JsonKey(name: 'totalQuantity')
  final int? totalQuantity;
  @JsonKey(name: 'currentQuantity')
  final int? currentQuantity;
  @JsonKey(name: 'boxQuantity')
  final int? boxQuantity;
  @JsonKey(name: 'totalBox')
  final int? totalBox;
  @JsonKey(name: 'reason')
  final String? reason;

  @override
  Map<String, dynamic> toJson() => _$BarCodeModelToJson(this);
}
