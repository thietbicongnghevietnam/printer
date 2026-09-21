import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/entities/receiving_card_item.dart';
import 'package:smart_warehouse/entities/storing/box_qc_return.dart';
import 'package:smart_warehouse/entities/storing/qty_qc_history.dart';
import 'package:smart_warehouse/services/models/response/material_location_response_model.dart';
import 'package:smart_warehouse/services/models/response/plant_type_freqquency_response_model.dart';
import 'package:smart_warehouse/services/models/response/sloc_info_from_plant_response_model.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';

import 'iqc_borrow_receiving_card_controller.dart';

part 'iqc_borrow_receiving_card_state.freezed.dart';

@freezed
class IQCBorrowReceivingCardState extends BaseState
    with _$IQCBorrowReceivingCardState {
  factory IQCBorrowReceivingCardState({
    @Default(PageStatus.loaded) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(null) ErrorEntity? errorEntity,
    @Default(IQCBorrowType.borrowRc) IQCBorrowType icqBorrowType,
    @Default('') String qtyInput,
    @Default(null) ReceivingCard? currentReCard,
    @Default(null) PlantTypeFrequencyResponseModel? currentPlant,
    @Default(null) SlocInfoFromPlantResponseModel? currentSloc,
    @Default([])List<SlocInfoFromPlantResponseModel> currentListSloc,
    @Default([])List<PlantTypeFrequencyResponseModel> listPlant,
    @Default([]) List<ReceivingCardItem> listBoxInScanned,
    @Default([]) List<BoxQCReturn> listBoxQtyReturn,
    @Default([]) List<QtyQCHistory> listQtHistory,
  }) = _IQCBorrowReceivingCardState;
}
