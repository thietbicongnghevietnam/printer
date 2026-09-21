import 'package:flutter/material.dart';
import 'package:smart_warehouse/entities/draft_receiving_card.dart';
import 'package:smart_warehouse/views/widgets/app_alert_dialog.dart';

Future<void> showDraftReceivingCardDialog(
  BuildContext context, {
  required List<DraftReceivingCard> draftReceivingCards,
  required ValueChanged<DraftReceivingCard> onSelect,
  required VoidCallback onClear,
}) {
  return showDialog(
    context: context,
    builder: (_) => _DraftReceivingCardDialog(
      draftReceivingCards: draftReceivingCards,
      onSelect: onSelect,
      onClear: onClear,
    ),
  );
}

class _DraftReceivingCardDialog extends StatelessWidget {
  const _DraftReceivingCardDialog({
    required this.draftReceivingCards,
    required this.onSelect,
    required this.onClear,
  });

  final List<DraftReceivingCard> draftReceivingCards;
  final ValueChanged<DraftReceivingCard> onSelect;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      title: const Text('Receiving Card đã lưu'),
      content: ListView.builder(
        shrinkWrap: true,
        itemCount: draftReceivingCards.length,
        itemBuilder: (context, index) {
          final item = draftReceivingCards[index];
          return ListTile(
            title: Text('Material: ${item.material}'),
            subtitle: Text('${item.deliveryPlan.type} ${item.deliveryPlan.no}'),
            trailing: Text('${item.deliveryPlanDetailId}'),
          );
        },
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () {
            onClear();
            Navigator.pop(context);
          },
          child: const Text('Xóa hết'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Đóng'),
        ),
      ],
    );
  }
}
