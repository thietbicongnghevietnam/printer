import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/entities/ta_re_card_item.dart';
import 'package:smart_warehouse/enums/out_storage_type.dart';
import 'package:smart_warehouse/services/models/request/move_out_store_request_model.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';

part 'out_storage_state.freezed.dart';

@freezed
class OutStorageState extends BaseState with _$OutStorageState {
  factory OutStorageState({
    @Default(PageStatus.loaded) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(false) bool qcCheck,
    @Default(null) String? reason,
    @Default(null) String? location,
    @Default(OutStorageType.oneByOne) OutStorageType outType,
    @Default(null) CustomReCardItem? currentReceivingCard,
    @Default([]) List<MoveOutStoreRequestModel> outList,
    @Default(null) ErrorEntity? errorEntity,
  }) = _OutStorageState;
}
