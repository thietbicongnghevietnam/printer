import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/entities/qr_card.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';

part 'one_for_all_state.freezed.dart';

@freezed
class OneForAllState extends BaseState with _$OneForAllState {
  factory OneForAllState({
    @Default(PageStatus.initial) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(null) ErrorEntity? errorEntity,
    @Default(null) QRCard? qrCard,
  }) = _OneForAllState;
}
