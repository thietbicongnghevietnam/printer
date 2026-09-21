import 'package:smart_warehouse/entities/delivery_plan.dart';
import 'package:smart_warehouse/entities/delivery_plan_detail.dart';
import 'package:smart_warehouse/entities/delivery_plan_item.dart';
import 'package:smart_warehouse/enums/delivery_type.dart';
import 'package:smart_warehouse/services/models/response/order_plan_response_model.dart';

extension OrderPlanExtension on List<OrderPlanResponseModel> {
  DeliveryPlan toEntity() {
    sort((a, b) => b.planOrderNumber.compareTo(a.planOrderNumber));

    final orderPlan = first;

    final deliveryPlanDetails = [
      DeliveryPlanDetail(
        id: 0,
        material: orderPlan.material,
        plant: orderPlan.plant,
        sloc: orderPlan.sloc,
        totalQuantity: orderPlan.planOrderQuantity,
        gredQuantity: orderPlan.grQuantity,
        items: [
          DeliveryPlanItem(
            daInvoiceDetailId: 1,
            poItem: orderPlan.planOrderNumber,
            poNo: orderPlan.planOrderNumber,
            daInvoiceItem: orderPlan.planOrderNumber,
            planQuantity: orderPlan.planOrderQuantity,
            actualQuantity: orderPlan.grQuantity,
          ),
        ],
      ),
    ];
    return DeliveryPlan(
      no: orderPlan.planOrderNumber,
      type: DeliveryPlanType.orderPlan,
      details: deliveryPlanDetails,
    );
  }
}
