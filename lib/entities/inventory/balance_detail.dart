class BalanceDetail {
  BalanceDetail({
    this.plant,
    this.sloc,
    this.category,
    this.material,
    this.createdDate,
    this.updatedDate,
    this.createdBy,
    this.updatedBy,
    this.standardPrice,
    this.perQuantity,
    this.sapQuantity,
    this.currentQuantity,
    this.status,
    this.isUpdate = false,
  });

  final String? plant;
  final String? sloc;
  final String? category;
  final String? material;
  final String? createdDate;
  final String? updatedDate;
  final String? createdBy;
  final String? updatedBy;

  final double? standardPrice;

  final int? perQuantity;
  final int? sapQuantity;
  final int? status;
  int? currentQuantity;

  bool isUpdate;
}
