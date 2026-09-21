import 'package:smart_warehouse/entities/delivery_plan.dart';
import 'package:smart_warehouse/enums/delivery_type.dart';
import 'package:smart_warehouse/services/models/response/da_invoice_response_model.dart';
import 'package:smart_warehouse/services/translators/da_invoice_detail_translator.dart';
import 'package:smart_warehouse/shared/extensions/datetime_extensions.dart';

extension DaInvoiceTranslator on DAInvoiceResponseModel {
  DeliveryPlan toEntity() {
    return DeliveryPlan(
      id: id,
      no: no,
      type: DeliveryPlanType.fromCode(type),
      deliveryDate: (updatedDate ?? createdDate ?? deliveryDate).toDate(DateTimeType.yyyyMMdd),
      createdDate: createdDate?.toDate(DateTimeType.yyyyMMdd),
      globalCode: globalCode,
      vendorCode: vendorCode,
      quantity: quantity,
      details: details?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}
