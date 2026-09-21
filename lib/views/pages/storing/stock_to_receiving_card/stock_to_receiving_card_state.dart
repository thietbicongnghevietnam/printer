import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/entities/barcode/barcode.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/entities/stock_card.dart';
import 'package:smart_warehouse/entities/warehouse_card.dart';
import 'package:smart_warehouse/enums/storage_scan_recard_error.dart';
import 'package:smart_warehouse/services/models/response/plant_type_freqquency_response_model.dart';
import 'package:smart_warehouse/services/models/response/qm_sampling_rohs_response_model.dart';
import 'package:smart_warehouse/services/models/response/sloc_info_from_plant_response_model.dart';
import 'package:smart_warehouse/services/models/response/urgen_sloc_response_model.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';

part 'stock_to_receiving_card_state.freezed.dart';

@freezed
class StockToReceivingCardState extends BaseState with _$StockToReceivingCardState {
  factory StockToReceivingCardState({
    @Default(PageStatus.loaded) PageStatus pageStatus,
    @Default(false) bool processing,
    @Default(null) ErrorEntity? errorEntity,
    @Default(null) StockToRcError? stockToRcError,
    @Default(null) StockCard? stockCard,
    @Default(null) WareHouseCard? wareHouseCard,
    @Default(null) DateTime? rcTime,
    @Default('') String currentCategory,
    @Default(null) PlantTypeFrequencyResponseModel? currentPlant,
    @Default(null) SlocInfoFromPlantResponseModel? currentSloc,
    @Default([])List<SlocInfoFromPlantResponseModel> currentListSloc,
    @Default([])List<PlantTypeFrequencyResponseModel> listPlant,
    @Default([])List<String> currentListCate,
    @Default([])List<Barcode> boxCardList,
    @Default(null) UrgenSlocResponseModel? urgenUlcoc,
    @Default(null) QmSamplingRohsResponseModel? samplingRohsVendor,
    @Default(null) ReceivingCard? receivingCardConverted,
    @Default(null) int? boxCardTotal,
  }) = _StockToReceivingCardState;
}
