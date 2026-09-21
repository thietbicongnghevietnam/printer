import 'package:smart_warehouse/entities/inventory.dart';
import 'package:smart_warehouse/services/models/response/inventory_response_model.dart';

extension InventoryTranslator on InventoryResponseModel {
  Inventory toEntity() {
    return Inventory(
      material: material,
      total: total,
      goodReceiptQuantity: goodReceiptQuantity,
      storedQuantity: storedQuantity,
      movedOutQuantity: movedOutQuantity,
    );
  }
}
