import 'dart:math';

import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/entities/e_map/emap_floor.dart';
import 'package:smart_warehouse/entities/inventory/plant_sloc_category.dart';
import 'package:smart_warehouse/entities/vendor.dart';
import 'package:smart_warehouse/services/api_service.dart';
import 'package:smart_warehouse/services/translators/floor_translator.dart';
import 'package:smart_warehouse/services/translators/plant_sloc_category_translator.dart';
import 'package:smart_warehouse/services/translators/printer_device_translator.dart';
import 'package:smart_warehouse/services/translators/vendor_translator.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';
import 'package:smart_warehouse/shared/utils/storage_manager.dart';
import 'package:smart_warehouse/subsystem/printer/printer.dart';

@singleton
class MasterRepository {
  MasterRepository(this._apiService, this._storageManager);

  final ApiService _apiService;
  final StorageManager _storageManager;

  List<PrinterDevice> printerDevices = [];
  List<Vendor> _vendors = [];

  Future<(int, List<PrinterDevice>)> getPrinterDevices() async {
    if (printerDevices.isNotEmpty) {
      return (printerDevices.length, printerDevices);
    }
    final response = await _apiService.getAllPrinterDevices();
    printerDevices = response.records.map((e) => e.toEntity()).toList();
    return (response.totalRecord, printerDevices);
  }

  PrinterDevice? getPreviousPrinterDevice() {
    final macAddress = _storageManager.get<String>(StorageKeys.printer);
    return printerDevices.firstWhereOrNull((e) => e.macAddress == macAddress);
  }

  Future<(int, List<Vendor>)> getVendors() async {
    if (_vendors.isNotEmpty) {
      return (_vendors.length, _vendors);
    }

    final response = await _apiService.searchVendor();
    _vendors = response.records.map((e) => e.toEntity()).toList();
    return (response.totalRecord, _vendors);
  }

  Future<List<PlantCategory>> getAllPlantCate() async {
    try {
      final res = await _apiService.getAllPlantCate();
      if (res != null) {
        return res.map((e) => e.toEntity()).toList();
      }
      return [];
    } catch (e) {
      logger.e(e);
    }
    return [];
  }

  final Map<String, EMapFloor> _savedFloor = {};

  Future<EMapFloor> loadEmapKitting(String floorCode) async {

    // Tuấn Anh Check
    // if (_savedFloor.containsKey(floorCode)) {
    //   return _savedFloor[floorCode]!;
    // }

    final floorsRes = await _apiService.getListFloorMap();
    final floorId = floorsRes
        ?.firstWhere((element) => element.floorCode == floorCode)
        .floorId;

    final response = await _apiService.getEMapUI(floorId: floorId);
    _savedFloor[floorCode] = response.toFloor();
    return _savedFloor[floorCode]!;
  }
}
