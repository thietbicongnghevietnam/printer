import 'package:json_annotation/json_annotation.dart';

import 'base_request_model.dart';

part 'receiving_card_model.g.dart';

@JsonSerializable()
class ReceivingCardModel extends BaseRequestModel  {
  ReceivingCardModel({
    this.status,
    this.createdDate,
    this.createdBy,
    this.updatedDate,
    this.updatedBy,
    this.receivingCardID,
    this.receivingType,
    this.samplingCheck,
    this.rohsCheck,
    this.daInvDetailID,
    this.totalQuantity,
    this.currentQuantity,
    this.boxQuantity,
    this.plant,
    this.receivingCardTime,
    this.urgent,
    this.ulcoc,
    this.material,
    this.materialType,
    this.materialFrequency,
    this.codeDate,
    this.daInvNo,
    this.reason,
    this.pl,
    this.rohs,
    this.receivingCardDate,
    this.vendorCode,
    this.sloc,
    this.barcode,
    this.temporaryAreaCode,
    this.category,
    this.venderName,
  });

  factory ReceivingCardModel.fromJson(Map<String, dynamic> json) =>
      _$ReceivingCardModelFromJson(json);

  final int? status;
  final String? createdDate;
  final String? createdBy;
  final String? updatedDate;
  final String? updatedBy;
  final int? receivingCardID;
  final int? receivingType;
  final int? samplingCheck;
  final int? rohsCheck;
  final int? daInvDetailID;
  final int? totalQuantity;
  final int? currentQuantity;
  final int? boxQuantity;
  final String? plant;
  final String? receivingCardTime;
  final String? urgent;
  final String? ulcoc;
  final String? material;
  final String? materialType;
  final String? materialFrequency;
  final String? codeDate;
  final String? daInvNo;
  final String? reason;
  final String? pl;
  final String? rohs;
  final String? receivingCardDate;
  final String? vendorCode;
  final String? sloc;
  final String? barcode;
  final String? temporaryAreaCode;
  final String? category;
  final String? venderName;

  @override
  Map<String, dynamic> toJson() => _$ReceivingCardModelToJson(this);
}
