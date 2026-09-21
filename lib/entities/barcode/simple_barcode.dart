import 'package:smart_warehouse/entities/barcode/barcode.dart';
import 'package:smart_warehouse/enums/delivery_type.dart';
import 'package:smart_warehouse/shared/constants.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';
import 'package:sprintf/sprintf.dart';
import 'package:uuid/uuid.dart';

class SimpleBarcode extends Barcode {
  SimpleBarcode( {
    required super.barcode,
    required super.material,
    required super.quantity,
    required this.guid,
    super.po,
    super.poItem,
    super.totalQuantity,
    super.deliveryPlan,
    super.box,
    super.unitNo,
  });

  factory SimpleBarcode.fromBarcode(String barcode) {
    final arr = barcode.split(Constants.barcodeSplitCharacter);

    return SimpleBarcode(
      barcode: barcode,
      material: arr[0],
      quantity: arr[1].toInt(),
      guid: arr.skip(2).join(Constants.barcodeSplitCharacter),
    );
  }

  final String guid;

  static bool validate(String barcode) {
    final arr = barcode.split(Constants.barcodeSplitCharacter);

    return arr.length > 1 && !arr[0].isInt && arr[1].isInt;
  }

  @override
  Barcode copyWith({
    String? material,
    int? boxQuantity,
    bool changeGuid = false,
  }) {
    final arr = barcode.split(Constants.barcodeSplitCharacter);

    final partNo = material ?? arr[0];
    final quantity = boxQuantity ?? arr[1].toInt();
    final guid = changeGuid ? const Uuid().v4() : arr.skip(2).join(Constants.barcodeSplitCharacter);

    return SimpleBarcode(
      barcode: '$partNo;$quantity;$guid',
      material: partNo,
      quantity: quantity,
      guid: guid,
    );
  }

  @override
  String get command => sprintf(Constants.simpleBarcode, [
        barcode.length,
        barcode,
        material,
        quantity,
        '',
        '',
        '',
        '',
        '',
        '',
      ]);

  @override
  DeliveryPlanType? get deliveryPlanType => null;
}
