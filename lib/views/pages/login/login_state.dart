import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState extends BaseState with _$LoginState {
  factory LoginState({
    @Default(PageStatus.initial) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(null) ErrorEntity? errorEntity,
    @Default('') String username,
    @Default('') String version,
    @Default(false) bool newVersion,
  }) = _LoginState;
}
