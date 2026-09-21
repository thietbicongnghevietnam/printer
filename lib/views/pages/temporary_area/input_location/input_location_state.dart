import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';

part 'input_location_state.freezed.dart';

@freezed
class InputLocationState extends BaseState with _$InputLocationState {
  factory InputLocationState({
    @Default(PageStatus.loaded) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(null) ErrorEntity? errorEntity,
    @Default(null) String? receivingCardData,
    @Default(null) String? palletData,
    @Default([]) List<String> listReceivingCard,
    @Default([]) List<ReceivingCard> listReceivingCardInPallet,
  }) = _InputLocationState;
}
