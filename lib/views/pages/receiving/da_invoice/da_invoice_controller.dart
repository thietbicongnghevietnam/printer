import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/entities/delivery_plan.dart';
import 'package:smart_warehouse/repositories/delivery_plan_repository.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';

import 'da_invoice_state.dart';

@injectable
class DAInvoiceController extends BaseCubit<DAInvoiceState> {
  DAInvoiceController(this._deliveryPlanRepository) : super(DAInvoiceState());

  final DeliveryPlanRepository _deliveryPlanRepository;
  late DeliveryPlan deliveryPlan;

  @override
  Future<void> initData() {
    return launch(() async {
      await loadDAInvoiceDetail();
    });
  }

  Future<void> loadDAInvoiceDetail() {
    return launch(() async {
      final newDeliveryPlan = await _deliveryPlanRepository
          .getDeliveryPlanDetail(deliveryPlan, includeGoodReceipt: true);

      emit(state.copyWith(deliveryPlan: newDeliveryPlan));
    });
  }
}
