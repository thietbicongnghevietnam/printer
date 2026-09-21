import 'package:flutter/material.dart';
import 'package:smart_warehouse/entities/delivery_plan.dart';
import 'package:smart_warehouse/entities/delivery_plan_detail.dart';
import 'package:smart_warehouse/views/widgets/app_alert_dialog.dart';

Future<void> showDeliveryPlanDetailDialog(
  BuildContext context, {
  required DeliveryPlanDetail deliveryPlanDetail,
  required VoidCallback onOpenReceivingCardList,
}) {
  return showDialog(
    context: context,
    builder: (_) => _DeliveryPlanDetailDialog(
      deliveryPlanDetail: deliveryPlanDetail,
      onOpenReceivingCardList: onOpenReceivingCardList,
    ),
  );
}

class _DeliveryPlanDetailDialog extends StatelessWidget {
  const _DeliveryPlanDetailDialog({
    required this.deliveryPlanDetail,
    required this.onOpenReceivingCardList,
  });

  final DeliveryPlanDetail deliveryPlanDetail;

  final VoidCallback onOpenReceivingCardList;

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      title: Text('Mã: ${deliveryPlanDetail.material}'),
      content: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemCount: deliveryPlanDetail.items.length,
        itemBuilder: (context, index) {
          final item = deliveryPlanDetail.items[index];
          return ListTile(
            contentPadding: EdgeInsets.zero,
            leadingAndTrailingTextStyle: TextStyle(
              color: _getColor(item.actualQuantity, item.planQuantity),
            ),
            title: Text('PO: ${item.poNo}'),
            subtitle:
                Text('PO Item: ${item.poItem}\nDA Item: ${item.daInvoiceItem}'),
            isThreeLine: true,
            trailing: Text('${item.actualQuantity}/${item.planQuantity}'),
          );
        },
      ),
      actions: [
        ElevatedButton(
          onPressed: onOpenReceivingCardList,
          child: const Text('Danh sách Receiving Card'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Đóng'),
        ),
      ],
    );
  }

  Color _getColor(int? currentQuantity, int totalQuantity) {
    if (currentQuantity == null) {
      return Colors.black;
    }
    if (currentQuantity >= totalQuantity) {
      return Colors.green;
    } else if (currentQuantity > 0) {
      return Colors.orange;
    }

    return Colors.black;
  }
}
