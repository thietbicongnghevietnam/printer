import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/entities/ta_re_card_item.dart';
import 'package:smart_warehouse/services/models/response/floor_map_response_model.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';

part 'floor_detail_state.freezed.dart';

@freezed
class FloorDetailState extends BaseState with _$FloorDetailState {
  factory FloorDetailState({
    @Default(PageStatus.initial) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(null) ErrorEntity? errorEntity,
    @Default(null) CustomReCardItem? currentReCard,
    @Default(null) FloorMapResponseModel? floorData,
  }) = _FloorDetailState;
}
