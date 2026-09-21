import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/entities/barcode/barcode.dart';
import 'package:smart_warehouse/entities/receiving_card_item.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';

part 'check_barcode_lack_state.freezed.dart';

@freezed
class CheckBarcodeLackState extends BaseState with _$CheckBarcodeLackState {
  factory CheckBarcodeLackState({
    @Default(PageStatus.initial) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(null) ErrorEntity? errorEntity,
    @Default([]) List<Barcode> barcodes,
    @Default([]) List<ReceivingCardItem> scannedBarcodes,
  }) = _CheckBarcodeLackState;
}
