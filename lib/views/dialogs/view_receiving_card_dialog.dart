import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/services/models/request/receiving_card_model.dart';
import 'package:smart_warehouse/services/models/response/receiving_card_response_model.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/subsystem/pda/pda.dart';
import 'package:smart_warehouse/subsystem/printer/printer.dart';
import 'package:smart_warehouse/views/widgets/app_alert_dialog.dart';
import 'package:smart_warehouse/views/widgets/app_drop_down.dart';
import 'package:smart_warehouse/views/widgets/app_text.dart';
import 'package:smart_warehouse/views/widgets/new_receiving_card_from_stock.dart';
import 'package:smart_warehouse/views/widgets/receiving_card_widget.dart';

Future<void> showViewReceivingCardDialog(
  BuildContext context, {
  required ReceivingCard receivingCard,
}) async {
  await showDialog<void>(
    context: context,
    builder: (_) => _ViewReceivingCardDialog(
      receivingCard: receivingCard,
    ),
  );
}

class _ViewReceivingCardDialog extends StatefulWidget {
  const _ViewReceivingCardDialog({
    required this.receivingCard,
  });

  final ReceivingCard receivingCard;

  @override
  State<_ViewReceivingCardDialog> createState() =>
      _ViewReceivingCardDialogState();
}

class _ViewReceivingCardDialogState extends State<_ViewReceivingCardDialog> {
  @override
  Widget build(BuildContext context) {
    return AppDialog(
      contentTextStyle: const TextStyle(fontSize: 9, color: Colors.black),
      title: const Center(
        child: Text('Xem Receiving Card'),
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          ReceivingCardWidget(receivingCard: widget.receivingCard),
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Đóng'),
        ),
      ],
    );
  }
}
