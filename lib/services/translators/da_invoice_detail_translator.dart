import 'package:smart_warehouse/entities/delivery_plan_detail.dart';
import 'package:smart_warehouse/services/models/response/da_invoice_detail_response_model.dart';
import 'package:smart_warehouse/services/translators/da_invoice_item_translator.dart';

extension DADetailTranslator on DAInvoiceDetailResponseModel {
  DeliveryPlanDetail toEntity() {
    return DeliveryPlanDetail(
      id: daInvDetailId,
      material: material,
      totalQuantity: totalQuantity,
      gredQuantity: gredQuantity,
      plant: plant,
      sloc: sloc,
      items: daInvoiceItemDetails.map((e) => e.toEntity()).toList(),
    );
  }
}
