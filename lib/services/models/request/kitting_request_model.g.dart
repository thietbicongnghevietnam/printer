// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kitting_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KittingRequestModel _$KittingRequestModelFromJson(Map<String, dynamic> json) =>
    KittingRequestModel(
      plant: json['plant'] as String?,
      cate: json['cate'] as String?,
      type: (json['type'] as num?)?.toInt(),
      model: json['model'] as String?,
      tab: (json['tab'] as num?)?.toInt(),
      proDate: json['proDate'] as String?,
      fromSloc: json['fromSloc'] as String?,
      sloc: json['sloc'] as String?,
      partNo: json['partNo'] as String?,
      material: json['material'] as String?,
      reservation: json['reservation'] as String?,
      kittingDate: json['kittingDate'] as String?,
      supplyDate: json['supplyDate'] as String?,
      fromTime: json['fromTime'] as String?,
      finishTime: json['finishTime'] as String?,
      line: json['line'] as String?,
      time: json['time'] as String?,
      urgent: json['urgent'] as bool?,
      quantity: (json['quantity'] as num?)?.toInt(),
      status: (json['status'] as num?)?.toInt(),
      date: json['date'] as String?,
    );

Map<String, dynamic> _$KittingRequestModelToJson(
        KittingRequestModel instance) =>
    <String, dynamic>{
      'plant': instance.plant,
      'cate': instance.cate,
      'type': instance.type,
      'model': instance.model,
      'tab': instance.tab,
      'proDate': instance.proDate,
      'fromSloc': instance.fromSloc,
      'sloc': instance.sloc,
      'partNo': instance.partNo,
      'material': instance.material,
      'reservation': instance.reservation,
      'kittingDate': instance.kittingDate,
      'supplyDate': instance.supplyDate,
      'fromTime': instance.fromTime,
      'finishTime': instance.finishTime,
      'line': instance.line,
      'time': instance.time,
      'urgent': instance.urgent,
      'quantity': instance.quantity,
      'status': instance.status,
      'date': instance.date,
    };
