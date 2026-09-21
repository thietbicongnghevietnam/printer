import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/services/models/request/store_goods_request_model.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';

part 'storage_borrow_item_state.freezed.dart';

@freezed
class StorageBorrowItemState extends BaseState with _$StorageBorrowItemState {
  factory StorageBorrowItemState({
    @Default(PageStatus.loaded) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default('') String goods,
    @Default('') String remark,
    @Default('') String location,
    @Default(false) bool hasStored,
    @Default([]) List<StoreGoodsRequestModel> itemList,
    @Default(null) ErrorEntity? errorEntity,
  }) = _StorageBorrowItemState;
}
