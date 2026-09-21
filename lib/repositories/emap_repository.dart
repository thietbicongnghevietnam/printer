import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/entities/e_map/emap_floor.dart';
import 'package:smart_warehouse/entities/e_map/emap_rack.dart';
import 'package:smart_warehouse/entities/e_map/emap_zone.dart';
import 'package:smart_warehouse/services/api_service.dart';
import 'package:smart_warehouse/services/models/response/floor_map_info_response_model.dart';
import 'package:smart_warehouse/services/models/response/floor_map_response_model.dart';
import 'package:smart_warehouse/services/models/response/map_suggest_widget_response_model.dart';
import 'package:smart_warehouse/services/models/response/map_trolley_response_model.dart';
import 'package:smart_warehouse/services/models/response/new_map_widget_response_model.dart';
import 'package:smart_warehouse/services/models/response/rack_detail_response_model.dart';
import 'package:smart_warehouse/services/models/response/receiving_card_by_block_response_model.dart';
import 'package:smart_warehouse/services/models/response/zone_detail_response_model.dart';
import 'package:smart_warehouse/services/translators/floor_translator.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';

@injectable
class EMapRepository {
  EMapRepository(this._apiService);

  final ApiService _apiService;

  Future<FloorMapResponseModel?> getFloorDetailByReceivingCard({
    int? receivingId,
  }) async {
    return _apiService.getFloorDetailByReceivingCard(receivingId);
  }

  Future<RackDetailResponseModel?> getRackDetail({
    int? receivingId,
    int? rackId,
    String lastNodeName = '',
  }) async {
    final res = await _apiService.getRackDetail(
      receivingId: receivingId,
      rackId: rackId,
    );

    if (res != null && res.blockList != null && res.blockList!.isNotEmpty) {
      for (final block in res.blockList!) {
        for (final layers in block.listLayers) {
          if (layers.blockName != null &&
              layers.blockName!.isNotEmpty &&
              layers.blockName!.contains(lastNodeName)) {
            layers.lastNodeName = lastNodeName;
          }
        }
      }
      return res;
    }
    return null;
  }

  Future<List<ReceivingCardByBlockResponseModel>?> getReceivingCardByBlockId({
    int? blockId,
  }) async {
    return _apiService.getReceivingCardByBlockId(blockId);
  }

  Future<ZoneDetailResponseModel?> getZoneDetailByReIdAndZoneId({
    int? zoneId,
    int? receivingId,
  }) async {
    return _apiService.getZoneDetailByReIdAndZoneId(
      zoneId: zoneId,
      receivingId: receivingId,
    );
  }

  Future<NewMapWidgetResponseModel?> getListMapWidgets({
    int? widgetId,
  }) async {
    return _apiService.getListMapWidgets(widgetId);
  }

  Future<NewMapWidgetResponseModel?> getListMapWidgetsByRcId({
    int? rcId,
  }) async {
    return _apiService.getListMapWidgetsByRcId(rcId);
  }

  Future<List<MapSuggestWidgetResponseModel>> getSuggestInfoData({
    int? rcId,
    String? material,
    String? plant,
    String? sloc,
    String? category,
    int? startTime,
    int? endTime,
    double? qtyKitting,
  }) async {
    try {
      var suggestResponse = await _apiService.getMapSuggest(
        receivingCardID: rcId,
        material: material,
        plant: plant,
        sloc: sloc,
        category: category,
        startTime: startTime,
        endTime: endTime,
        qtyKitting: qtyKitting,
      );
      if (suggestResponse != null && suggestResponse.isNotEmpty) {
        return suggestResponse;
      } else {
        return await convertMapData();
      }
    } catch (e) {
      logger.e(e);
    }

    return [];
  }

  Future<List<MapSuggestWidgetResponseModel>> convertMapData() async {
    final resFloor = await getListFloorInformation();
    List<MapSuggestWidgetResponseModel> reTurnMap = [];
    if (resFloor.isNotEmpty) {
      for (var floor in resFloor) {
        final itemFloor = MapSuggestWidgetResponseModel(
          floorId: floor.floorId,
          floorName: floor.floorName,
          floorCode: floor.floorCode,
          isSuggested: true,
        );
        reTurnMap.add(itemFloor);
      }
      return reTurnMap;
    } else {
      return [];
    }
  }

  Future<EMapFloor> loadMap({
    MapSuggestWidgetResponseModel? floorSuggestData,
    List<String> listPLBlock = const [],
  }) async {
    final response =
        await _apiService.getEMapUI(floorId: floorSuggestData?.floorId ?? 1);
    final floor = response.toFloor();

    try {
      floor.totalStoredQty = floorSuggestData?.totalStoredQty ?? 0;
      floor.totalTemp = floorSuggestData?.totalTemp ?? 0;
      floor.lastNodeName = floorSuggestData?.lastLotName ?? '';

      for (final zone in floor.widgets) {
        if (zone is EMapZone) {
          final zoneSuggest = floorSuggestData?.swmsZones?.firstWhereOrNull(
            (e) => e.zoneId != null && e.zoneId == zone.zoneId,
          );

          zone.isSuggested = zoneSuggest?.isSuggested ?? false;
          zone.lastNodeName = zoneSuggest?.lastLotName ?? '';
          zone.isJIT = zoneSuggest?.isJIT ?? false;
          zone.isDIP = zoneSuggest?.isDIP ?? false;

          if (zoneSuggest != null) {
            for (final rack in zone.widgets) {
              if (rack is EMapRack) {
                final rackSuggest = zoneSuggest.swmsRacks?.firstWhereOrNull(
                  (e) => e.rackId != null && e.rackId == rack.rackId,
                );

                if (rackSuggest != null) {
                  rack.isSuggested = rackSuggest.isSuggested ?? false;
                  rack.lastNodeName = rackSuggest.lastLotName ?? '';
                  rack.isJIT = rackSuggest.isJIT ?? false;
                }
              }
            }
          }
          // Handle case when PL is on rack
        }
      }
    } catch (e) {
      logger.e(e);
    }
    return floor;
  }

  Future<MapTrolleyResponsesModel?> getMapTrolley() async {
    final response = await _apiService.getMapTrolley();
    return response;
  }

  Future<List<FloorMapInfoResponseModel>> getListFloorInformation() async {
    final response = await _apiService.getListFloorMap();
    return response ?? [];
  }
}
