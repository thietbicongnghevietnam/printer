import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_request_model.dart';

part 'store_goods_request_model.g.dart';

@JsonSerializable()
class StoreGoodsRequestModel extends BaseRequestModel {
  StoreGoodsRequestModel({
    required this.blockName,
    required this.goodsName,
    required this.remark,
  });

  factory StoreGoodsRequestModel.fromJson(Map<String, dynamic> json) =>
      _$StoreGoodsRequestModelFromJson(json);

  final String blockName;
  final String goodsName;
  final String remark;

  @override
  Map<String, dynamic> toJson() => _$StoreGoodsRequestModelToJson(this);
}
