import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/entities/e_map/order_block.dart';
import 'package:smart_warehouse/entities/e_map/suggest_path.dart';
import 'package:smart_warehouse/entities/kitting/kitting_detail.dart';
import 'package:smart_warehouse/entities/kitting_filter.dart';
import 'package:smart_warehouse/entities/storage_card.dart';
import 'package:smart_warehouse/enums/kitting_type.dart';
import 'package:smart_warehouse/services/models/response/material_location_response_model.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';

part 'kitting_state.freezed.dart';

@Freezed(makeCollectionsUnmodifiable: true)
class KittingState extends BaseState with _$KittingState {
  factory KittingState({
    @Default(PageStatus.initial) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(null) ErrorEntity? errorEntity,
    @Default([]) List<KittingDetail> kittingDetails,
    @Default([]) List<int> selectedKittingDetails,
    @Default([]) List<OrderBlock> orderBlocks,
    @Default([]) List<SuggestPath> suggestPaths,
    @Default(KittingFilter(kittingType: KittingType.fa)) KittingFilter kittingFilter,
    @Default(null) StorageCard? scanningItem,
    @Default(null) String? scanningLocation,
    @Default([]) List<StorageCard> kittingBoxScanned,
    @Default(null) List<MaterialLocationResponseModel>? receivingCardInLocation,
  }) = _KittingState;
}
