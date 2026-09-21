import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/enums/in_out_type.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';

part 'out_receiving_card_state.freezed.dart';

@freezed
class OutReceivingCardState extends BaseState with _$OutReceivingCardState {
  factory OutReceivingCardState({
    @Default(PageStatus.loaded) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(null) ErrorEntity? errorEntity,
    @Default(null) String? receivingCard,
    @Default(null) String? pallet,
    @Default(InOutType.oneByOne) InOutType inOutType,
    @Default([]) List<ReceivingCard> receivingCards,
  }) = _OutReceivingCardState;
}
