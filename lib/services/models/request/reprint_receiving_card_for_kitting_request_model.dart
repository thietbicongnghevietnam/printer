import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/services/models/request/base_request_model.dart';

part 'reprint_receiving_card_for_kitting_request_model.g.dart';

@JsonSerializable()
class ReprintReceivingCardForKittingRequestModel extends BaseRequestModel {
  ReprintReceivingCardForKittingRequestModel({
    this.quantity,
    this.isPreview,
    this.barcode,
  });
  factory ReprintReceivingCardForKittingRequestModel.fromJson(
          Map<String, dynamic> json) =>
      _$ReprintReceivingCardForKittingRequestModelFromJson(json);

  final String? barcode;
  final int? quantity;
  final bool? isPreview;

  @override
  Map<String, dynamic> toJson() =>
      _$ReprintReceivingCardForKittingRequestModelToJson(this);
}
