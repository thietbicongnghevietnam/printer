import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/subsystem/pda/pda.dart';
import 'package:smart_warehouse/subsystem/printer/printer.dart';
import 'package:smart_warehouse/views/widgets/app_alert_dialog.dart';
import 'package:smart_warehouse/views/widgets/app_drop_down.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';
import 'package:smart_warehouse/views/widgets/app_text.dart';
import 'package:smart_warehouse/views/widgets/kitting_card_dialog.dart';

typedef CreateKittingCardCallBack = void Function(
  int quantity,
);

Future<void> createInputQuantityKittingDialog(
  BuildContext context, {
  required CreateKittingCardCallBack onConfirm,
}) async {
  await showDialog<void>(
      context: context,
      builder: (_) => InputQuantityKittingDialog(
            onConfirm: onConfirm,
          ));
}

class InputQuantityKittingDialog extends StatefulWidget {
  const InputQuantityKittingDialog({
    super.key,
    required this.onConfirm,
  });

  final CreateKittingCardCallBack onConfirm;

  @override
  State<InputQuantityKittingDialog> createState() =>
      _InputQuantityKittingDialogState();
}

class _InputQuantityKittingDialogState
    extends State<InputQuantityKittingDialog> {
  late int quantity;

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      contentTextStyle: const TextStyle(fontSize: 9, color: Colors.black),
      title: const Text('Print Kitting Card'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppFormField(
            keyboardType: TextInputType.number,
            onChanged: (data) {
              quantity = data.toInt();
            },
          ),
          const SizedBox(
            height: 8,
          ),
          AppText.title(
            'Print',
            style: const TextStyle(fontSize: 12),
          ),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            widget.onConfirm(quantity);
          },
          child: const Text('Xác Nhận'),
        ),
      ],
    );
  }
}
