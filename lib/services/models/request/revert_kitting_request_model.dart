import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/services/models/request/base_request_model.dart';

part 'revert_kitting_request_model.g.dart';

@JsonSerializable()
class RevertKittingRequestModel extends BaseRequestModel {
  RevertKittingRequestModel( {
    this.isPreview,
    this.barcode,
  });
  factory RevertKittingRequestModel.fromJson(Map<String, dynamic> json) =>
      _$RevertKittingRequestModelFromJson(json);

  final List<String>? barcode;
  final bool? isPreview;

  @override
  Map<String, dynamic> toJson() => _$RevertKittingRequestModelToJson(this);
}
