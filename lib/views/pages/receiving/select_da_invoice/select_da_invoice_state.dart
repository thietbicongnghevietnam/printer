import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/entities/delivery_plan.dart';
import 'package:smart_warehouse/entities/delivery_plan_filter.dart';
import 'package:smart_warehouse/entities/vendor.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';

part 'select_da_invoice_state.freezed.dart';

@freezed
class SelectDAInvoiceState extends BaseState with _$SelectDAInvoiceState {
  factory SelectDAInvoiceState({
    @Default(PageStatus.initial) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(null) ErrorEntity? errorEntity,
    @Default(null) DeliveryPlanFilter? filter,
    @Default(false) bool isFiltering,
    @Default(1) int page,
    @Default([]) List<Vendor> vendors,
    @Default([]) List<DeliveryPlan> daInvoices,
  }) = _SelectDAInvoiceState;
}
