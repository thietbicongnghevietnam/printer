import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/entities/ta_re_card_item.dart';
import 'package:smart_warehouse/enums/change_location_type.dart';
import 'package:smart_warehouse/enums/change_store_location_error.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';

part 'change_store_location_state.freezed.dart';

@freezed
class ChangeStoreLocationState extends BaseState
    with _$ChangeStoreLocationState {
  factory ChangeStoreLocationState({
    @Default(PageStatus.loaded) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(null) String? oldOBOLocation,
    @Default(null) String? newOBOLocation,
    @Default(null) String? newAllLocation,
    @Default(null) String? oldAllLocation,
    @Default(null) String? currentReCard,
    @Default(ChangeLocationType.oneByOne) ChangeLocationType changeLocationType,
    @Default(null) ChangeStoreLocationError? changeStoreLocationError,
    @Default(null) List<CustomReCardItem>? listReCard,
    @Default(null) ErrorEntity? errorEntity,
  }) = _ChangeStoreLocationState;
}
