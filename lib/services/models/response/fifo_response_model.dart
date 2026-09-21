import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_response_model.dart';

part 'fifo_response_model.g.dart';

@JsonSerializable()
class FifoResponseModel extends BaseResponseModel {
  const FifoResponseModel(this.id, this.barcode);

  factory FifoResponseModel.fromJson(Map<String, dynamic> json) =>
      _$FifoResponseModelFromJson(json);

  final int? id;
  final String? barcode;

  @override
  Map<String, dynamic> toJson() => _$FifoResponseModelToJson(this);
}
