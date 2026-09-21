import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/services/models/response/base_response_model.dart';

part 'history_information_response_model.g.dart';

@JsonSerializable()
class HistoryInformationResponseModel extends BaseResponseModel {
  const HistoryInformationResponseModel({
    this.createdBy,
    this.remark,
    this.createdDate,
    this.store,
    this.stock,
    this.kitting,
    this.qtyBalance,
  });

  factory HistoryInformationResponseModel.fromJson(Map<String, dynamic> json) =>
      _$HistoryInformationResponseModelFromJson(json);

  final String? createdBy;
  final String? remark;
  final String? createdDate;

  final int? stock;
  final int? store;
  final int? kitting;
  final int? qtyBalance;

  @override
  Map<String, dynamic> toJson() =>
      _$HistoryInformationResponseModelToJson(this);
}
