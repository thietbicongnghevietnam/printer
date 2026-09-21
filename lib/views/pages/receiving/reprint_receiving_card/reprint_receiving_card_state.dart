import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/subsystem/printer/printer.dart';

part 'reprint_receiving_card_state.freezed.dart';

@freezed
class ReprintReceivingCardState extends BaseState with _$ReprintReceivingCardState {
  factory ReprintReceivingCardState({
    @Default(PageStatus.loaded) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(null) ErrorEntity? errorEntity,
    @Default([]) List<ReceivingCard> receivingCard,
    @Default([]) List<PrinterDevice> printerDevices,
    @Default(null) PrinterDevice? selectedPrinterDevice,
  }) = _ReprintReceivingCardState;
}
