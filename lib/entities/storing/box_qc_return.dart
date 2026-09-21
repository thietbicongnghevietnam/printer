import 'package:smart_warehouse/shared/utils/copyable.dart';

class BoxQCReturn implements Copyable<BoxQCReturn> {
  BoxQCReturn({
    this.barcode,
    this.currentQuantity = 0,
  });

  final int currentQuantity;
  final String? barcode;

  @override
  BoxQCReturn copyWith({String? addedBarcode, int qtyBox = 0}) {
    return BoxQCReturn(
      barcode: addedBarcode,
      currentQuantity: qtyBox,
    );
  }
}
