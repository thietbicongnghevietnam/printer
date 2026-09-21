import 'package:json_annotation/json_annotation.dart';
import 'package:smart_warehouse/services/models/response/base_response_model.dart';

part 'kitting_card_response_model.g.dart';

@JsonSerializable()
class KittingCardResponseModel extends BaseResponseModel {
  KittingCardResponseModel({
    this.kittingCardID,
    this.rcDetailID,
    this.rcid,
    this.kittingListDetailId,
    this.kittingTimeType,
    this.plant,
    this.partNo,
    this.model,
    this.quantity,
    this.dateTimeKitting,
    this.time,
    this.line,
    this.sloc,
    this.picUser,
    this.posMCS,
    this.posFA,
    this.barcode,
    this.pl,
    this.qtyTotal,
    this.status,
    this.kittingType,
    this.category,
    this.receiptSloc,
    this.kittingFrom,
    this.reason,
    this.remark,
    this.pullID,
  });

  factory KittingCardResponseModel.fromJson(Map<String, dynamic> json) =>
      _$KittingCardResponseModelFromJson(json);

  final int? kittingCardID;
  final String? rcDetailID;
  final String? rcid;
  final int? kittingListDetailId;
  final String? kittingTimeType;
  final String? plant;
  final String? partNo;
  final String? model;
  final double? quantity;
  final DateTime? dateTimeKitting;
  final String? time;
  final String? line;
  final String? sloc;
  final String? picUser;
  final String? posMCS;
  final String? posFA;
  final String? barcode;
  final String? pl;
  final double? qtyTotal;
  final int? status;
  final int? kittingType;
  final String? category;
  final String? receiptSloc;
  final String? kittingFrom;
  final String? reason;
  final String? remark;
  final String? pullID;

  @override
  Map<String, dynamic> toJson() => _$KittingCardResponseModelToJson(this);
}
