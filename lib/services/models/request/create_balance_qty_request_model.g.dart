// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_balance_qty_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateBalanceQtyRequestModel _$CreateBalanceQtyRequestModelFromJson(
        Map<String, dynamic> json) =>
    CreateBalanceQtyRequestModel(
      plant: json['plant'] as String?,
      sloc: json['sloc'] as String?,
      material: json['material'] as String?,
      qtyBalance: (json['qtyBalance'] as num?)?.toInt(),
      qtySystem: (json['qtySystem'] as num?)?.toInt(),
      note: json['note'] as String?,
    );

Map<String, dynamic> _$CreateBalanceQtyRequestModelToJson(
        CreateBalanceQtyRequestModel instance) =>
    <String, dynamic>{
      'plant': instance.plant,
      'sloc': instance.sloc,
      'material': instance.material,
      'note': instance.note,
      'qtyBalance': instance.qtyBalance,
      'qtySystem': instance.qtySystem,
    };
