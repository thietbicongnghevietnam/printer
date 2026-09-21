import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/enums/storage_scan_recard_error.dart';
import 'package:smart_warehouse/services/models/response/receiving_card_response_model.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';

part 'storage_rc_card_state.freezed.dart';

@freezed
class StorageRCCardState extends BaseState with _$StorageRCCardState {
  factory StorageRCCardState({
    @Default(PageStatus.loaded) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(null) ErrorEntity? errorEntity,
    @Default(null) String? location,
    @Default(null) bool? isJIT,
    @Default(null) ReceivingCard? currentReCard,
    @Default(null) StorageScanReCardError? storageScanReCardError,
    @Default([]) List<ReceivingCard> listReCard,
  }) = _StorageRCCardState;
}
