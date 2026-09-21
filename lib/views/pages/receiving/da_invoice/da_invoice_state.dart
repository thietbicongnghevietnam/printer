import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/entities/delivery_plan.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';

part 'da_invoice_state.freezed.dart';

@freezed
class DAInvoiceState extends BaseState with _$DAInvoiceState {
  factory DAInvoiceState({
    @Default(PageStatus.initial) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(null) ErrorEntity? errorEntity,
    @Default(null) DeliveryPlan? deliveryPlan,
  }) = _DAInvoiceState;
}
