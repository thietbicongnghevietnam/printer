import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/entities/inventory/plant_sloc_category.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/entities/receiving_card_item.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';

part 'split_receiving_card_state.freezed.dart';

@freezed
class SplitReceivingCardState extends BaseState with _$SplitReceivingCardState {
  factory SplitReceivingCardState({
    @Default(PageStatus.initial) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(null) ErrorEntity? errorEntity,
    @Default(null) ReceivingCard? currentReCard,
    @Default(null) PlantCategory? currentPlant,
    @Default(null) CategorySloc? currentCate,
    @Default(null) String? currentSloc,
    @Default(null) String? slocUpdate,
    @Default('') String materialUpdate,
    @Default(false) bool qcSamplingReCheck,
    @Default(false) bool isSamplingCheck,
    @Default([]) List<PlantCategory> listPlant,
    @Default([]) List<CategorySloc> listCate,
    @Default([]) List<String> listSloc,
    @Default([]) List<ReceivingCardItem> listBoxScanned,
  }) = _SplitReceivingCardState;
}
