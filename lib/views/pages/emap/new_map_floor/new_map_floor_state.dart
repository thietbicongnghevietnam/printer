import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/entities/e_map/emap_floor.dart';
import 'package:smart_warehouse/entities/e_map/emap_kiting_suggest.dart';
import 'package:smart_warehouse/services/models/response/map_suggest_widget_response_model.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';

part 'new_map_floor_state.freezed.dart';

@freezed
class NewMapFloorState extends BaseState with _$NewMapFloorState {
  factory NewMapFloorState({
    @Default(PageStatus.initial) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(null) ErrorEntity? errorEntity,
    @Default(null) String? material,
    @Default(null) int? receivingCardId,
    @Default(null) EMapFloor? floorUIData,
    @Default(null) EMapKittingSuggest? emapKittingSuggest,
    @Default([]) List<MapSuggestWidgetResponseModel> floorList,
  }) = _NewMapFloorState;
}
