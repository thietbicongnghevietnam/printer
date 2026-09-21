class QtyQCHistory{
  const QtyQCHistory({
    this.barcodeBox,
    this.barcode,
    this.qtyBox,
    this.qtyRC,
    this.material,
    this.plant,
    this.sloc,
  });

  final String? barcodeBox;
  final String? barcode;
  final String? material;
  final String? plant;
  final String? sloc;

  final int? qtyBox;
  final int? qtyRC;
}
