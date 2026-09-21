import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/entities/barcode/barcode.dart';
import 'package:smart_warehouse/entities/barcode/box_card_barcode.dart';
import 'package:smart_warehouse/entities/delivery_plan.dart';
import 'package:smart_warehouse/entities/delivery_plan_detail.dart';
import 'package:smart_warehouse/entities/material_info.dart';
import 'package:smart_warehouse/entities/receiving_card_item.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';

part 'gr_no_barcode_state.freezed.dart';

@freezed
class GRNoBarcodeState extends BaseState with _$GRNoBarcodeState {
  factory GRNoBarcodeState({
    @Default(PageStatus.initial) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(null) ErrorEntity? errorEntity,
    @Default(null) DeliveryPlan? deliveryPlan,
    @Default(null) DeliveryPlanDetail? selectItem,
    @Default(null) MaterialInfo? materialInfo,
    @Default([]) List<Barcode> barcodes,
    @Default([]) List<ReceivingCardItem> receivingCardItems,
    @Default(0) int quantity,
    @Default(0) int box,
    @Default(null) int? standardPacking,
    @Default(null) int? totalQuantity,
    @Default(null) int? gredQuantity,
    @Default(true) bool isPrintBoxCard,
  }) = _GRNoBarcodeState;
}
