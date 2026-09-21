import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/enums/storage_scan_recard_error.dart';
import 'package:smart_warehouse/services/models/response/receiving_card_response_model.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';

part 'check_rc_on_location_state.freezed.dart';

@freezed
class CheckRcOnLocationState extends BaseState with _$CheckRcOnLocationState {
  factory CheckRcOnLocationState({
    @Default(PageStatus.loaded) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(null) ErrorEntity? errorEntity,
    @Default([]) List<ReceivingCard> listReCard,
  }) = _CheckRcOnLocationState;
}
