import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_response_model.dart';

part 'receiving_card_item_response_model.g.dart';

@JsonSerializable()
class ReceivingCardItemResponseModel extends BaseResponseModel {
  ReceivingCardItemResponseModel(
      {this.status,
      this.createdDate,
      this.createdBy,
      this.updatedDate,
      this.updatedBy,
      this.receivingCardDetailID,
      this.receivingCardID,
      required this.material,
      required this.barcode,
       this.dateCode,
      required this.unitNo,
      this.totalQuantity,
      required this.currentQuantity,
      this.lotNo,
      this.isPOPending,
      this.daInvoiceItemDetailID,
        this.location,
        this.isOverdue = false,
      });
  factory ReceivingCardItemResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ReceivingCardItemResponseModelFromJson(json);

  final int? status;
  final DateTime? createdDate;
  final String? createdBy;
  final DateTime? updatedDate;
  final String? updatedBy;
  final int? receivingCardDetailID;
  final int? receivingCardID;
  final String material;
  final String barcode;
  final String? dateCode;
  final String unitNo;
  final int? totalQuantity;
  final int currentQuantity;
  final String? lotNo;
  final bool? isPOPending;
  final int? daInvoiceItemDetailID;
  final String? location;
  final bool isOverdue;

  @override
  Map<String, dynamic> toJson() => _$ReceivingCardItemResponseModelToJson(this);
}
