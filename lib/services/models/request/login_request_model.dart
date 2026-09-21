import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_request_model.dart';

part 'login_request_model.g.dart';

@JsonSerializable()
class LoginRequestModel extends BaseRequestModel  {
  const LoginRequestModel({required this.userId});

  factory LoginRequestModel.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestModelFromJson(json);

  final String userId;

  @override
  Map<String, dynamic> toJson() => _$LoginRequestModelToJson(this);
}
