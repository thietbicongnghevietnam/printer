import 'package:smart_warehouse/entities/delivery_plan_item.dart';
import 'package:smart_warehouse/services/models/response/da_invoice_item_response_model.dart';

extension DAItemTranslator on DAInvoiceItemResponseModel {
  DeliveryPlanItem toEntity() {
    return DeliveryPlanItem(
      daInvoiceDetailId: daInvoiceDetailId,
      poItem: poItem,
      poNo: poNo,
      daInvoiceItem: daInvoiceItem,
      planQuantity: planQuantity,
      actualQuantity: actualQuantity,
      poPendingQuantity: poPendingQuantity,
    );
  }
}
