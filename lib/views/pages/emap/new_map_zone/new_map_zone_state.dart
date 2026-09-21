import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/entities/e_map/emap_zone.dart';
import 'package:smart_warehouse/entities/ta_re_card_item.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';

part 'new_map_zone_state.freezed.dart';

@freezed
class NewMapZoneState extends BaseState with _$NewMapZoneState {
  factory NewMapZoneState({
    @Default(PageStatus.initial) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(null) ErrorEntity? errorEntity,
    @Default(null) CustomReCardItem? currentReCard,
    @Default(null) EMapZone? zoneMapData,
    // @Default(null) NewMapWidgetResponseModel? zoneMapData,
  }) = _NewMapZoneState;
}
