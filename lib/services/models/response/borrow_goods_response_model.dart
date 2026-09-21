import 'package:json_annotation/json_annotation.dart';

import 'base_response_model.dart';

part 'borrow_goods_response_model.g.dart';

@JsonSerializable()
class BorrowGoodsResponseModel extends BaseResponseModel {
  BorrowGoodsResponseModel({
    this.id,
    this.blockName,
    this.rackCode,
    this.floorName,
    this.zoneName,
    this.goodsName,
    this.remark,
    this.createdDate,
    this.createdBy,
  });

  factory BorrowGoodsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BorrowGoodsResponseModelFromJson(json);

  final int? id;

  final String? floorName;
  final String? zoneName;
  final String? blockName;
  final String? rackCode;
  final String? goodsName;
  final String? remark;
  final String? createdDate;
  final String? createdBy;

  @override
  Map<String, dynamic> toJson() => _$BorrowGoodsResponseModelToJson(this);
}
