import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/entities/e_map/offset_block_detail.dart';
import 'package:smart_warehouse/entities/ta_re_card_item.dart';
import 'package:smart_warehouse/services/models/response/rack_detail_response_model.dart';
import 'package:smart_warehouse/services/models/response/receiving_card_by_block_response_model.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';

part 'rack_detail_state.freezed.dart';

@freezed
class RackDetailState extends BaseState with _$RackDetailState {
  factory RackDetailState({
    @Default(PageStatus.initial) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(null) ErrorEntity? errorEntity,
    @Default(null) CustomReCardItem? currentReCard,
    @Default(null) RackDetailResponseModel? rackDataDetail,
    @Default(null) bool? loadedReceivingCard,
    @Default([]) List<OffsetBlockDetail> listOffsetTap,
    @Default([]) List<ReceivingCardByBlockResponseModel> listReceivingCard,
  }) = _RackDetailState;
}
