import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/entities/delivery_plan.dart';
import 'package:smart_warehouse/entities/delivery_plan_filter.dart';
import 'package:smart_warehouse/enums/delivery_type.dart';
import 'package:smart_warehouse/repositories/delivery_plan_repository.dart';
import 'package:smart_warehouse/repositories/master_repository.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/constants.dart';
import 'package:smart_warehouse/shared/extensions/datetime_extensions.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';

import 'select_da_invoice_state.dart';

@injectable
class SelectDAInvoiceController extends BaseCubit<SelectDAInvoiceState> {
  SelectDAInvoiceController(
    this._masterRepository,
    this._deliveryPlanRepository,
  ) : super(SelectDAInvoiceState());

  final MasterRepository _masterRepository;
  final DeliveryPlanRepository _deliveryPlanRepository;

  late bool includeGoodReceipt;
  late String? material;
  late String? po;
  late String? poItem;
  late String? deliveryPlanNo;
  late int? quantity;
  late DeliveryPlanType? deliveryPlanType;

  @override
  Future<void> initData() {
    return launch(() async {
      final vendors = await _masterRepository.getVendors();
      final filter = DeliveryPlanFilter(
        material: material,
        daInvNo: deliveryPlanNo,
        type: deliveryPlanType,
        quantity: quantity,
        poNo: po,
        poItem: poItem,
        includeGoodReceipt: includeGoodReceipt,
      );

      emit(state.copyWith(vendors: vendors.$2, filter: filter));
    });
  }

  void updateDeliveryPlanFilter(DeliveryPlanFilter? filter) {
    emit(state.copyWith(filter: filter, isFiltering: false));
  }

  Future<DeliveryPlan?> scanDAInv(String barcode) {
    return launch(() async {
      return _deliveryPlanRepository.getDeliveryPlanFromBarcode(
        barcode: barcode,
        material: material,
      );
    });
  }

  Future<(bool, List<DeliveryPlan>)> loadDAInvoiceList({int page = 1}) async {
    final deliveryPlansRes = await _deliveryPlanRepository.searchDeliveryPlans(
      filter: state.filter ?? DeliveryPlanFilter(),
      pageNumber: page,
    );

    var deliveryPlans = deliveryPlansRes.$2;

    emit(state.copyWith(daInvoices: deliveryPlans));
    final isLastPage = deliveryPlans.length < Constants.pageLimit;

    return (isLastPage, deliveryPlans);
  }

  void changeFilterState() {
    emit(state.copyWith(isFiltering: !state.isFiltering));
  }
}
