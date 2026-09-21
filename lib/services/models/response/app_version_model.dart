import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_response_model.dart';

part 'app_version_model.g.dart';

@JsonSerializable()
class AppVersionResponseModel extends BaseResponseModel  {
  const AppVersionResponseModel({
    required this.version,
    required this.result,
  });

  factory AppVersionResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AppVersionResponseModelFromJson(json);

  final String version;
  final AppVersionResponseResultModel result;

  @override
  Map<String, dynamic> toJson() => _$AppVersionResponseModelToJson(this);
}

@JsonSerializable()
class AppVersionResponseResultModel extends BaseResponseModel  {
  const AppVersionResponseResultModel({
    required this.fileContents,
    required this.fileDownloadName,
  });

  factory AppVersionResponseResultModel.fromJson(Map<String, dynamic> json) =>
      _$AppVersionResponseResultModelFromJson(json);

  final String fileContents;
  final String fileDownloadName;

  @override
  Map<String, dynamic> toJson() => _$AppVersionResponseResultModelToJson(this);
}

