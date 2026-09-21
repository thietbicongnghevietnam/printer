import 'package:flutter/material.dart';
import 'package:smart_warehouse/entities/barcode/barcode.dart';
import 'package:smart_warehouse/views/widgets/app_alert_dialog.dart';
import 'package:smart_warehouse/views/widgets/barcode_widget.dart';

Future<void> showBarcodeInfoDialog(
  BuildContext context, {
  required Barcode barcode,
}) async {
  await showDialog<void>(
    context: context,
    builder: (_) => _CreateBarcodeInfoDialog(
      barcode: barcode,
    ),
  );
}

class _CreateBarcodeInfoDialog extends StatefulWidget {
  const _CreateBarcodeInfoDialog({
    required this.barcode,
  });

  final Barcode barcode;

  @override
  State<_CreateBarcodeInfoDialog> createState() =>
      _CreateBarcodeInfoDialogState();
}

class _CreateBarcodeInfoDialogState
    extends State<_CreateBarcodeInfoDialog> {

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      contentTextStyle: const TextStyle(fontSize: 9, color: Colors.black),
      title: const Text('Thông tin barcode'),
      content: BarcodeWidget(barcode: widget.barcode),
      actions: [
        ElevatedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Đóng'),
        ),
      ],
    );
  }
}
