import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/entities/kitting/kitting_card.dart';
import 'package:smart_warehouse/entities/kitting/kitting_detail.dart';
import 'package:smart_warehouse/entities/kitting/kitting_list.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';

part 'check_list_kitting_detail_state.freezed.dart';
@freezed
class CheckListKittingDetailState extends BaseState with _$CheckListKittingDetailState {
  factory CheckListKittingDetailState({
    @Default(PageStatus.loaded) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(null) ErrorEntity? errorEntity,
    @Default([]) List<KittingDetail> kittingDetails,
    @Default(null) KittingCard? kittingCard,
    @Default(0) int kittingListId,
    @Default(null) KittingList? kittingList,
    String? barcodeKittingList,
  }) = _CheckListKittingDetailState;
}
