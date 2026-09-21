import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/entities/barcode/barcode.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/entities/receiving_card_item.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/subsystem/printer/printer.dart';

part 'find_barcode_lost_state.freezed.dart';

@freezed
class FindBarcodeLostState extends BaseState with _$FindBarcodeLostState {
  factory FindBarcodeLostState({
    @Default(PageStatus.loaded) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(null) ErrorEntity? errorEntity,
    @Default(0) int activePage,
    @Default(null) ReceivingCard? receivingCard,
    @Default(null) Barcode? barcode,
    @Default([]) List<ReceivingCardItem> listBoxAlive,
  }) = _FindBarcodeLostState;
}
