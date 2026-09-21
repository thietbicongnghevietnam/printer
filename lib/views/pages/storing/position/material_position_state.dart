import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/services/models/response/material_location_response_model.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';

part 'material_position_state.freezed.dart';

@freezed
class MaterialPositionState extends BaseState with _$MaterialPositionState {
  factory MaterialPositionState({
    @Default(PageStatus.initial) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default([]) List<MaterialLocationResponseModel> materialList,
    @Default(null) ErrorEntity? errorEntity,
  }) = _MaterialPositionState;
}
