class CustomReCardItem {
  CustomReCardItem({
    required this.id,
    this.barCode,
    this.currentQuantity,
    this.material,
    this.oldLocation,
  });

  final int id;
  final int? currentQuantity;
  final String? barCode;
  final String? material;
  final String? oldLocation;
}
