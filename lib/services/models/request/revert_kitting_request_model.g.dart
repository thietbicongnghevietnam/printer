// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'revert_kitting_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RevertKittingRequestModel _$RevertKittingRequestModelFromJson(
        Map<String, dynamic> json) =>
    RevertKittingRequestModel(
      isPreview: json['isPreview'] as bool?,
      barcode:
          (json['barcode'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$RevertKittingRequestModelToJson(
        RevertKittingRequestModel instance) =>
    <String, dynamic>{
      'barcode': instance.barcode,
      'isPreview': instance.isPreview,
    };
