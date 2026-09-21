// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_information_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryInformationResponseModel _$HistoryInformationResponseModelFromJson(
        Map<String, dynamic> json) =>
    HistoryInformationResponseModel(
      createdBy: json['createdBy'] as String?,
      remark: json['remark'] as String?,
      createdDate: json['createdDate'] as String?,
      store: (json['store'] as num?)?.toInt(),
      stock: (json['stock'] as num?)?.toInt(),
      kitting: (json['kitting'] as num?)?.toInt(),
      qtyBalance: (json['qtyBalance'] as num?)?.toInt(),
    );

Map<String, dynamic> _$HistoryInformationResponseModelToJson(
        HistoryInformationResponseModel instance) =>
    <String, dynamic>{
      'createdBy': instance.createdBy,
      'remark': instance.remark,
      'createdDate': instance.createdDate,
      'stock': instance.stock,
      'store': instance.store,
      'kitting': instance.kitting,
      'qtyBalance': instance.qtyBalance,
    };
