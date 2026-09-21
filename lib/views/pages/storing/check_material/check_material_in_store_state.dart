import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/entities/ta_re_card_item.dart';
import 'package:smart_warehouse/services/models/response/material_location_response_model.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';

part 'check_material_in_store_state.freezed.dart';

@freezed
class CheckMaterialInStoreState extends BaseState
    with _$CheckMaterialInStoreState {
  factory CheckMaterialInStoreState({
    @Default(PageStatus.loaded) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default('') String position,
    @Default(null) ReceivingCard? currentReCard,
    @Default([]) List<MaterialLocationResponseModel> materialList,
    @Default(null) ErrorEntity? errorEntity,
  }) = _CheckMaterialInStoreState;
}
