import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/services/models/response/borrow_goods_response_model.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';

part 'list_borrow_item_state.freezed.dart';

@freezed
class ListBorrowItemState extends BaseState with _$ListBorrowItemState {
  factory ListBorrowItemState({
    @Default(PageStatus.initial) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(false) bool isSearched,
    @Default(1) int pageNumber,
    @Default(10) int pageSize,
    @Default('') String searchName,
    @Default([]) List<BorrowGoodsResponseModel> borrowGoodsList,
    @Default(null) ErrorEntity? errorEntity,
  }) = _ListBorrowItemState;
}
