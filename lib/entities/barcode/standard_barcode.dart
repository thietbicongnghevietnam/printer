import 'package:smart_warehouse/entities/barcode/barcode.dart';
import 'package:smart_warehouse/entities/barcode/oversea_barcode.dart';
import 'package:smart_warehouse/enums/delivery_type.dart';
import 'package:smart_warehouse/shared/constants.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';
import 'package:sprintf/sprintf.dart';

class StandardBarcode extends Barcode implements HasPO {
  StandardBarcode({
    required super.po,
    required super.poItem,
    required super.material,
    required super.quantity,
    super.totalQuantity,
    super.unitNo,
    super.box,
    required super.barcode,
    super.deliveryPlan,
  });

  factory StandardBarcode.fromBarcode(String barcode) {
    final arr = barcode.split(Constants.barcodeSplitCharacter);

    if (arr.length == 7 && arr[6].isInt) {
      return StandardBarcode(
        barcode: barcode,
        po: arr[5],
        poItem: arr[6],
        material: arr[2],
        quantity: arr[3].toInt(),
      );
    }

    return StandardBarcode(
      barcode: barcode,
      po: arr[0],
      poItem: arr[1],
      material: arr[2],
      quantity: arr[3].toInt(),
    );
  }

  static bool validate(String barcode) {
    final arr = barcode.split(Constants.barcodeSplitCharacter);

    return !OverseaBarcode.validate(barcode) && arr.length >= 4 && arr[0].isPo() && arr[1].isInt && arr[3].isInt;
  }

  @override
  Barcode copyWith({
    String? material,
    String? po,
    String? poItem,
    int? boxQuantity,
  }) {
    final arr = barcode.split(Constants.barcodeSplitCharacter);
    po.let((that) => arr[arr.length == 7 ? 5 : 0] = that);
    poItem.let((that) => arr[arr.length == 7 ? 6 : 1] = that);
    material.let((that) => arr[2] = that);
    boxQuantity.let((that) => arr[3] = that.toString());
    if (arr.length == 7) {
      return StandardBarcode(
        barcode: arr.join(Constants.barcodeSplitCharacter),
        po: arr[5],
        poItem: arr[6],
        material: arr[2],
        quantity: arr[3].toInt(),
      );
    }

    return StandardBarcode(
      barcode: arr.join(Constants.barcodeSplitCharacter),
      po: arr[0],
      poItem: arr[1],
      material: arr[2],
      quantity: arr[3].toInt(),
    );
  }

  @override
  String get command => sprintf(Constants.standardBarcode, [
        material,
        '$po - $poItem',
        barcode.length,
        barcode,
        quantity,
      ]);

  @override
  DeliveryPlanType get deliveryPlanType => DeliveryPlanType.invoice;
}
