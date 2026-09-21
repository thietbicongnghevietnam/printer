// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ta_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TAResponsesModel _$TAResponsesModelFromJson(Map<String, dynamic> json) =>
    TAResponsesModel(
      status: (json['status'] as num?)?.toInt(),
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => ReceivingCardModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      message: json['message'] as String?,
    );

Map<String, dynamic> _$TAResponsesModelToJson(TAResponsesModel instance) =>
    <String, dynamic>{
      'status': instance.status,
      'data': instance.data,
      'message': instance.message,
    };
