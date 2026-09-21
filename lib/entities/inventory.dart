class Inventory {
  Inventory({
    this.material,
    this.total,
    this.goodReceiptQuantity,
    this.storedQuantity,
    this.movedOutQuantity,
  });

  final String? material;
  final int? total;
  final int? goodReceiptQuantity;
  final int? storedQuantity;
  final int? movedOutQuantity;
}
