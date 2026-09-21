// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_balance_rc_qty_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BalanceRcDataRequestModel _$BalanceRcDataRequestModelFromJson(
        Map<String, dynamic> json) =>
    BalanceRcDataRequestModel(
      isAll: json['isAll'] as bool? ?? false,
      balanceParents: (json['balanceParents'] as List<dynamic>?)
              ?.map((e) => BalanceParentsRequestModel.fromJson(
                  e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$BalanceRcDataRequestModelToJson(
        BalanceRcDataRequestModel instance) =>
    <String, dynamic>{
      'isAll': instance.isAll,
      'balanceParents': instance.balanceParents,
    };

BalanceParentsRequestModel _$BalanceParentsRequestModelFromJson(
        Map<String, dynamic> json) =>
    BalanceParentsRequestModel(
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      barcode: json['barcode'] as String?,
      balanceBoxs: (json['balanceBoxs'] as List<dynamic>?)
              ?.map((e) =>
                  BalanceBoxRequestModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$BalanceParentsRequestModelToJson(
        BalanceParentsRequestModel instance) =>
    <String, dynamic>{
      'quantity': instance.quantity,
      'barcode': instance.barcode,
      'balanceBoxs': instance.balanceBoxs,
    };

BalanceBoxRequestModel _$BalanceBoxRequestModelFromJson(
        Map<String, dynamic> json) =>
    BalanceBoxRequestModel(
      quantity: (json['quantity'] as num?)?.toInt(),
      id: (json['id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$BalanceBoxRequestModelToJson(
        BalanceBoxRequestModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quantity': instance.quantity,
    };
