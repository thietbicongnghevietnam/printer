import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/services/models/response/material_sample_responses_model.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';

part 'material_sample_state.freezed.dart';

@freezed
class MaterialSampleState extends BaseState with _$MaterialSampleState {
  factory MaterialSampleState({
    @Default(PageStatus.initial) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(null) MaterialSampleResponseModel? materialSample,
    @Default(null) ErrorEntity? errorEntity,
  }) = _MaterialSampleState;
}
