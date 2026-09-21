import 'package:smart_warehouse/entities/barcode/barcode.dart';

class BoxQuantityStockRc {
  BoxQuantityStockRc( {
    this.material,
    this.barcode,
     this.quantityBox,
     this.quantity,
  });

  final String? material;
  final int? quantity;
  final int? quantityBox;
  final Barcode? barcode;
}
