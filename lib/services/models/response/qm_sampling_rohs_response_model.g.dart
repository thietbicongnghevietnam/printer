// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qm_sampling_rohs_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QmSamplingRohsResponseModel _$QmSamplingRohsResponseModelFromJson(
        Map<String, dynamic> json) =>
    QmSamplingRohsResponseModel(
      iqcpl: json['iqcpl'] as String?,
      vendorName: json['vendorName'] as String?,
      rohs: json['rohs'] as String?,
      rohsCheck: (json['rohsCheck'] as num?)?.toInt(),
      samplingCheck: (json['samplingCheck'] as num?)?.toInt(),
    );

Map<String, dynamic> _$QmSamplingRohsResponseModelToJson(
        QmSamplingRohsResponseModel instance) =>
    <String, dynamic>{
      'iqcpl': instance.iqcpl,
      'vendorName': instance.vendorName,
      'rohs': instance.rohs,
      'rohsCheck': instance.rohsCheck,
      'samplingCheck': instance.samplingCheck,
    };
