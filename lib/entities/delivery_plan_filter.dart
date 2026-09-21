import 'package:smart_warehouse/enums/delivery_type.dart';

class DeliveryPlanFilter {
  DeliveryPlanFilter( {
    this.date,
    this.vendorCode,
    this.material,
    this.daInvNo,
    this.daInvItem,
    this.poNo,
    this.poItem,
    this.quantity,
    this.globalCode,
    this.category,
    this.type,
    this.includeGoodReceipt = false,
  });

  final DateTime? date;
  final String? vendorCode;
  final String? material;
  final String? daInvNo;
  final String? daInvItem;
  final String? poNo;
  final String? poItem;
  final int? quantity;
  final String? category;
  final String? globalCode;
  final DeliveryPlanType? type;
  final bool includeGoodReceipt;
}
