import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/services/models/response/receiving_card_by_block_response_model.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';

part 'check_last_lot_state.freezed.dart';

@freezed
class CheckLastLotState extends BaseState with _$CheckLastLotState {
  factory CheckLastLotState({
    @Default(PageStatus.initial) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(null) ErrorEntity? errorEntity,
    @Default([]) List<ReceivingCardByBlockResponseModel> listReceivingCard,
  }) = _CheckLastLotState;
}
