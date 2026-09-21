import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/entities/barcode/barcode.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/services/api_service.dart';
import 'package:smart_warehouse/services/models/request/change_location_request_model.dart';
import 'package:smart_warehouse/services/models/request/combine_location_request_model.dart';
import 'package:smart_warehouse/services/models/request/move_out_all_storage_request_model.dart';
import 'package:smart_warehouse/services/models/request/move_out_store_request_model.dart';
import 'package:smart_warehouse/services/models/request/receiving_card_by_stock_request_model.dart';
import 'package:smart_warehouse/services/models/request/receiving_card_model.dart';
import 'package:smart_warehouse/services/models/request/store_goods_request_model.dart';
import 'package:smart_warehouse/services/models/request/store_recard_request_model.dart';
import 'package:smart_warehouse/services/models/response/all_plant_sloc_response_model.dart';
import 'package:smart_warehouse/services/models/response/borrow_goods_response_model.dart';
import 'package:smart_warehouse/services/models/response/box_quantity_response_model.dart';
import 'package:smart_warehouse/services/models/response/location_response_model.dart';
import 'package:smart_warehouse/services/models/response/material_history_transition_response_model.dart';
import 'package:smart_warehouse/services/models/response/material_location_response_model.dart';
import 'package:smart_warehouse/services/models/response/material_sample_responses_model.dart';
import 'package:smart_warehouse/services/models/response/plant_type_freqquency_response_model.dart';
import 'package:smart_warehouse/services/models/response/qm_sampling_rohs_response_model.dart';
import 'package:smart_warehouse/services/models/response/receiving_card_response_model.dart';
import 'package:smart_warehouse/services/models/response/sloc_info_from_plant_response_model.dart';
import 'package:smart_warehouse/services/models/response/stock_to_recard_response_model.dart';
import 'package:smart_warehouse/services/models/response/urgen_sloc_response_model.dart';
import 'package:smart_warehouse/services/translators/box_quantity_translator.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';

@injectable
class StoringRepository {
  StoringRepository(this._apiService);

  final ApiService _apiService;

  Future<void> storingReceivingCard({
    required StoreReCardRequestModel body,
  }) async {
    return _apiService.storingReceivingCard(body);
  }

  Future<void> storeRequestingGoods({
    required List<StoreGoodsRequestModel> body,
  }) async {
    return _apiService.storeRequestingGoods(body);
  }

  Future<List<BorrowGoodsResponseModel>?> searchBorrowGoodsList({
    String? goodsName,
    int? pageNumber,
    int? pageSize,
  }) async {
    return _apiService.searchBorrowGoodsList(
      goodsName: goodsName,
      pageNumber: pageNumber,
      pageSize: pageSize,
    );
  }

  Future<void> takeOutBorrowGoods({
    required String ids,
  }) async {
    return _apiService.takeOutBorrowGoods(ids);
  }

  Future<LocationResponseModel?> getLocationByReId({
    required int rcId,
  }) async {
    return _apiService.getLocationByReId(rcId);
  }

  Future<void> combineLocation({
    required CombineLocationRequestModel body,
  }) async {
    return _apiService.combineLocation(body);
  }

  Future<void> changeLocation({
    required ChangeLocationRequestModel body,
  }) async {
    return _apiService.changeLocation(body);
  }

  Future<void> moveOutStore({
    required MoveOutStoreRequestModel body,
  }) async {
    return _apiService.moveOutStore(body);
  }

  Future<void> moveOutAllStore({
    required MoveOutAllStoreRequestModel body,
  }) async {
    return _apiService.moveOutAllStore(body);
  }

  Future<List<MaterialLocationResponseModel>?> getMaterialByLocation({
    required String locationName,
  }) async {
    return _apiService.getMaterialByLocation(locationName);
  }

  Future<List<MaterialLocationResponseModel>?> getPositionByMaterial({
    required String material,
    required String sloc,
  }) async {
    return _apiService.getPositionByMaterial(material, sloc);
  }

