import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/views/widgets/app_alert_dialog.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';

Future<void> showUpdateQuantityHaveBarcodeDialog(
  BuildContext context, {
  required int quantity,
  required ValueChanged<int> onUpdate,
}) {
  return showDialog(
    context: context,
    builder: (_) => _UpdateQuantityHaveBarcodeDialog(
      quantity: quantity,
      onUpdate: onUpdate,
    ),
  );
}

class _UpdateQuantityHaveBarcodeDialog extends StatefulWidget {
  const _UpdateQuantityHaveBarcodeDialog({
    required this.quantity,
    required this.onUpdate,
  });

  final int quantity;
  final ValueChanged<int> onUpdate;

  @override
  State<_UpdateQuantityHaveBarcodeDialog> createState() =>
      _UpdateQuantityHaveBarcodeDialogState();
}

class _UpdateQuantityHaveBarcodeDialogState
    extends State<_UpdateQuantityHaveBarcodeDialog> {
  late TextEditingController quantityController;

  @override
  void initState() {
    quantityController =
        TextEditingController(text: widget.quantity.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      title: const Text(LocaleKeys.dialog_update_quantity_update_quantity).tr(),
      content: AppFormField(
        autoFocus: true,
        keyboardType: TextInputType.number,
        controller: quantityController,
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            widget.onUpdate(quantityController.text.toInt());
          },
          child: const Text(LocaleKeys.dialog_update_quantity_update).tr(),
        ),
      ],
    );
  }
}
