import 'package:smart_warehouse/entities/barcode/box_card_barcode.dart';
import 'package:smart_warehouse/entities/barcode/local_barcode.dart';
import 'package:smart_warehouse/entities/barcode/oversea_barcode.dart';
import 'package:smart_warehouse/entities/barcode/pmd_barcode.dart';
import 'package:smart_warehouse/entities/barcode/simple_barcode.dart';
import 'package:smart_warehouse/entities/barcode/standard_barcode.dart';
import 'package:smart_warehouse/entities/delivery_plan.dart';
import 'package:smart_warehouse/enums/delivery_type.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/utils/copyable.dart';

import '../qr_card.dart';

abstract class HasPO {
}

abstract class Barcode extends QRCard  implements Copyable<Barcode> {
  Barcode({
    required super.barcode,
    required this.po,
    required this.poItem,
    required this.material,
    required this.quantity,
    required this.totalQuantity,
    required this.deliveryPlan,
    required this.box,
    required this.unitNo,
  });

  factory Barcode.fromBarcode(String barcode) {
    final barcodeFormatted = barcode.trim();

    if (PMDBarcode.validate(barcodeFormatted)) {
      return PMDBarcode.fromBarcode(barcodeFormatted);
    }

    if (LocalBarcode.validate(barcodeFormatted)) {
      return LocalBarcode.fromBarcode(barcodeFormatted);
    }

    if (OverseaBarcode.validate(barcodeFormatted)) {
      return OverseaBarcode.fromBarcode(barcodeFormatted);
    }

    if (StandardBarcode.validate(barcodeFormatted)) {
      return StandardBarcode.fromBarcode(barcodeFormatted);
    }

    if (BoxCardBarcode.validate(barcodeFormatted)) {
      return BoxCardBarcode.fromBarcode(barcodeFormatted);
    }

    if (SimpleBarcode.validate(barcodeFormatted)) {
      return SimpleBarcode.fromBarcode(barcodeFormatted);
    }

    throw ValidationError(type: ValidationErrorType.barcodeInvalid);
  }

  static bool validate(String barcode) {
    if (PMDBarcode.validate(barcode)) {
      return true;
    }

    if (LocalBarcode.validate(barcode)) {
      return true;
    }

    if (OverseaBarcode.validate(barcode)) {
      return true;
    }

    if (SimpleBarcode.validate(barcode)) {
      return true;
    }

    if (StandardBarcode.validate(barcode)) {
      return true;
    }

    if (BoxCardBarcode.validate(barcode)) {
      return true;
    }

    return false;
  }

  DeliveryPlan? deliveryPlan;

  final String? po;

  final String? poItem;

  final int? totalQuantity;

  final int? box;

  final String? unitNo;

  final String material;
  int quantity;

  String get key => barcode;

  String get command;

  DeliveryPlanType? get deliveryPlanType;
}