  Future<MaterialSampleResponseModel?> getSampleMaterial({
    required String material,
  }) async {
    return _apiService.getSampleMaterial(material);
  }

  Future<MaterialHistoryTransitionResponseModel?> getHistoryBlockTransition({
    required String material,
    DateTime? fromDate,
    DateTime? toDate,
    String? sloc,
  }) async {
    return _apiService.getHistoryBlockTransition(
      material: material,
      fromDate: fromDate,
      toDate: toDate,
      sloc: sloc,
    );
  }

  Future<void> storingJupiter({
    required int receivingCardId,
  }) async {
    return _apiService.storingJupiter(receivingCardId);
  }

  Future<UrgenSlocResponseModel?> getUrgenInfoFromMaterial({
    required String material,
  }) async {
    return _apiService.getUrgenInfoFromMaterial(material);
  }

  Future<List<PlantTypeFrequencyResponseModel>?> getTypeFrequencyFromMaterial({
    required String material,
  }) async {
    return _apiService.getTypeFrequencyFromMaterial(material);
  }

  Future<List<PlantTypeFrequencyResponseModel>?> getAllPlanSlocFromMaterial({
    String? material,
    int? pageNumber,
    int? pageSize,
  }) async {
    final res = await _apiService.getAllPlanSlocFromMaterial(
      material: material ?? '',
      pageNumber: pageNumber,
      pageSize: pageSize,
    );
    if (res != null && res.records != null && res.records!.isNotEmpty) {
      var listPlant = <PlantTypeFrequencyResponseModel>[];
      final groupData = res.records ?? [];
      Map<String, Map<String, SlocInfoFromPlantResponseModel>> plantMap = {};

      for (var plant in groupData) {
        if (!plantMap.containsKey(plant.plant)) {
          plantMap[plant.plant ?? ''] = {};
        }

        if (!plantMap[plant.plant]!.containsKey(plant.sloc)) {
          plantMap[plant.plant]![plant.sloc ?? ''] =
              SlocInfoFromPlantResponseModel(
            sloc: plant.sloc,
            type: plant.type,
            frequency: plant.frequency,
            specialPart: plant.specialPart,
            category: [],
          );
        }

        if (!plantMap[plant.plant]![plant.sloc]!
            .category!
            .contains(plant.category)) {
          plantMap[plant.plant]![plant.sloc]!
              .category
              ?.add(plant.category ?? '');
        }
      }

      listPlant = plantMap.entries.map((plantEntry) {
        List<SlocInfoFromPlantResponseModel> slocs =
            plantEntry.value.values.toList();
        return PlantTypeFrequencyResponseModel(
            plant: plantEntry.key, slocs: slocs);
      }).toList();

      return listPlant;
    }

    return [];
  }

  Future<QmSamplingRohsResponseModel?> getQmConvertStockCard({
    required String material,
    required String vendorCode,
    required String plant,
  }) async {
    return _apiService.getQmConvertStockCard(
      material: material,
      venderCode: vendorCode,
      plant: plant,
    );
  }

  Future<ReceivingCardResponseModel> createConvertStockToReCard({
    required ReceivingCardByStockRequestModel body,
  }) async {
    return _apiService.createConvertStockToReCard(body: body);
  }

  Future<List<Barcode>?> getAllBoxCard({
    required String material,
    required String plant,
    required String sloc,
    required String position,
  }) async {
    try {
      List<Barcode> conveter = [];
      final res = await _apiService.getAllBoxCard(
        material: material,
        sloc: sloc,
        plant: plant,
        position: position,
      );
      if (res != null && res.isNotEmpty) {
        for (final e in res) {
          final quantityStock = e.toEntity();
          final barcode = quantityStock.barcode!;
          conveter.add(barcode);
        }
        return conveter;
      }
      return [];
    } catch (e) {
      logger.e(e);
    }
    return [];
  }
}
