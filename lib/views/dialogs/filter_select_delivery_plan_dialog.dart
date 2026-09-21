import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smart_warehouse/entities/delivery_plan_filter.dart';
import 'package:smart_warehouse/entities/vendor.dart';
import 'package:smart_warehouse/enums/delivery_type.dart';
import 'package:smart_warehouse/shared/extensions/table_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';
import 'package:smart_warehouse/views/widgets/app_autocomplete.dart';
import 'package:smart_warehouse/views/widgets/app_drop_down.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';

Future<void> showFilterSelectDeliveryPlanDialog(
  BuildContext context, {
  required DeliveryPlanFilter? filter,
  required List<Vendor> vendors,
  required ValueChanged<DeliveryPlanFilter>? onSearch,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (_) {
      return _DeliveryPlanFilterWidget(
        vendors: vendors,
        filter: filter,
        onSearch: onSearch,
      );
    },
  );
}

class _DeliveryPlanFilterWidget extends StatefulWidget {
  const _DeliveryPlanFilterWidget({
    this.filter,
    this.onSearch,
    required this.vendors,
  });

  final DeliveryPlanFilter? filter;
  final List<Vendor> vendors;
  final ValueChanged<DeliveryPlanFilter>? onSearch;

  @override
  State<_DeliveryPlanFilterWidget> createState() =>
      _DeliveryPlanFilterWidgetState();
}

class _DeliveryPlanFilterWidgetState extends State<_DeliveryPlanFilterWidget> {
  late final TextEditingController daInvController;
  late final TextEditingController materialController;
  DeliveryPlanType deliveryPlanType = DeliveryPlanType.invoice;
  Vendor? selectedVendor;

  @override
  void initState() {
    daInvController = TextEditingController(text: widget.filter?.daInvNo);
    materialController = TextEditingController(text: widget.filter?.material);
    deliveryPlanType = widget.filter?.type ?? DeliveryPlanType.invoice;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Column(
        mainAxisSize: MainAxisSize.min,
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
              TableRow(
                children: [
                  const Text('Material:'),
                  AppFormField(
                    controller: materialController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        onPressed: () async {
                          final material = await context.pushRoute<String>(
                            const CameraCaptureRoute(),
                          );
                          materialController.text = material ?? '';
                        },
                        icon: const Icon(Icons.document_scanner),
                      ),
                    ),
                  ),
                ],
              ),
              TableRow(
                children: [
                  const Text(LocaleKeys.select_da_invoice_vendor).tr(),
                  AppAutoComplete(
                    initialValue: widget.vendors.firstWhereOrNull(
                      (e) => e.vendorCode == widget.filter?.vendorCode,
                    ),
                    displayStringForOption: (object) =>
                        '[${object.vendorCode}] ${object.vendorNameShort}',
                    optionsBuilder: (textEditingValue) {
                      return widget.vendors.where(
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
                daInvNo: daInvController.text.toUpperCase().trim(),
                vendorCode: selectedVendor?.vendorCode,
                material: materialController.text.toUpperCase().trim(),
                includeGoodReceipt: widget.filter?.includeGoodReceipt ?? false,
                type: deliveryPlanType,
              );
              widget.onSearch?.call(deliveryPlanFilter);
              Navigator.pop(context);
            },
            child: const Text('Tìm kiếm'),
          ),
        ],
      ).paddingAll(16),
    );
  }
}
