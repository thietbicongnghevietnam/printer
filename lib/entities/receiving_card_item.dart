import 'package:smart_warehouse/entities/barcode/barcode.dart';
import 'package:smart_warehouse/entities/barcode/local_barcode.dart';
import 'package:smart_warehouse/entities/storage_card.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';
import 'package:smart_warehouse/shared/utils/copyable.dart';

class ReceivingCardItem extends StorageCard
    implements Copyable<ReceivingCardItem> {
  ReceivingCardItem({
    this.receivingCardID,
    this.lotNo,
    this.daInvoiceItemDetailID,
    this.isPOPending,
    super.id,
    required super.material,
    required this.dateCode,
    required this.unitNo,
    this.totalQuantity,
    required this.currentQuantity,
    required this.partCard,
    this.poNo,
    this.poItem,
    this.daIvnItem,
    this.location,
    DateTime? receivingDate,
    this.isOverdue = false,
  }) : super(
          barcode: partCard.barcode,
          quantity: currentQuantity,
          rcId: receivingCardID ?? 0,
          receivingDate: receivingDate,
        );

  factory ReceivingCardItem.fromBarcode(Barcode barcode) {
    return ReceivingCardItem(
      unitNo: barcode.unitNo,
      partCard: barcode,
      currentQuantity: barcode.quantity,
      totalQuantity: barcode.quantity,
      material: barcode.material,
      dateCode: null,
      poNo: barcode.po,
      poItem: barcode.poItem.toString(),
      daIvnItem: barcode.as<LocalBarcode>()?.daItem,
    );
  }

  final String? dateCode;
  final String? unitNo;
  final int? totalQuantity;
  int currentQuantity;
  final Barcode partCard;
  final String? poNo;
  final String? poItem;
  final String? daIvnItem;
  final int? receivingCardID;
  final String? lotNo;
  final int? daInvoiceItemDetailID;
  final bool? isPOPending;
  final String? location;
  final bool isOverdue;

  @override
  ReceivingCardItem copyWith({int? quantity, int? stockQuantity, String? unitNo}) {
    final newPartCard =
        partCard.as<LocalBarcode>()?.copyWith(unitNo: unitNo) ?? partCard;

    return ReceivingCardItem(
      id: id,
      material: material,
      dateCode: dateCode,
      unitNo: unitNo ?? this.unitNo,
      currentQuantity: quantity ?? stockQuantity ?? currentQuantity,
      partCard: newPartCard,
      poNo: poNo,
      poItem: poItem,
      daIvnItem: daIvnItem,
      location: location,
      isOverdue: isOverdue,
    );
  }
}
