// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_pmd_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchPMDResponsesModel _$SearchPMDResponsesModelFromJson(
        Map<String, dynamic> json) =>
    SearchPMDResponsesModel(
      quantity: (json['qtyAc'] as num).toInt(),
      barcode: json['barcodeNo'] as String,
    );

Map<String, dynamic> _$SearchPMDResponsesModelToJson(
        SearchPMDResponsesModel instance) =>
    <String, dynamic>{
      'qtyAc': instance.quantity,
      'barcodeNo': instance.barcode,
    };
