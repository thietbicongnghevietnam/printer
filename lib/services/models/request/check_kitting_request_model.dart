import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/services/models/request/base_request_model.dart';

part 'check_kitting_request_model.g.dart';

@JsonSerializable()
class CheckKittingRequestModel extends BaseRequestModel {
  CheckKittingRequestModel({
    this.id,
    this.status,
    this.barcode,
  });
  factory CheckKittingRequestModel.fromJson(Map<String, dynamic> json) =>
      _$CheckKittingRequestModelFromJson(json);

  final int? id;
  final int? status;
  final List<String>? barcode;

  @override
  Map<String, dynamic> toJson() => _$CheckKittingRequestModelToJson(this);
}
