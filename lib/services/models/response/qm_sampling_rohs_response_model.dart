import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/services/models/response/base_response_model.dart';

import 'history_information_response_model.dart';

part 'qm_sampling_rohs_response_model.g.dart';

@JsonSerializable()
class QmSamplingRohsResponseModel extends BaseResponseModel {
  const QmSamplingRohsResponseModel({
    this.iqcpl,
    this.vendorName,
    this.rohs,
    this.rohsCheck,
    this.samplingCheck,
  });

  factory QmSamplingRohsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$QmSamplingRohsResponseModelFromJson(json);

  final String? iqcpl;
  final String? vendorName;
  final String? rohs;

  final int? rohsCheck;
  final int? samplingCheck;

  @override
  Map<String, dynamic> toJson() => _$QmSamplingRohsResponseModelToJson(this);
}
