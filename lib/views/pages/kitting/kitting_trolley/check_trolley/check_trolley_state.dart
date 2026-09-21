import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/entities/kitting/kitting_list.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';

part 'check_trolley_state.freezed.dart';

@freezed
class CheckTrolleyState extends BaseState with _$CheckTrolleyState {
  factory CheckTrolleyState({
    @Default(PageStatus.loaded) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(null) ErrorEntity? errorEntity,
    @Default('') String trolley,
    @Default('') String barcode,
    @Default([]) List<KittingList> kittingLists,
  }) = _CheckTrolleyState;
}
