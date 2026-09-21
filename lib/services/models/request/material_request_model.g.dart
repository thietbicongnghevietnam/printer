// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaterialRequestModel _$MaterialRequestModelFromJson(
        Map<String, dynamic> json) =>
    MaterialRequestModel(
      id: (json['receivingCardDetailID'] as num?)?.toInt(),
      barcode: json['barcode'] as String,
      codeDate: json['codeDate'] as String?,
      unitNo: json['unitNo'] as String?,
      quantity: (json['quantity'] as num).toInt(),
      lotNo: json['lotNo'] as String?,
      poNo: json['poNo'] as String?,
      daIvnItem: json['daIvnItem'] as String?,
      poItem: json['poItem'] as String?,
    );

Map<String, dynamic> _$MaterialRequestModelToJson(
    MaterialRequestModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('receivingCardDetailID', instance.id);
  val['barcode'] = instance.barcode;
  val['codeDate'] = instance.codeDate;
  val['unitNo'] = instance.unitNo;
  val['quantity'] = instance.quantity;
  val['lotNo'] = instance.lotNo;
  val['poNo'] = instance.poNo;
  val['poItem'] = instance.poItem;
  val['daIvnItem'] = instance.daIvnItem;
  return val;
}
