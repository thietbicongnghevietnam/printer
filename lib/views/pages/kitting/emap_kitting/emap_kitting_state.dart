import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/entities/e_map/emap_widget.dart';
import 'package:smart_warehouse/entities/e_map/order_block.dart';
import 'package:smart_warehouse/entities/e_map/suggest_path.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';

part 'emap_kitting_state.freezed.dart';

@freezed
class EmapKittingState extends BaseState with _$EmapKittingState {
  factory EmapKittingState({
    @Default(PageStatus.initial) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(null) ErrorEntity? errorEntity,
    @Default(null) EMapWidget? floor,
    @Default([]) List<OrderBlock> orderBlock,
    @Default([]) List<SuggestPath> suggestPath,
  }) = _EmapKittingState;
}
