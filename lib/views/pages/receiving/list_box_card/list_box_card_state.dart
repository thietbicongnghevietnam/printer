import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';

part 'list_box_card_state.freezed.dart';

@freezed
class ListBoxCardState extends BaseState with _$ListBoxCardState {
  factory ListBoxCardState({
    @Default(PageStatus.loaded) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(null) ErrorEntity? errorEntity,
    @Default(0) int totalQuantity,
  }) = _ListBoxCardState;
}
