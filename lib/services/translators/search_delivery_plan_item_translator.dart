import 'package:smart_warehouse/entities/delivery_plan_item.dart';
import 'package:smart_warehouse/services/models/response/search_da_inv_item_response_model.dart';

extension DAItemTranslator on SearchDAInvItemResponseModel {
  DeliveryPlanItem toEntity() {
    return DeliveryPlanItem(
      daInvoiceDetailId: id,
      poItem: poItem,
      poNo: poNo,
      daInvoiceItem: deliveryPlanItem,
      planQuantity: planQuantity,
      actualQuantity: actualQuantity,
    );
  }
}
