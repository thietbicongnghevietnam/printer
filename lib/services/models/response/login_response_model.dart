import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_response_model.dart';

part 'login_response_model.g.dart';

@JsonSerializable()
class LoginResponseModel extends BaseResponseModel  {
  const LoginResponseModel({
    this.assessToken,
    this.userID,
    this.userFullName,
    this.sectionID,
    this.sectionName,
    this.positionUserID,
    this.positionUserName,
    this.pdaRole,
    this.status,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseModelFromJson(json);

  final String? assessToken;
  final String? userID;
  final String? userFullName;
  final int? sectionID;
  final String? sectionName;
  final int? positionUserID;
  final String? positionUserName;
  final String? pdaRole;
  final int? status;

  @override
  Map<String, dynamic> toJson() => _$LoginResponseModelToJson(this);
}
