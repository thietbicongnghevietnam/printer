import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/barcode/barcode.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/subsystem/pda/pda.dart';
import 'package:smart_warehouse/subsystem/printer/printer.dart';
import 'package:smart_warehouse/views/widgets/app_alert_dialog.dart';
import 'package:smart_warehouse/views/widgets/app_drop_down.dart';
import 'package:smart_warehouse/views/widgets/app_text.dart';
import 'package:smart_warehouse/views/widgets/barcode_widget.dart';

Future<void> showReprintBarcodeNGDialog(
  BuildContext context, {
  required Barcode barcode,
  required ValueChanged<PrinterDevice> onConfirm,
  required List<PrinterDevice> printerDevices,
  required PrinterDevice? previousPrinterDevice,
}) async {
  await showDialog<void>(
    context: context,
    builder: (_) => _CreateReprintBarcodeNGDialog(
      barcode: barcode,
      onConfirm: onConfirm,
      printerDevices: printerDevices,
      previousPrinterDevice: previousPrinterDevice,
    ),
  );
}

class _CreateReprintBarcodeNGDialog extends StatefulWidget {
  const _CreateReprintBarcodeNGDialog({
    required this.printerDevices,
    required this.previousPrinterDevice,
    required this.barcode,
    required this.onConfirm,
  });

  final List<PrinterDevice> printerDevices;
  final PrinterDevice? previousPrinterDevice;
  final Barcode barcode;
  final ValueChanged<PrinterDevice> onConfirm;

  @override
  State<_CreateReprintBarcodeNGDialog> createState() =>
      _CreateReprintBarcodeNGDialogState();
}

class _CreateReprintBarcodeNGDialogState
    extends State<_CreateReprintBarcodeNGDialog> {
  late PrinterDevice? selectedPrinterDevice;
  late PdaDevice pdaDevice;

  @override
  void initState() {
    selectedPrinterDevice = widget.previousPrinterDevice;

    pdaDevice = getIt<PdaDevice>();
    pdaDevice.listen(
      context,
      (data) {
        setState(() {
          selectedPrinterDevice = widget.printerDevices.firstWhereOrNull(
            (e) => e.id == data || e.macAddress == data.formatMacAddress(),
          );
        });
      },
      onDialog: true,
    );

    super.initState();
  }

  @override
  void dispose() {
    pdaDevice.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      contentTextStyle: const TextStyle(fontSize: 9, color: Colors.black),
      title: const Text(LocaleKeys.dialog_print_print_receiving_card).tr(),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          BarcodeWidget(barcode: widget.barcode),
          const SizedBox(height: 8),
          AppText.title(
            LocaleKeys.dialog_print_printer,
            style: const TextStyle(fontSize: 12),
          ).tr(),
          const SizedBox(height: 8),
          AppDropdown(
            hint: 'Chọn máy in',
            displayStringForOption: (option) => option.id,
            options: widget.printerDevices,
            value: selectedPrinterDevice,
            onChange: (value) => selectedPrinterDevice = value,
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            if (selectedPrinterDevice == null) {
              getIt<AppAlertDialog>()
                  .show(context, message: 'Vui lòng chọn máy in');
              return;
            }
            Navigator.pop(context);
            widget.onConfirm(selectedPrinterDevice.value());
          },
          child: const Text(LocaleKeys.dialog_print_print).tr(),
        ),
      ],
    );
  }
}
