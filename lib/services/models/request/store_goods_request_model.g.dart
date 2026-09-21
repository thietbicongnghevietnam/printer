// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'store_goods_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StoreGoodsRequestModel _$StoreGoodsRequestModelFromJson(
        Map<String, dynamic> json) =>
    StoreGoodsRequestModel(
      blockName: json['blockName'] as String,
      goodsName: json['goodsName'] as String,
      remark: json['remark'] as String,
    );

Map<String, dynamic> _$StoreGoodsRequestModelToJson(
        StoreGoodsRequestModel instance) =>
    <String, dynamic>{
      'blockName': instance.blockName,
      'goodsName': instance.goodsName,
      'remark': instance.remark,
    };
