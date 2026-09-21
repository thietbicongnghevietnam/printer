import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/entities/kitting/kitting_list.dart';
import 'package:smart_warehouse/entities/supply.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';

part 'supply_kitting_state.freezed.dart';

@Freezed()
class SupplyKittingState extends BaseState with _$SupplyKittingState {
  factory SupplyKittingState({
    @Default(PageStatus.loaded) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(null) ErrorEntity? errorEntity,
    @Default(null) List<Supply>? supply,
    @Default(null) KittingList? kittingList,
    @Default('') String? barcode,
    @Default('') String? line,
    @Default('') String? pic,
  }) = _SupplytKittingState;
}
