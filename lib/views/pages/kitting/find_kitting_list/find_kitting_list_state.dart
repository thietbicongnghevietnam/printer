import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/entities/kitting/kitting_list.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';

part 'find_kitting_list_state.freezed.dart';

@Freezed()
class FindKittingListState extends BaseState with _$FindKittingListState {
  factory FindKittingListState({
    @Default(PageStatus.loaded) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(null) ErrorEntity? errorEntity,
    @Default(null) KittingList? kittingList,
    @Default([]) List<String> codeTrolleys,
}) = _FindKittingListState;
}
