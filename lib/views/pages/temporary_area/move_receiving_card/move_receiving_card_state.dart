import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/enums/in_out_type.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';

part 'move_receiving_card_state.freezed.dart';

@freezed
class MoveReceivingCardState extends BaseState with _$MoveReceivingCardState {
  factory MoveReceivingCardState({
    @Default(PageStatus.loaded) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(null) ErrorEntity? errorEntity,
    @Default(null) String? currentReceivingCard,
    @Default([]) List<ReceivingCard> listReceivingCards,
    @Default(null) String? palletSource,
    @Default(null) String? palletEnd,
    @Default(InOutType.oneByOne) InOutType inOutType,
  }) = _MoveReceivingCardState;
}
