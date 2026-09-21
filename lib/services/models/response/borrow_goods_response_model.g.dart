// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'borrow_goods_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BorrowGoodsResponseModel _$BorrowGoodsResponseModelFromJson(
        Map<String, dynamic> json) =>
    BorrowGoodsResponseModel(
      id: (json['id'] as num?)?.toInt(),
      blockName: json['blockName'] as String?,
      rackCode: json['rackCode'] as String?,
      floorName: json['floorName'] as String?,
      zoneName: json['zoneName'] as String?,
      goodsName: json['goodsName'] as String?,
      remark: json['remark'] as String?,
      createdDate: json['createdDate'] as String?,
      createdBy: json['createdBy'] as String?,
    );

Map<String, dynamic> _$BorrowGoodsResponseModelToJson(
        BorrowGoodsResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'floorName': instance.floorName,
      'zoneName': instance.zoneName,
      'blockName': instance.blockName,
      'rackCode': instance.rackCode,
      'goodsName': instance.goodsName,
      'remark': instance.remark,
      'createdDate': instance.createdDate,
      'createdBy': instance.createdBy,
    };
