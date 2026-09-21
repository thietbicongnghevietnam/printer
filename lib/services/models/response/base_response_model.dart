import 'dart:convert';

abstract class BaseResponseModel {
  const BaseResponseModel();

  @override
  String toString() {
    return jsonEncode(toJson());
  }

  Map<String, dynamic> toJson();
}
