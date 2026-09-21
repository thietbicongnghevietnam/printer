import 'package:smart_warehouse/entities/barcode/barcode.dart';
import 'package:smart_warehouse/entities/storing/box_quantity_stock_rc.dart';
import 'package:smart_warehouse/services/models/response/box_quantity_response_model.dart';

extension BoxQuantityTranslator on BoxQuantityResponseModel {
  BoxQuantityStockRc toEntity() {
    return BoxQuantityStockRc(
      material: material,
      barcode: Barcode.fromBarcode(barcode ?? ''),
      quantity: quantity,
      quantityBox: quantityBox,
    );
  }
}
