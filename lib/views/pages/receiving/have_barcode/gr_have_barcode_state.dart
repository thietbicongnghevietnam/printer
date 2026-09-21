import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/entities/delivery_plan.dart';
import 'package:smart_warehouse/entities/delivery_plan_detail.dart';
import 'package:smart_warehouse/entities/draft_receiving_card.dart';
import 'package:smart_warehouse/entities/material_info.dart';
import 'package:smart_warehouse/entities/receiving_card_item.dart';
import 'package:smart_warehouse/enums/scan_type.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';

part 'gr_have_barcode_state.freezed.dart';

@freezed
class GRHaveBarcodeState extends BaseState with _$GRHaveBarcodeState {
  factory GRHaveBarcodeState({
    @Default(PageStatus.initial) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(null) ErrorEntity? errorEntity,
    @Default(ScanType.scanByBox) ScanType scanType,
    @Default(null) ReceivingCardItem? scanningItem,
    @Default([]) List<ReceivingCardItem> scannedItems,
    @Default(null) DeliveryPlan? deliveryPlan,
    @Default(null) MaterialInfo? materialInfo,
    @Default(null) DeliveryPlanDetail? deliveryPlanDetail,
    @Default([]) List<ReceivingCardItem> receivingCardItems,
    @Default([]) List<DraftReceivingCard> draftReceivingCards,
  }) = _GRHaveBarcodeState;
}
