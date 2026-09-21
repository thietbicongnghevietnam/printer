import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/entities/delivery_plan_filter.dart';
import 'package:smart_warehouse/entities/vendor.dart';
import 'package:smart_warehouse/enums/delivery_type.dart';
import 'package:smart_warehouse/shared/extensions/table_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';
import 'package:smart_warehouse/views/pages/receiving/select_da_invoice/select_da_invoice_controller.dart';
import 'package:smart_warehouse/views/pages/receiving/select_da_invoice/select_da_invoice_state.dart';
import 'package:smart_warehouse/views/widgets/app_autocomplete.dart';
import 'package:smart_warehouse/views/widgets/app_drop_down.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';
import 'package:smart_warehouse/views/widgets/app_text.dart';

class FilterAreaWidget extends StatefulWidget {
  const FilterAreaWidget({
    super.key,
    this.filter,
    this.onSearch,
  });

  final DeliveryPlanFilter? filter;
  final ValueChanged<DeliveryPlanFilter>? onSearch;

  @override
  State<FilterAreaWidget> createState() => _FilterAreaWidgetState();
}

class _FilterAreaWidgetState extends State<FilterAreaWidget> {
  late final TextEditingController daInvController;
  DeliveryPlanType deliveryPlanType = DeliveryPlanType.invoice;
  Vendor? selectedVendor;

  @override
  void initState() {
    daInvController = TextEditingController(text: widget.filter?.daInvNo);
    deliveryPlanType = widget.filter?.type ?? DeliveryPlanType.invoice;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<SelectDAInvoiceController>();
    return Column(
      children: [
        Table(
          columnWidths: const {
            0: FixedColumnWidth(70),
            1: FlexColumnWidth(),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              children: [
                const Text('Loại:'),
                AppDropdown(
                  displayStringForOption: (option) => option.text,
                  options: DeliveryPlanType.values,
                  value: deliveryPlanType,
                  onChange: (type) {
                    setState(() {
                      deliveryPlanType =
                          type ?? DeliveryPlanType.dispatchAdvice;
                    });
                  },
                ),
              ],
            ),
            if (cubit.material != null)
              TableRow(
                children: [
                  const Text('Material:'),
                  AppText.title(cubit.material ?? ''),
                ],
              ),
            TableRow(
              children: [
                const Text(LocaleKeys.select_da_invoice_vendor).tr(),
                BlocSelector<SelectDAInvoiceController, SelectDAInvoiceState,
                    List<Vendor>>(
                  selector: (state) => state.vendors,
                  builder: (context, vendors) {
                    final initialValue = vendors.firstWhereOrNull(
                      (e) => e.vendorCode == widget.filter?.vendorCode,
                    );
                    return AppAutoComplete(
                      initialValue: initialValue,
                      displayStringForOption: (object) =>
                          '[${object.vendorCode}] ${object.vendorNameShort}',
                      optionsBuilder: (textEditingValue) {
                        return vendors.where(
                          (element) =>
                              element.vendorCode.toLowerCase().contains(
                                    textEditingValue.text.toLowerCase(),
                                  ) ||
                              element.vendorName.toLowerCase().contains(
                                    textEditingValue.text.toLowerCase(),
                                  ),
                        );
                      },
                      onSelect: (vendor) {
                        setState(() => selectedVendor = vendor);
                      },
                    );
                  },
                ),
              ],
            ),
            TableRow(
              children: [
                const Text(LocaleKeys.select_da_invoice_da_inv).tr(),
                AppFormField(
                  controller: daInvController,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      onPressed: () async {
                        final selectCode = await context.pushRoute<String>(
                          const CameraCaptureRoute(),
                        );
                        daInvController.text = selectCode ?? '';
                      },
                      icon: const Icon(Icons.document_scanner),
                    ),
                  ),
                ),
              ],
            ),
          ].withSpaceBetween(8),
        ),
        const SizedBox(height: 8),
        ElevatedButton(
          onPressed: () {
            final deliveryPlanFilter = DeliveryPlanFilter(
              daInvNo: daInvController.text.toUpperCase(),
              vendorCode: selectedVendor?.vendorCode,
              type: deliveryPlanType,
              includeGoodReceipt: widget.filter?.includeGoodReceipt ?? false,
            );
            widget.onSearch?.call(deliveryPlanFilter);
          },
          child: const Text('Tìm kiếm'),
        ),
        const Divider(),
      ],
    );
  }
}
