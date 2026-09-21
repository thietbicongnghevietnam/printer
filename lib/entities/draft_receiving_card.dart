import 'package:smart_warehouse/entities/delivery_plan.dart';

class DraftReceivingCard {
  DraftReceivingCard({
    required this.material,
    required this.deliveryPlan,
    required this.barcodes,
    required this.deliveryPlanDetailId,
  });

  final String material;
  final DeliveryPlan deliveryPlan;
  final int? deliveryPlanDetailId;
  final List<String> barcodes;

  DraftReceivingCard addBarcode(String barcode) {
    barcodes.add(barcode);
    return this;
  }

  String get key => '$material-${deliveryPlan.no}-$deliveryPlanDetailId';
}
