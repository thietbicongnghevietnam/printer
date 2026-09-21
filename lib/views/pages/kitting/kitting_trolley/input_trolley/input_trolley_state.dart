import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';

part 'input_trolley_state.freezed.dart';

@freezed
class InputTrolleyState extends BaseState with _$InputTrolleyState {
  factory InputTrolleyState({
    @Default(PageStatus.loaded) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(null) ErrorEntity? errorEntity,
    @Default('') String trolley,
    @Default([]) List<String> listKittingCardQr,
  }) = _InputTrolleyState;
}
