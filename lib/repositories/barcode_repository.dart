import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/services/api_service.dart';

import '../services/models/request/barcode_model.dart';

@injectable
class BarCodeRepository {
  BarCodeRepository(this._apiService);

  final ApiService _apiService;

  Future<void> createBarCodeNG({
    String? daInvNo,
    int? daInvId,
    String? vendorCode,
    DateTime? deliveryDate,
    String? unitNo,
    String? poNo,
    String? poItem,
    String? lotNo,
    String? barcode,
    required String material,
    String? materialType,
    String? plant,
    String? sloc,
    int? totalQuantity,
    int? currentQuantity,
    int? boxQuantity,
    int? totalBox,
    String? reason,
  }) async {
    final request = BarCodeModel(
      material: material,
      daInvNo: daInvNo,
      daInvId: daInvId,
      vendorCode: vendorCode,
      deliveryDate: deliveryDate,
      unitNo: unitNo,
      poNo: poNo,
      poItem: poItem,
      lotNo: lotNo,
      barcode: barcode,
      materialType: materialType,
      plant: plant,
      sloc: sloc,
      totalQuantity: totalQuantity,
      currentQuantity: currentQuantity,
      boxQuantity: boxQuantity,
      totalBox: totalBox,
      reason: reason,
    );
    return _apiService.createBarCodeNG(request);
  }

  Future<int> getActualQuantityPMDBarcode(String barcode) async {
    final response = await _apiService.readPMD(barCode: barcode);
    return response?.quantity ?? 0;
  }
}
