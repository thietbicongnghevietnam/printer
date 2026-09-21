import 'package:smart_warehouse/entities/barcode/barcode.dart';
import 'package:smart_warehouse/enums/delivery_type.dart';
import 'package:smart_warehouse/shared/constants.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:sprintf/sprintf.dart';

class OverseaBarcode extends Barcode implements HasPO {
  OverseaBarcode({
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

  factory OverseaBarcode.fromBarcode(String barcode) {
    final arr = barcode.split(Constants.barcodeSplitCharacter);

    return OverseaBarcode(
      barcode: barcode,
      po: arr[0],
      poItem: arr[1],
      material: arr[2],
      totalQuantity: arr[3].toInt(),
      quantity: arr[4].toInt(),
      box: arr[5].toInt(),
      unitNo: arr[7],
    );
  }

  static bool validate(String barcode) {
    final arr = barcode.split(Constants.barcodeSplitCharacter);

    if (arr.length == 8) {
      return arr[1].isInt && arr[3].isInt && arr[4].isInt && arr[5].isInt;
    }

    return false;
  }

  @override
  Barcode copyWith({
    String? material,
    String? unitNo,
    String? po,
    String? poItem,
    int? boxQuantity,
    int? totalQuantity,
    int? box,
    bool useOldUnitNo = true,
  }) {
    final arr = barcode.split(Constants.barcodeSplitCharacter);
    po.let((that) => arr[0] = that);
    poItem.let((that) => arr[1] = that);
    material.let((that) => arr[2] = that);
    totalQuantity.let((that) => arr[3] = that.toString());
    boxQuantity.let((that) => arr[4] = that.toString());
    box.let((that) => arr[5] = that.toString());
    unitNo.let((that) => arr[7] = sprintf(
        '%0${(useOldUnitNo ? this.unitNo : unitNo)?.length}d',
        [unitNo.toInt()]));

    return OverseaBarcode(
      barcode: arr.join(Constants.barcodeSplitCharacter),
      po: arr[0],
      poItem: arr[1],
      material: arr[2],
      totalQuantity: arr[3].toInt(),
      quantity: arr[4].toInt(),
      box: arr[5].toInt(),
      unitNo: arr[7],
    );
  }

  @override
  String get command => sprintf(Constants.overSeaBarcode, [
        material,
        '$po - $poItem',
        barcode.length,
        barcode,
        unitNo,
        '$quantity/$totalQuantity',
        '${unitNo.toInt()}/$box',
      ]);

  @override
  DeliveryPlanType get deliveryPlanType => DeliveryPlanType.invoice;
}
