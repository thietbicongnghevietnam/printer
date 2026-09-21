import 'dart:ffi';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/entities/kitting/kitting_card.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/entities/receiving_card_kitting.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/subsystem/printer/printer.dart';
import 'package:smart_warehouse/views/pages/kitting/return_kitting/return_kitting_page.dart';

part 'return_kitting_state.freezed.dart';

@Freezed()
class ReturnKittingState extends BaseState with _$ReturnKittingState {
  factory ReturnKittingState({
    @Default(PageStatus.loaded) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(null) ErrorEntity? errorEntity,
    @Default(ReturnKittingType.inPlan) ReturnKittingType returnKittingType,
    @Default([]) List<KittingCard> kittingCards,
    @Default(null) String? material,
    @Default(null) int? quantity,
    @Default(null) String? plant,
    @Default(null) String? sloc,
    @Default(null) String? category,
    @Default([]) List<String> listPlants,
    @Default([]) List<String> listSlocs,
    @Default([]) List<String> listCategories,
    @Default(null) ReceivingCard? receivingCard,
    @Default(null) PrinterDevice? savePrinterDevice,
    @Default([]) List<PrinterDevice> printerDevices,
  }) = _ReturnKittingState;
}
