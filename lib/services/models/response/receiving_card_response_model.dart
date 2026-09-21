import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_response_model.dart';
import 'info_last_lot_response_model.dart';
import 'material_response_model.dart';

part 'receiving_card_response_model.g.dart';

@JsonSerializable()
class ReceivingCardResponseModel extends BaseResponseModel {
  const ReceivingCardResponseModel( {
    this.qtyDAInv,
    this.status,
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
    this.vendorName,
    this.sloc,
    this.barcode,
    this.temporaryAreaCode,
    this.haveBarcode,
    this.receivingCardDetails,
    this.daInvId,
    this.category,
    this.daInvDetailId,
    this.isSpecial = false,
    this.inforLastLot,
 	this.location,
    this.isOverdue = false,
 	this.isNG = false,
  });

  factory ReceivingCardResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ReceivingCardResponseModelFromJson(json);

  final int? status;
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
  final int? daInvId;
  final String? daInvNo;
  final String? reason;
  final String? pl;
  final String? rohs;
  final DateTime? receivingCardDate;
  final String? vendorCode;
  final String? vendorName;
  final String? sloc;
  final String? barcode;
  final String? temporaryAreaCode;
  final bool? haveBarcode;
  final String? category;
  final List<MaterialResponseModel>? receivingCardDetails;
  final int? qtyDAInv;
  final int? daInvDetailId;
  final bool isSpecial;
  final bool isNG;
  final InfoLastLotResponseModel? inforLastLot;
  final String? location;
  final bool isOverdue;

  @override
  Map<String, dynamic> toJson() => _$ReceivingCardResponseModelToJson(this);
}
