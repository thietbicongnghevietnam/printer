import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:smart_warehouse/shared/extensions/table_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';

Future<void> showFilterDeliveryPlanDialog(
  BuildContext context, {
  required ValueChanged<String>? onSearch,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (_) {
      return _DeliveryPlanFilterWidget(
        onSearch: onSearch,
      );
    },
  );
}

class _DeliveryPlanFilterWidget extends StatefulWidget {
  const _DeliveryPlanFilterWidget({
    this.onSearch,
  });

  final ValueChanged<String>? onSearch;

  @override
  State<_DeliveryPlanFilterWidget> createState() =>
      _DeliveryPlanFilterWidgetState();
}

class _DeliveryPlanFilterWidgetState extends State<_DeliveryPlanFilterWidget> {
  late final TextEditingController materialController;

  @override
  void initState() {
    materialController = TextEditingController();
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
            ].withSpaceBetween(8),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              widget.onSearch?.call(materialController.text);
              Navigator.pop(context);
            },
            child: const Text('Tìm kiếm'),
          ),
        ],
      ).paddingAll(16),
    );
  }
}
