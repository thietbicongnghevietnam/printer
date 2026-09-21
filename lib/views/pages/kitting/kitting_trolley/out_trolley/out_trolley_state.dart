import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/enums/in_out_type.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';

part 'out_trolley_state.freezed.dart';

@freezed
class OutTrolleyState extends BaseState with _$OutTrolleyState {
  factory OutTrolleyState({
    @Default(PageStatus.loaded) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(null) ErrorEntity? errorEntity,
    @Default(null) String? trolleyBarcode,
  }) = _OutTrolleyState;
}
