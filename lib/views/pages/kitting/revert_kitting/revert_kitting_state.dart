import 'dart:ffi';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/entities/kitting/kitting_card.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/entities/receiving_card_kitting.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/subsystem/printer/printer.dart';

part 'revert_kitting_state.freezed.dart';

@Freezed()
class RevertKittingState extends BaseState with _$RevertKittingState {
  factory RevertKittingState({
    @Default(PageStatus.loaded) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(null) ErrorEntity? errorEntity,
    @Default([]) List<KittingCard> kittingCards,
    @Default([]) List<ReceivingCard> receivingCards,
    @Default(null) PrinterDevice? savePrinterDevice,
    @Default([]) List<PrinterDevice> printerDevices,
  }) = _RevertKittingState;
}
