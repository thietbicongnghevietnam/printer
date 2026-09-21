// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supply_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupplyResponseModel _$SupplyResponseModelFromJson(Map<String, dynamic> json) =>
    SupplyResponseModel(
      trolleyName: json['trolleyName'] as String?,
      barCode: json['barCode'] as String?,
      actionStatus: (json['actionStatus'] as num?)?.toInt(),
      description: json['description'] as String?,
      time: json['time'] as String?,
      deliveryDate: json['deliveryDate'] == null
          ? null
          : DateTime.parse(json['deliveryDate'] as String),
      model: json['model'] as String?,
      line: json['line'] as String?,
      modelQuantity: (json['modelQuantity'] as num?)?.toInt(),
      category: json['category'] as String?,
      kittingTimeType: json['kittingTimeType'] as String?,
      pic: json['pic'] as String?,
      total: (json['total'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SupplyResponseModelToJson(
        SupplyResponseModel instance) =>
    <String, dynamic>{
      'trolleyName': instance.trolleyName,
      'barCode': instance.barCode,
      'actionStatus': instance.actionStatus,
      'description': instance.description,
      'time': instance.time,
      'deliveryDate': instance.deliveryDate?.toIso8601String(),
      'model': instance.model,
      'line': instance.line,
      'modelQuantity': instance.modelQuantity,
      'category': instance.category,
      'kittingTimeType': instance.kittingTimeType,
      'pic': instance.pic,
      'total': instance.total,
    };
