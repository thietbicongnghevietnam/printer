import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/entities/inventory.dart';
import 'package:smart_warehouse/entities/inventory/balance_detail.dart';
import 'package:smart_warehouse/entities/inventory/plant_sloc_category.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/services/api_service.dart';
import 'package:smart_warehouse/services/models/request/create_balance_qty_request_model.dart';
import 'package:smart_warehouse/services/models/request/create_balance_rc_qty_request_model.dart';
import 'package:smart_warehouse/services/translators/balance_detail_translator.dart';
import 'package:smart_warehouse/services/translators/inventory_translator.dart';
import 'package:smart_warehouse/services/translators/receiving_card_translator.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';

@injectable
class InventoryRepository {
  InventoryRepository(this.apiService);

  final ApiService apiService;

  Future<List<Inventory>> searchInventory({String material = ''}) async {
    final response = await apiService.searchInventory(material: material);
    final records = response.records.map((e) => e.toEntity()).toList();
    return records;
  }

  Future<List<PlantCategory>> getAllPlantCate() async {
    try {
      final res = await apiService.getAllPlantCate();
      if (res != null && res.isNotEmpty) {
        var listPlant = <PlantCategory>[];
        final groupData = res;
        Map<String, Map<String, CategorySloc>> plantMap = {};

        for (var plant in groupData) {
          if (!plantMap.containsKey(plant.plant)) {
            plantMap[plant.plant ?? ''] = {};
          }

          if (!plantMap[plant.plant]!.containsKey(plant.category)) {
            plantMap[plant.plant]![plant.category ?? ''] = CategorySloc(
              sloc: [],
              category: plant.category,
            );
          }

          if (!plantMap[plant.plant]![plant.category]!
              .sloc
              .contains(plant.sloc)) {
            plantMap[plant.plant]![plant.category]!.sloc.add(plant.sloc ?? '');
          }
        }

        listPlant = plantMap.entries.map((plantEntry) {
          List<CategorySloc> cate = plantEntry.value.values.toList();
          return PlantCategory(plant: plantEntry.key, categoryList: cate);
        }).toList();

        return listPlant;
      }
      return [];
    } catch (e) {
      logger.e(e);
    }
    return [];
  }

  Future<List<BalanceDetail>> searchListBalance({
    String? material,
    String? plant,
    String? sloc,
    String? category,
    int? pageSize,
    int? pageNumber,
  }) async {
    try {
      final res = await apiService.searchListBalance(
        material: material,
        plant: plant,
        sloc: sloc,
        category: category,
        pageSize: pageSize,
        pageNumber: pageNumber,
      );
      if (res != null && res.records.isNotEmpty) {
        return res.records.map((e) => e.toEntity()).toList();
      }
      return [];
    } catch (e) {
      logger.e(e);
    }
    return [];
  }

  Future<void> createBalanceQty(List<CreateBalanceQtyRequestModel> body) async {
    try {
      await apiService.createBalanceQty(request: body);
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> createBalanceRcQty(BalanceRcDataRequestModel body) async {
    try {
      await apiService.createBalanceRcQty(body);
    } catch (e) {
      logger.e(e);
    }
  }

  Future<List<ReceivingCard>> getRCListInBlock(String blockName) async {
    try {
      final resRc = await apiService.getRCListInBlock(blockName);
      return resRc.map((e) => e.toEntity()).toList();
    } catch (e) {
      logger.e(e);
      return [];
    }
  }
}
