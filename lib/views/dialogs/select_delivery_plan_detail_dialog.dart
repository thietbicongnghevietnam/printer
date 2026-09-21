import 'package:flutter/material.dart';
import 'package:smart_warehouse/entities/delivery_plan_detail.dart';
import 'package:smart_warehouse/views/widgets/app_alert_dialog.dart';
import 'package:smart_warehouse/views/widgets/app_text.dart';

Future<void> showSelectDeliveryPlanDetailDialog(
    BuildContext context, {
      required List<DeliveryPlanDetail> details,
      required ValueChanged<DeliveryPlanDetail> onSelect,
    }) {
  return showDialog(
    context: context,
    builder: (_) => _SelectDeliveryPlanDetailDialog(
      details: details,
      onSelect: onSelect,
    ),
  );
}

class _SelectDeliveryPlanDetailDialog extends StatelessWidget {
  const _SelectDeliveryPlanDetailDialog({
    required this.details,
    required this.onSelect,
  });

  final List<DeliveryPlanDetail> details;

  final ValueChanged<DeliveryPlanDetail> onSelect;

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      title: const Text('Vui lòng chọn Plant'),
      content: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: details.length,
        itemBuilder: (context, index) {
          final item = details[index];
          return ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text('Plant: ${item.plant}'),
            subtitle: Text('Sloc: ${item.sloc}'),
            trailing: AppText.title('Quantity: ${item.totalQuantity}'),
            onTap: () {
              onSelect(item);
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }
}
