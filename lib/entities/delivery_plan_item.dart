class DeliveryPlanItem {
  DeliveryPlanItem({
    required this.daInvoiceDetailId,
    required this.poItem,
    required this.poNo,
    required this.daInvoiceItem,
    required this.planQuantity,
    required this.actualQuantity,
    this.poPendingQuantity,
  });

  final int daInvoiceDetailId;
  final String poItem;
  final String poNo;
  final String daInvoiceItem;
  final int planQuantity;
  final int actualQuantity;
  final int? poPendingQuantity;
}
