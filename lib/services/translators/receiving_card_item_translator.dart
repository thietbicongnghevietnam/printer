import 'package:smart_warehouse/entities/barcode/barcode.dart';
import 'package:smart_warehouse/entities/receiving_card_item.dart';
import 'package:smart_warehouse/services/models/response/receiving_card_item_response_model.dart';

extension ReceivingCardItemTranslator on ReceivingCardItemResponseModel {
  ReceivingCardItem toEntity({DateTime? receivingDate}) {
    final partCard = Barcode.fromBarcode(barcode);
    return ReceivingCardItem(
        material: material,
        dateCode: dateCode,
        unitNo: unitNo,
        currentQuantity: currentQuantity,
        partCard: partCard,
        id: receivingCardDetailID ?? 0,
        receivingCardID: receivingCardID,
        totalQuantity: totalQuantity,
        lotNo: lotNo,
      daInvoiceItemDetailID: daInvoiceItemDetailID,
      isPOPending: isPOPending,
      location: location,
      isOverdue: isOverdue,
        receivingDate: receivingDate,
    );
  }
}
