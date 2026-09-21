import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/entities/ta_re_card_item.dart';
import 'package:smart_warehouse/services/models/response/zone_detail_response_model.dart';
import 'package:smart_warehouse/services/models/response/zone_floor_response_model.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';

part 'zone_detail_state.freezed.dart';

@freezed
class ZoneDetailState extends BaseState with _$ZoneDetailState {
  factory ZoneDetailState({
    @Default(PageStatus.initial) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(null) ErrorEntity? errorEntity,
    @Default(null) CustomReCardItem? currentReCard,
    @Default(null) ZoneFloorResponseModel? zoneData,
    @Default(null) ZoneDetailResponseModel? zoneDetailData,
  }) = _ZoneDetailState;
}
