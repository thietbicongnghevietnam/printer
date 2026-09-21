// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginResponseModel _$LoginResponseModelFromJson(Map<String, dynamic> json) =>
    LoginResponseModel(
      assessToken: json['assessToken'] as String?,
      userID: json['userID'] as String?,
      userFullName: json['userFullName'] as String?,
      sectionID: (json['sectionID'] as num?)?.toInt(),
      sectionName: json['sectionName'] as String?,
      positionUserID: (json['positionUserID'] as num?)?.toInt(),
      positionUserName: json['positionUserName'] as String?,
      pdaRole: json['pdaRole'] as String?,
      status: (json['status'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LoginResponseModelToJson(LoginResponseModel instance) =>
    <String, dynamic>{
      'assessToken': instance.assessToken,
      'userID': instance.userID,
      'userFullName': instance.userFullName,
      'sectionID': instance.sectionID,
      'sectionName': instance.sectionName,
      'positionUserID': instance.positionUserID,
      'positionUserName': instance.positionUserName,
      'pdaRole': instance.pdaRole,
      'status': instance.status,
    };
