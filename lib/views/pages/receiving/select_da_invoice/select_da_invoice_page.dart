import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/delivery_plan.dart';
import 'package:smart_warehouse/enums/delivery_type.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';
import 'package:smart_warehouse/subsystem/pda/pda.dart';
import 'package:smart_warehouse/views/dialogs/filter_select_delivery_plan_dialog.dart';

import 'components/delivery_plan_item_widget.dart';
import 'select_da_invoice_controller.dart';
import 'select_da_invoice_state.dart';

@RoutePage<DeliveryPlan>()
class SelectDAInvoicePage
    extends BasePage<SelectDAInvoiceController, SelectDAInvoiceState> {
  const SelectDAInvoicePage({
    super.key,
    this.material,
    this.po,
    this.poItem,
    this.deliveryPlanNo,
    this.deliveryPlanType,
    this.quantity,
    this.includeGoodReceipt = false,
    required this.onSelect,
  });

  final String? material;
  final String? po;
  final String? poItem;
  final String? deliveryPlanNo;
  final int? quantity;
  final DeliveryPlanType? deliveryPlanType;
  final bool includeGoodReceipt;
  final void Function(DeliveryPlan? deliveryPlan, String? material) onSelect;

  @override
  SelectDAInvoiceController buildCubit(BuildContext context) {
    return getIt<SelectDAInvoiceController>()
      ..material = material
      ..po = po
      ..poItem = poItem
      ..deliveryPlanNo = deliveryPlanNo
      ..deliveryPlanType = deliveryPlanType
      ..includeGoodReceipt = includeGoodReceipt
      ..quantity = quantity;
  }

  @override
  BasePageState createState() => _SelectDAInvoicePageState();
}

class _SelectDAInvoicePageState
    extends BasePageState<SelectDAInvoiceController, SelectDAInvoiceState> {
  late TextEditingController daController;

  final PagingController<int, DeliveryPlan> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    daController = TextEditingController();
    _pagingController.addPageRequestListener((pageKey) {
      try {
        _fetchPage(pageKey);
      } catch (error) {
        _pagingController.error = error;
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onViewLoaded(context, cubit, state) {
    daController.text = cubit.deliveryPlanNo ?? '';
    super.onViewLoaded(context, cubit, state);
  }

  Future<void> _fetchPage(int pageKey) async {
    final newItems = await context
        .read<SelectDAInvoiceController>()
        .loadDAInvoiceList(page: pageKey + 1);
    final isLastPage = newItems.$1;
    if (isLastPage) {
      _pagingController.appendLastPage(newItems.$2);
    } else {
      _pagingController.appendPage(newItems.$2, pageKey + 1);
    }
  }

  @override
  Widget builder(context, cubit, state) {
    return BlocListener<SelectDAInvoiceController, SelectDAInvoiceState>(
      listenWhen: (preState, state) => preState.filter != state.filter,
      listener: (context, state) => _pagingController.refresh(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(LocaleKeys.select_da_invoice_title).tr(),
          actions: [
            IconButton(
              onPressed: () {
                final filter = cubit.state.filter;
                final vendors = cubit.state.vendors;
                showFilterSelectDeliveryPlanDialog(
                  context,
                  filter: filter,
                  vendors: vendors,
                  onSearch: cubit.updateDeliveryPlanFilter,
                );
              },
              icon: const Icon(Icons.filter_alt),
            ),
          ],
        ),
        body: PagedListView<int, DeliveryPlan>(
          pagingController: _pagingController,
          padding: const EdgeInsets.all(16),
          itemExtent: 66,
          builderDelegate: PagedChildBuilderDelegate<DeliveryPlan>(
            itemBuilder: (context, item, index) {
              return DeliveryItemWidget(
                daInvoice: item,
                onPressed: () => widget
                    .as<SelectDAInvoicePage>()
                    ?.onSelect(item, cubit.state.filter?.material),
              ).paddingOnly(bottom: 8);
            },
            noItemsFoundIndicatorBuilder: (_) {
              return const Center(child: Text('Không tìm thấy DA/INV'));
            },
          ),
        ),
      ),
    );
  }
}
