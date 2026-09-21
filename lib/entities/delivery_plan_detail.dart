import 'package:smart_warehouse/entities/delivery_plan_item.dart';

class DeliveryPlanDetail {
  DeliveryPlanDetail( {
    required this.id,
    required this.material,
    required this.plant,
    required this.sloc,
    required this.totalQuantity,
    required this.gredQuantity,
    required this.items,
  });

  final int id;
  final String material;
  final String plant;
  final String sloc;
  final int totalQuantity;
  final int? gredQuantity;
  final List<DeliveryPlanItem> items;

  @override
  String toString() {
    return 'DeliveryPlanDetail(id: $id, material: $material, plant: $plant, sloc: $sloc, gredQuantity: $gredQuantity, totalQuantity: $totalQuantity)';
  }
}
