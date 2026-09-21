import 'package:json_annotation/json_annotation.dart';

part 'api_response_model.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class ApiResponseModel<T> {
  ApiResponseModel({this.data, this.message, this.status});

  factory ApiResponseModel.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) =>
      _$ApiResponseModelFromJson(json, fromJsonT);

  @JsonKey(name: 'data')
  T? data;

  @JsonKey(name: 'message')
  String? message;

  @JsonKey(name: 'status')
  int? status;

  Map<String, dynamic> toJson(Object Function(T value) toJsonT) =>
      _$ApiResponseModelToJson<T>(this, toJsonT);
}
