import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/entities/barcode/barcode.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/subsystem/printer/printer.dart';

part 'reprint_barcode_ng_state.freezed.dart';

@freezed
class ReprintBarcodeNGState extends BaseState with _$ReprintBarcodeNGState {
  factory ReprintBarcodeNGState({
    @Default(PageStatus.loaded) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(null) ErrorEntity? errorEntity,
    @Default(null) Barcode? barcode,
    @Default([]) List<PrinterDevice> printerDevices,
    @Default(null) PrinterDevice? selectedPrinterDevice,
  }) = _ReprintBarcodeNGState;
}
