// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_kitting_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckKittingRequestModel _$CheckKittingRequestModelFromJson(
        Map<String, dynamic> json) =>
    CheckKittingRequestModel(
      id: (json['id'] as num?)?.toInt(),
      status: (json['status'] as num?)?.toInt(),
      barcode:
          (json['barcode'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$CheckKittingRequestModelToJson(
        CheckKittingRequestModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'barcode': instance.barcode,
    };
