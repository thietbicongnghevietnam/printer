// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResponseModel<T> _$SearchResponseModelFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    SearchResponseModel<T>(
      (json['records'] as List<dynamic>).map(fromJsonT).toList(),
      (json['totalRecord'] as num).toInt(),
    );

Map<String, dynamic> _$SearchResponseModelToJson<T>(
  SearchResponseModel<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'records': instance.records.map(toJsonT).toList(),
      'totalRecord': instance.totalRecord,
    };
