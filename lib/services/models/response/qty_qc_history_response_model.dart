import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/services/models/response/base_response_model.dart';

part 'qty_qc_history_response_model.g.dart';

@JsonSerializable()
class QtyQCHistoryResponseModel extends BaseResponseModel {
  const QtyQCHistoryResponseModel({
    this.barcodeBox,
    this.barcode,
    this.qtyBox,
    this.qtyRC,
    this.material,
    this.plant,
    this.sloc,
  });

  factory QtyQCHistoryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$QtyQCHistoryResponseModelFromJson(json);

  final String? barcodeBox;
  final String? barcode;
  final String? material;
  final String? plant;
  final String? sloc;

  final int? qtyBox;
  final int? qtyRC;

  @override
  Map<String, dynamic> toJson() => _$QtyQCHistoryResponseModelToJson(this);
}
