import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_request_model.dart';

part 'qc_borrow_rc_request_model.g.dart';

@JsonSerializable()
class QCBorrowRcRequestModel extends BaseRequestModel {
  const QCBorrowRcRequestModel({
    this.rcBarcode,
    this.quantity = 0,
    this.listBoxCardRQ,
  });

  factory QCBorrowRcRequestModel.fromJson(Map<String, dynamic> json) =>
      _$QCBorrowRcRequestModelFromJson(json);

  @JsonKey(name: 'barcode')
  final String? rcBarcode;

  @JsonKey(name: 'quantity')
  final int quantity;

  @JsonKey(name: 'qtyBoxQCRequests')
  final List<BoxQCQtyRequestModel>? listBoxCardRQ;


  @override
  Map<String, dynamic> toJson() => _$QCBorrowRcRequestModelToJson(this);
}


@JsonSerializable()
class BoxQCQtyRequestModel extends BaseRequestModel {
  const BoxQCQtyRequestModel({
    this.barcodeBox,
    this.quantity,
    this.rcBarcode,
  });

  factory BoxQCQtyRequestModel.fromJson(Map<String, dynamic> json) =>
      _$BoxQCQtyRequestModelFromJson(json);

  @JsonKey(name: 'barcodeBox')
  final String? barcodeBox;

  @JsonKey(name: 'quantity')
  final int? quantity;

  @JsonKey(name: 'barcode')
  final String? rcBarcode;

  @override
  Map<String, dynamic> toJson() => _$BoxQCQtyRequestModelToJson(this);
}
