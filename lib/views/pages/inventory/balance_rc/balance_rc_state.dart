import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/entities/barcode/barcode.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/entities/receiving_card_item.dart';
import 'package:smart_warehouse/enums/balance_scan_type.dart';
import 'package:smart_warehouse/services/models/request/create_balance_rc_qty_request_model.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';

part 'balance_rc_state.freezed.dart';

@freezed
class BalanceRcState extends BaseState with _$BalanceRcState {
  factory BalanceRcState({
    @Default(PageStatus.loaded) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(null) ErrorEntity? errorEntity,
    @Default(BalanceScanType.scanRc) BalanceScanType balanceScanType,
    @Default(null) int? updateQty,
    @Default(null) int? backUpTotalBalance,
    @Default(null) int? currentQty,
    @Default(null) int? boxTotal,
    @Default(true) bool balanceAllBox,
    @Default(false) bool balanceAllLot,
    @Default(null) ReceivingCard? receivingCard,
    @Default(null) Barcode? boxCard,
    @Default([]) List<BalanceBoxRequestModel> balanceBoxList,
    @Default([]) List<ReceivingCardItem> boxCardWillBalance,
    @Default([]) List<ReceivingCardItem> boxListShowTotalChange,
    @Default([]) List<ReceivingCard> listReceivingCardScanned,
  }) = _BalanceRcState;
}
