import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/entities/inventory/balance_detail.dart';
import 'package:smart_warehouse/entities/inventory/plant_sloc_category.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/services/models/request/create_balance_qty_request_model.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';

part 'balance_all_state.freezed.dart';

@freezed
class BalanceAllState extends BaseState with _$BalanceAllState {
  factory BalanceAllState({
    @Default(PageStatus.initial) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(null) ErrorEntity? errorEntity,
    @Default(null) int? pageNumber,
    @Default(null) int? pageSize,
    @Default(null) int? qtyBalanceUpdate,
    @Default(null) int? qtySystemUpdate,
    @Default(false) bool? isSearched,
    @Default(null) PlantCategory? currentPlant,
    @Default(null) CategorySloc? currentCate,
    @Default(null) String? currentSloc,
    @Default(null) ReceivingCard? receivingCard,
    @Default([]) List<PlantCategory> listPlant,
    @Default([]) List<CategorySloc> listCate,
    @Default([]) List<String> listSloc,
    @Default([]) List<BalanceDetail> listBalanceDetail,
    @Default([]) List<CreateBalanceQtyRequestModel> listUpdateBalance,
  }) = _BalanceAllState;
}
