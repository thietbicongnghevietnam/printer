import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/services/models/response/base_response_model.dart';

import 'history_information_response_model.dart';

part 'urgen_sloc_response_model.g.dart';

@JsonSerializable()
class UrgenSlocResponseModel extends BaseResponseModel {
  const UrgenSlocResponseModel({
    this.urgent,
    this.ulcoc,
  });

  factory UrgenSlocResponseModel.fromJson(
      Map<String, dynamic> json) =>
      _$UrgenSlocResponseModelFromJson(json);

  final String? urgent;
  final String? ulcoc;


  @override
  Map<String, dynamic> toJson() =>
      _$UrgenSlocResponseModelToJson(this);
}
