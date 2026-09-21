import 'dart:math';

import 'package:smart_warehouse/entities/barcode/barcode.dart';
import 'package:smart_warehouse/entities/delivery_plan.dart';
import 'package:smart_warehouse/enums/delivery_type.dart';
import 'package:smart_warehouse/shared/constants.dart';
import 'package:smart_warehouse/shared/extensions/datetime_extensions.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';
import 'package:sprintf/sprintf.dart';

class LocalBarcode extends Barcode implements HasPO {
  LocalBarcode({
    required this.globalCode,
    required super.deliveryPlan,
    required this.daItem,
    required this.deliveryDate,
    required super.po,
    required super.poItem,
    required super.material,
    required super.quantity,
    required super.totalQuantity,
    required super.box,
    required this.invoice,
    required super.unitNo,
    required super.barcode,
  });

  factory LocalBarcode.fromBarcode(String barcode) {
    final arr = barcode.split(Constants.barcodeSplitCharacter);
    return LocalBarcode(
      barcode: barcode,
      globalCode: arr[0],
      deliveryPlan: DeliveryPlan(
        no: arr[1],
        type: DeliveryPlanType.dispatchAdvice,
        globalCode: arr[0],
        deliveryDate: arr[3].toDate(DateTimeType.MMddyyyy),
      ),
      daItem: arr[2],
      deliveryDate: arr[3].toDate(DateTimeType.MMddyyyy).value(),
      po: arr[4],
      poItem: arr[5],
      material: arr[6],
      totalQuantity: max(arr[7].toInt(), arr[8].toInt()),
      quantity: min(arr[7].toInt(), arr[8].toInt()),
      box: arr[9].toInt(),
      invoice: arr[10],
      unitNo: arr[11],
    );
  }

  final String globalCode;
  final String daItem;
  final DateTime deliveryDate;
  final String invoice;

  static bool validate(String barcode) {
    final arr = barcode.split(Constants.barcodeSplitCharacter);
    return arr.length == 12 &&
        (arr[3].isDate(DateTimeType.MMddyyyy) || arr[3].isDate()) &&
        arr[5].isInt &&
        arr[7].isInt &&
        arr[8].isInt &&
        arr[9].isInt;
  }

  @override
  Barcode copyWith({
    String? material,
    String? unitNo,
    String? da,
    String? daItem,
    String? po,
    String? poItem,
    int? boxQuantity,
    int? totalQuantity,
    int? box,
    DateTime? deliveryDate,
    bool useOldUnitNo = true,
  }) {
    final arr = barcode.split(Constants.barcodeSplitCharacter);
    da.let((that) => arr[1] = that);
    daItem.let((that) => arr[2] = that);
    deliveryDate.let((that) => arr[3] = that.toText(DateTimeType.MMddyyyy));
    po.let((that) => arr[4] = that);
    poItem.let((that) => arr[5] = that);
    material.let((that) => arr[6] = that);
    totalQuantity.let((that) => arr[7] = that.toString());
    boxQuantity.let((that) => arr[8] = that.toString());
    box.let((that) => arr[9] = that.toString());
    unitNo.let(
      (that) => arr[11] = sprintf(
        '%0${(useOldUnitNo ? this.unitNo : unitNo)?.length}d',
        [unitNo.toInt()],
      ),
    );

    return LocalBarcode(
      barcode: arr.join(Constants.barcodeSplitCharacter),
      globalCode: arr[0],
      deliveryPlan: DeliveryPlan(
        no: arr[1],
        type: deliveryPlanType,
        globalCode: arr[0],
        deliveryDate: arr[3].toDate(DateTimeType.MMddyyyy),
      ),
      daItem: arr[2],
      deliveryDate: arr[3].toDate(DateTimeType.MMddyyyy).value(),
      po: arr[4],
      poItem: arr[5],
      material: arr[6],
      totalQuantity: arr[7].toInt(),
      quantity: arr[8].toInt(),
      box: arr[9].toInt(),
      invoice: arr[10],
      unitNo: unitNo ?? arr[11],
    );
  }

  @override
  String get command => sprintf(Constants.localBarcode, [
        barcode.length,
        barcode,
        invoice,
        material,
        poItem,
        po,
        deliveryDate.toText(),
        '${deliveryPlan?.no} - $daItem ',
        unitNo,
        '$quantity/$totalQuantity',
      ]);

  @override
  DeliveryPlanType get deliveryPlanType => DeliveryPlanType.dispatchAdvice;
}
