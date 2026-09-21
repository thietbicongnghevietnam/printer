import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/subsystem/printer/printer.dart';

part 'reprint_rc_convert_state.freezed.dart';

@freezed
class RePrintRcConvertState extends BaseState with _$RePrintRcConvertState {
  factory RePrintRcConvertState({
    @Default(PageStatus.initial) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(null) ErrorEntity? errorEntity,
    @Default(null) ReceivingCard? receivingCard,
    @Default([]) List<PrinterDevice> printerDevices,
    @Default(null) PrinterDevice? selectedPrinterDevice,
  }) = _RePrintRcConvertState;
}
