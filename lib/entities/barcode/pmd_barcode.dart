import 'package:smart_warehouse/entities/barcode/barcode.dart';
import 'package:smart_warehouse/enums/delivery_type.dart';
import 'package:smart_warehouse/shared/constants.dart';
import 'package:smart_warehouse/shared/extensions/datetime_extensions.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:sprintf/sprintf.dart';

class PMDBarcode extends Barcode {
  PMDBarcode({
    required this.codeDate,
    required super.material,
    required this.category,
    required super.unitNo,
    required this.standardQuantity,
    required this.idUpload,
    required super.barcode,
    super.po,
    super.poItem,
    super.totalQuantity,
    super.deliveryPlan,
    super.box,
    int? quantity,
  }) : super(quantity: quantity ?? standardQuantity);

  factory PMDBarcode.fromBarcode(String barcode) {
    final arr = barcode.split(Constants.barcodeSplitCharacter);

    return PMDBarcode(
      barcode: barcode,
      codeDate: arr[0].toDate(DateTimeType.dateSimplify).value(),
      material: arr[1],
      category: arr[2].toUpperCase(),
      unitNo: arr[3],
      standardQuantity: arr[4].toInt(),
      idUpload: arr[6],
    );
  }

  final DateTime codeDate;
  final String category;
  final int standardQuantity;
  final String idUpload;

  static bool validate(String barcode) {
    final arr = barcode.split(Constants.barcodeSplitCharacter);

    return arr.length == 8 &&
        arr[0].isDate(DateTimeType.dateSimplify) &&
        arr[4].isInt &&
        !arr[7].isInt;
  }

  @override
  Barcode copyWith({
    String? material,
    String? unitNo,
  }) {
    final arr = barcode.split(Constants.barcodeSplitCharacter);
    material.let((that) => arr[1] = that);
    unitNo.let((that) => arr[3] = that);
    return PMDBarcode(
      barcode: arr.join(Constants.barcodeSplitCharacter),
      codeDate: arr[0].toDate(DateTimeType.dateSimplify).value(),
      material: arr[1],
      category: arr[2].toUpperCase(),
      unitNo: arr[3],
      standardQuantity: arr[4].toInt(),
      idUpload: arr[6],
    );
  }

  @override
  String get command => sprintf(Constants.pmdBarcode, [
        barcode.length,
        barcode,
        material,
      ]);

  @override
  DeliveryPlanType get deliveryPlanType => DeliveryPlanType.orderPlan;
}
