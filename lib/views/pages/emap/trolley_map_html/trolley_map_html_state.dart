import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/services/models/response/map_trolley_response_model.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';

part 'trolley_map_html_state.freezed.dart';

@freezed
class TrolleyMapHTMLState extends BaseState with _$TrolleyMapHTMLState {
  factory TrolleyMapHTMLState({
    @Default(PageStatus.loaded) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(null) ErrorEntity? errorEntity,
    @Default(null) MapTrolleyResponsesModel? trolleyMapData,
  }) = _TrolleyMapHTMLState;
}
