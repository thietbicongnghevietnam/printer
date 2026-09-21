// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_version_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppVersionResponseModel _$AppVersionResponseModelFromJson(
        Map<String, dynamic> json) =>
    AppVersionResponseModel(
      version: json['version'] as String,
      result: AppVersionResponseResultModel.fromJson(
          json['result'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AppVersionResponseModelToJson(
        AppVersionResponseModel instance) =>
    <String, dynamic>{
      'version': instance.version,
      'result': instance.result,
    };

AppVersionResponseResultModel _$AppVersionResponseResultModelFromJson(
        Map<String, dynamic> json) =>
    AppVersionResponseResultModel(
      fileContents: json['fileContents'] as String,
      fileDownloadName: json['fileDownloadName'] as String,
    );

Map<String, dynamic> _$AppVersionResponseResultModelToJson(
        AppVersionResponseResultModel instance) =>
    <String, dynamic>{
      'fileContents': instance.fileContents,
      'fileDownloadName': instance.fileDownloadName,
    };
