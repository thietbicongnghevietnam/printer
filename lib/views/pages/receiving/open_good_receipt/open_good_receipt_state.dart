import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/entities/material_info.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/subsystem/printer/printer.dart';

part 'open_good_receipt_state.freezed.dart';

@freezed
class OpenGoodReceiptState extends BaseState with _$OpenGoodReceiptState {
  factory OpenGoodReceiptState({
    @Default(PageStatus.initial) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(null) ErrorEntity? errorEntity,
    @Default(null) ReceivingCard? receivingCard,
    @Default(null) MaterialInfo? materialInfo,
    @Default([]) List<PrinterDevice> printerDevices,
    @Default(null) PrinterDevice? selectedPrinterDevice,
  }) = _OpenGoodReceiptState;
}
