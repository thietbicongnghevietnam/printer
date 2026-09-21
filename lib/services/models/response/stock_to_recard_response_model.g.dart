// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stock_to_recard_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StockToReCardResponseModel _$StockToReCardResponseModelFromJson(
        Map<String, dynamic> json) =>
    StockToReCardResponseModel(
      samplingCheck: (json['samplingCheck'] as num?)?.toInt(),
      slocs: json['sloc'] as String?,
      plant: json['plant'] as String?,
      rohs: json['rohs'] as String?,
      iqcpl: json['iqcpl'] as String?,
      rohsCheck: (json['rohsCheck'] as num?)?.toInt(),
    );

Map<String, dynamic> _$StockToReCardResponseModelToJson(
        StockToReCardResponseModel instance) =>
    <String, dynamic>{
      'samplingCheck': instance.samplingCheck,
      'rohsCheck': instance.rohsCheck,
      'sloc': instance.slocs,
      'plant': instance.plant,
      'rohs': instance.rohs,
      'iqcpl': instance.iqcpl,
    };
