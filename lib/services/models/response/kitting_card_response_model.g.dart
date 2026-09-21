// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kitting_card_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KittingCardResponseModel _$KittingCardResponseModelFromJson(
        Map<String, dynamic> json) =>
    KittingCardResponseModel(
      kittingCardID: (json['kittingCardID'] as num?)?.toInt(),
      rcDetailID: json['rcDetailID'] as String?,
      rcid: json['rcid'] as String?,
      kittingListDetailId: (json['kittingListDetailId'] as num?)?.toInt(),
      kittingTimeType: json['kittingTimeType'] as String?,
      plant: json['plant'] as String?,
      partNo: json['partNo'] as String?,
      model: json['model'] as String?,
      quantity: (json['quantity'] as num?)?.toDouble(),
      dateTimeKitting: json['dateTimeKitting'] == null
          ? null
          : DateTime.parse(json['dateTimeKitting'] as String),
      time: json['time'] as String?,
      line: json['line'] as String?,
      sloc: json['sloc'] as String?,
      picUser: json['picUser'] as String?,
      posMCS: json['posMCS'] as String?,
      posFA: json['posFA'] as String?,
      barcode: json['barcode'] as String?,
      pl: json['pl'] as String?,
      qtyTotal: (json['qtyTotal'] as num?)?.toDouble(),
      status: (json['status'] as num?)?.toInt(),
      kittingType: (json['kittingType'] as num?)?.toInt(),
      category: json['category'] as String?,
      receiptSloc: json['receiptSloc'] as String?,
      kittingFrom: json['kittingFrom'] as String?,
      reason: json['reason'] as String?,
      remark: json['remark'] as String?,
      pullID: json['pullID'] as String?,
    );

Map<String, dynamic> _$KittingCardResponseModelToJson(
        KittingCardResponseModel instance) =>
    <String, dynamic>{
      'kittingCardID': instance.kittingCardID,
      'rcDetailID': instance.rcDetailID,
      'rcid': instance.rcid,
      'kittingListDetailId': instance.kittingListDetailId,
      'kittingTimeType': instance.kittingTimeType,
      'plant': instance.plant,
      'partNo': instance.partNo,
      'model': instance.model,
      'quantity': instance.quantity,
      'dateTimeKitting': instance.dateTimeKitting?.toIso8601String(),
      'time': instance.time,
      'line': instance.line,
      'sloc': instance.sloc,
      'picUser': instance.picUser,
      'posMCS': instance.posMCS,
      'posFA': instance.posFA,
      'barcode': instance.barcode,
      'pl': instance.pl,
      'qtyTotal': instance.qtyTotal,
      'status': instance.status,
      'kittingType': instance.kittingType,
      'category': instance.category,
      'receiptSloc': instance.receiptSloc,
      'kittingFrom': instance.kittingFrom,
      'reason': instance.reason,
      'remark': instance.remark,
      'pullID': instance.pullID,
    };
