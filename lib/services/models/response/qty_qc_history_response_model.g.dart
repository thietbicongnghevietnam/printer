// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qty_qc_history_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QtyQCHistoryResponseModel _$QtyQCHistoryResponseModelFromJson(
        Map<String, dynamic> json) =>
    QtyQCHistoryResponseModel(
      barcodeBox: json['barcodeBox'] as String?,
      barcode: json['barcode'] as String?,
      qtyBox: (json['qtyBox'] as num?)?.toInt(),
      qtyRC: (json['qtyRC'] as num?)?.toInt(),
      material: json['material'] as String?,
      plant: json['plant'] as String?,
      sloc: json['sloc'] as String?,
    );

Map<String, dynamic> _$QtyQCHistoryResponseModelToJson(
        QtyQCHistoryResponseModel instance) =>
    <String, dynamic>{
      'barcodeBox': instance.barcodeBox,
      'barcode': instance.barcode,
      'material': instance.material,
      'plant': instance.plant,
      'sloc': instance.sloc,
      'qtyBox': instance.qtyBox,
      'qtyRC': instance.qtyRC,
    };
