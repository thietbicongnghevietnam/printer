import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/services/models/response/history_information_response_model.dart';
import 'package:smart_warehouse/services/models/response/material_history_transition_response_model.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';

part 'material_history_transition_state.freezed.dart';

@freezed
class MaterialHistoryTransitionState extends BaseState
    with _$MaterialHistoryTransitionState {
  factory MaterialHistoryTransitionState({
    @Default(PageStatus.initial) PageStatus pageStatus,
    @Default(false) bool processing,
    required DateTime fromDate,
    required DateTime toDate,
    @Default(null)
    MaterialHistoryTransitionResponseModel? materialHistoryTransition,
    @Default(false) bool onSearchHistory,
    @Default(false) bool hasActiveBack,
    @Default(false) bool isOpenPage,
    @Default('') String positionBack,
    @Default(null) String? currentSloc,
    @Default([]) List<HistoryInformationResponseModel> historyList,
    @Default([]) List<String> listSlocOnMaterial,
    @Default(null) ErrorEntity? errorEntity,
  }) = _MaterialHistoryTransitionState;
}
