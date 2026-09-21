import 'package:smart_warehouse/entities/qr_card.dart';

abstract class StorageCard  extends QRCard{
  StorageCard({
    this.id = 0,
    required this.rcId,
    required this.material,
    required super.barcode,
    required this.quantity,
    this.receivingDate,
  });

  final int id;
  final String material;
  final int quantity;
  final int rcId;
  final DateTime? receivingDate;

  StorageCard copyWith({
    int? stockQuantity,
  });
}
