import 'dart:convert';

abstract class BaseRequestModel {
  const BaseRequestModel();

  @override
  String toString() {
    return jsonEncode(toJson());
  }

  Map<String, dynamic> toJson();
}
