import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/entities/e_map/order_block.dart';
import 'package:smart_warehouse/entities/e_map/suggest_path.dart';
import 'package:smart_warehouse/entities/kitting/kitting_detail.dart';
import 'package:smart_warehouse/entities/kitting_request.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/entities/receiving_card_item.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';

part 'kitting_model_state.freezed.dart';

@Freezed()
class KittingModelState extends BaseState with _$KittingModelState {
  factory KittingModelState({
    @Default(PageStatus.loaded) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(null) ErrorEntity? errorEntity,
    @Default([]) List<KittingDetail> kittingModels,
    @Default(null) String? material,
    @Default(0) int quantityStorage,
    @Default([]) List<ReceivingCard>? receivingCards,
    @Default(0) int totalQuantityBarcode,
    @Default(0) int totalQuantityNeedScan,
    List<int>? receivingCardIds,
    List<int>? receivingCardItemIds,
    @Default([]) List<KittingRequest> kittingRequests,
    String? kittingTimeTypeString,
    int? startTime,
    int? endTime,
    @Default(0) int page,
    @Default(0) int totalRecord,
    @Default(0) int countKittingDone,
    @Default(0) int count,
    @Default([]) List<ReceivingCardItem>? receivingCardItems,
    @Default(null) ReceivingCard? receivingCard,
    @Default(null) ReceivingCardItem? receivingCardItem,
    @Default('') String model,
    String? deliveryDate,
    @Default(null) bool? isOnTheHour,
    @Default(false) bool isKittingEnough,
    @Default([]) List<OrderBlock>? orderBlocks,
    @Default([]) List<SuggestPath>? suggestPaths,
    @Default(0.0) double qtyBarcodeOnLocationScanned,
    @Default(0.0) double qtyOnLocation,
    @Default(false) bool isScanEnough,
    String? locationOfBarcode,
    @Default(false) bool isDay,
  }) = _KittingModelState;
}
