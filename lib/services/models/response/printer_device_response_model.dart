import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_response_model.dart';

part 'printer_device_response_model.g.dart';

@JsonSerializable()
class PrinterDeviceResponseModel extends BaseResponseModel {
  const PrinterDeviceResponseModel(this.id, this.macAddress);

  factory PrinterDeviceResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PrinterDeviceResponseModelFromJson(json);

  final String id;
  final String macAddress;

  @override
  Map<String, dynamic> toJson() => _$PrinterDeviceResponseModelToJson(this);
}
