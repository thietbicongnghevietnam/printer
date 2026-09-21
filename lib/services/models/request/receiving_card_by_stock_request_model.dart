import 'package:json_annotation/json_annotation.dart';

import 'base_request_model.dart';
import 'material_request_model.dart';

part 'receiving_card_by_stock_request_model.g.dart';

@JsonSerializable()
class ReceivingCardByStockRequestModel extends BaseRequestModel {

  ReceivingCardByStockRequestModel({
    this.receivingCardTime,
    this.plant,
    this.receivingCardDate,
    this.urgent,
    this.ulcoc,
    this.material,
    this.materialType,
    this.materialFrequency,
    this.daInvNo,
    this.vendorCode,
    this.category,
    this.totalQuantity,
    this.currentQuantity,
    this.pl,
    this.rohs,
    this.sloc,
    this.vendorName,
    this.samplingCheck,
    this.rohsCheck,
    this.box,
    this.listMaterial,
    this.barcodeStockCard,
  });

  factory ReceivingCardByStockRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ReceivingCardByStockRequestModelFromJson(json);

  final int? totalQuantity;
  final int? currentQuantity;
  final int? samplingCheck;
  final int? rohsCheck;
  final int? box;

  final String? receivingCardTime;
  final String? plant;
  final String? receivingCardDate;
  final String? urgent;
  final String? ulcoc;
  final String? material;
  final String? materialType;
  final String? materialFrequency;
  final String? daInvNo;
  final String? vendorCode;
  final String? category;
  final String? pl;
  final String? rohs;
  final String? sloc;
  final String? vendorName;
  final String? barcodeStockCard;

  final List<MaterialRequestModel>? listMaterial;

  @override
  Map<String, dynamic> toJson() => _$ReceivingCardByStockRequestModelToJson(this);
}
