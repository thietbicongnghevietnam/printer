// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qc_borrow_rc_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QCBorrowRcRequestModel _$QCBorrowRcRequestModelFromJson(
        Map<String, dynamic> json) =>
    QCBorrowRcRequestModel(
      rcBarcode: json['barcode'] as String?,
      quantity: (json['quantity'] as num?)?.toInt() ?? 0,
      listBoxCardRQ: (json['qtyBoxQCRequests'] as List<dynamic>?)
          ?.map((e) => BoxQCQtyRequestModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$QCBorrowRcRequestModelToJson(
        QCBorrowRcRequestModel instance) =>
    <String, dynamic>{
      'barcode': instance.rcBarcode,
      'quantity': instance.quantity,
      'qtyBoxQCRequests': instance.listBoxCardRQ,
    };

BoxQCQtyRequestModel _$BoxQCQtyRequestModelFromJson(
        Map<String, dynamic> json) =>
    BoxQCQtyRequestModel(
      barcodeBox: json['barcodeBox'] as String?,
      quantity: (json['quantity'] as num?)?.toInt(),
      rcBarcode: json['barcode'] as String?,
    );

Map<String, dynamic> _$BoxQCQtyRequestModelToJson(
        BoxQCQtyRequestModel instance) =>
    <String, dynamic>{
      'barcodeBox': instance.barcodeBox,
      'quantity': instance.quantity,
      'barcode': instance.rcBarcode,
    };
