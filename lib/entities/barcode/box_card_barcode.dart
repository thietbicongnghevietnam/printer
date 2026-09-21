import 'package:smart_warehouse/entities/barcode/barcode.dart';
import 'package:smart_warehouse/entities/delivery_plan.dart';
import 'package:smart_warehouse/enums/delivery_type.dart';
import 'package:smart_warehouse/shared/constants.dart';
import 'package:smart_warehouse/shared/extensions/datetime_extensions.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:sprintf/sprintf.dart';
import 'package:uuid/uuid.dart';

class BoxCardBarcode extends Barcode {
  BoxCardBarcode({
    String? barcode,
    required super.material,
    required super.quantity,
    super.po,
    super.poItem,
    super.totalQuantity,
    super.deliveryPlan,
    super.box,
    required super.unitNo,
    required this.plant,
    required this.sloc,
    this.type,
    this.frequency,
    this.vendor,
    this.guid,
  }) : super(
          barcode: barcode ??
              [
                Constants.boxCard,
                material,
                quantity,
                plant,
                sloc,
                type ?? '',
                frequency ?? '',
                deliveryPlan?.no ?? '',
                vendor ?? '',
                box ?? '',
                unitNo ?? '',
                guid ?? const Uuid().v4(),
              ].join(Constants.barcodeSplitCharacter),
        );

  factory BoxCardBarcode.fromBarcode(String barcode) {
    final arr = barcode.split(Constants.barcodeSplitCharacter);

    return BoxCardBarcode(
      barcode: barcode,
      material: arr[1],
      quantity: arr[2].toInt(),
      plant: arr[3],
      sloc: arr[4],
      type: arr[5],
      frequency: arr[6],
      deliveryPlan: DeliveryPlan(no: arr[7], type: DeliveryPlanType.invoice),
      vendor: arr[8],
      box: arr[9].toInt(),
      unitNo: arr[10],
      guid: arr[11],
    );
  }

  final String plant;
  final String sloc;
  final String? type;
  final String? frequency;
  final String? vendor;
  final String? guid;

  @override
  String get key => unitNo ?? '';

  static bool validate(String barcode) {
    final arr = barcode.split(Constants.barcodeSplitCharacter);

    return arr.length == 12 && arr[0] == Constants.boxCard;
  }

  @override
  Barcode copyWith({
    String? material,
    String? unitNo,
    int? box,
    int? quantity,
    bool changeGuid = false,
  }) {
    final arr = barcode.split(Constants.barcodeSplitCharacter);

    material.let((that) => arr[1] = that);
    quantity.let((that) => arr[2] = that.toString());
    unitNo.let((that) => arr[10] = that);
    box.let((that) => arr[9] = that.toString());
    changeGuid.let((that) => arr[11] = that ? const Uuid().v4() : arr[11]);
    return BoxCardBarcode(
      barcode: arr.join(Constants.barcodeSplitCharacter),
      material: material ?? arr[1],
      quantity: quantity ?? arr[2].toInt(),
      plant: arr[3],
      sloc: arr[4],
      type: arr[5],
      frequency: arr[6],
      deliveryPlan: DeliveryPlan(no: arr[7], type: DeliveryPlanType.invoice),
      vendor: arr[8],
      box: arr[9].toInt(),
      unitNo: arr[10],
      guid: arr[11],
    );
  }

  @override
  String get command {
    final vendorName = vendor?.splitString(14);
    return sprintf(Constants.sbplBoxCard, [
      DateTime.now().toText(DateTimeType.dateFUll2),
      material,
      quantity,
      sloc,
      '$unitNo/$box',
      frequency,
      barcode.length,
      barcode,
      type,
      plant,
      deliveryPlan?.no,
      vendorName?.$1,
      vendorName?.$2,
    ]);
  }

  @override
  DeliveryPlanType? get deliveryPlanType => null;
}
