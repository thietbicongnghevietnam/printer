import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/entities/receiving_card_item.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';

part 'barcode_scanned_state.freezed.dart';

@Freezed()
class BarcodeScannedState extends BaseState with _$BarcodeScannedState {
  factory BarcodeScannedState({
    @Default(PageStatus.loaded) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(null) ErrorEntity? errorEntity,
    @Default([]) List<ReceivingCard>? receivingCards ,
    @Default([]) List<ReceivingCardItem>? receivingCardItems,
  }) = _BarcodeScannedState;
}
