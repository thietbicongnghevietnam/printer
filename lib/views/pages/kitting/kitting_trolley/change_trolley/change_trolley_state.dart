import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/enums/in_out_type.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';

part 'change_trolley_state.freezed.dart';

@freezed
class ChangeTrolleyState extends BaseState with _$ChangeTrolleyState {
  factory ChangeTrolleyState({
    @Default(PageStatus.loaded) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(null) ErrorEntity? errorEntity,
    @Default(null) String? trolleySource,
    @Default(null) String? trolleyEnd,
    @Default([]) List<String> barCodeKittingList,
  }) = _ChangeTrolleyState;
}
