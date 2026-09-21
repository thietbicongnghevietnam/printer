import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/enums/role.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState extends BaseState with _$HomeState {
  factory HomeState({
    @Default(PageStatus.initial) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(null) ErrorEntity? errorEntity,
    @Default([]) List<Role> roles,
    @Default('') String userId,
  }) = _HomeState;
}
