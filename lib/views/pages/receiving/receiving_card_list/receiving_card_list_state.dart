import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/subsystem/printer/printer.dart';

part 'receiving_card_list_state.freezed.dart';

@freezed
class ReceivingCardListState extends BaseState with _$ReceivingCardListState {
  factory ReceivingCardListState({
    @Default(PageStatus.initial) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(null) ErrorEntity? errorEntity,
    @Default([]) List<ReceivingCard> receivingCards,
    @Default([]) List<PrinterDevice> printerDevices,
    @Default(null) PrinterDevice? selectedPrinterDevice,
  }) = _ReceivingCardListState;
}
