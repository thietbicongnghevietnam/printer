// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'column_rack_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ColumnRackResponseModel _$ColumnRackResponseModelFromJson(
        Map<String, dynamic> json) =>
    ColumnRackResponseModel(
      listBlockData: (json['listBlockData'] as List<dynamic>?)
          ?.map((e) =>
              BlockDetailResponseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ColumnRackResponseModelToJson(
        ColumnRackResponseModel instance) =>
    <String, dynamic>{
      'listBlockData': instance.listBlockData,
    };
