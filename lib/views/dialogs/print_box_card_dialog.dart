import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/barcode/barcode.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/subsystem/pda/pda.dart';
import 'package:smart_warehouse/subsystem/printer/printer.dart';
import 'package:smart_warehouse/views/widgets/app_alert_dialog.dart';
import 'package:smart_warehouse/views/widgets/app_drop_down.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';
import 'package:smart_warehouse/views/widgets/app_text.dart';
import 'package:smart_warehouse/views/widgets/barcode_widget.dart';

typedef PrintBoxCardCallBack = void Function(
  PrinterDevice printerDevice,
    int from,
    int to,
);

Future<void> showPrintBoxCardDialog(
  BuildContext context, {
  required List<Barcode> barcodes,
  required PrintBoxCardCallBack onConfirm,
  required List<PrinterDevice> printerDevices,
  required PrinterDevice? previousPrinterDevice,
}) async {
  await showDialog<void>(
    context: context,
    builder: (_) => _PrintBoxCardDialog(
      barcodes: barcodes,
      printerDevices: printerDevices,
      onConfirm: onConfirm,
      previousPrinterDevice: previousPrinterDevice,
    ),
  );
}

class _PrintBoxCardDialog extends StatefulWidget {
  const _PrintBoxCardDialog({
    required this.barcodes,
    required this.printerDevices,
    this.previousPrinterDevice,
    required this.onConfirm,
  });

  final List<Barcode> barcodes;
  final List<PrinterDevice> printerDevices;
  final PrinterDevice? previousPrinterDevice;
  final PrintBoxCardCallBack onConfirm;

  @override
  State<_PrintBoxCardDialog> createState() => _PrintBoxCardDialogState();
}

class _PrintBoxCardDialogState extends State<_PrintBoxCardDialog> {
  late PrinterDevice? selectedPrinterDevice;
  late PdaDevice pdaDevice;
  late TextEditingController fromController;
  late TextEditingController toController;
  final PageController _pageController = PageController();
  int _activePage = 0;

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

    fromController = TextEditingController(text: '1');
    toController = TextEditingController(text: widget.barcodes.length.toString());

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
      title: const Text('Thông tin barcode'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 160,
            child: PageView.builder(
              itemBuilder: (context, index) {
                return BarcodeWidget(barcode: widget.barcodes[index]);
              },
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  _activePage = page;
                });
              },
              itemCount: widget.barcodes.length,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${_activePage + 1}/${widget.barcodes.length}',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              AppText('Từ'),
              Expanded(child: AppFormField(controller: fromController,)),
              AppText('Đến'),
              Expanded(child: AppFormField(controller: toController)),
            ].withWidgetBetween(const SizedBox(width: 4)),
          ),
          const SizedBox(height: 8),
          AppDropdown(
            hint: 'Chon May In',
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
            widget.onConfirm(selectedPrinterDevice.value(), fromController.text.toInt(), toController.text.toInt());
          },
          child: const Text('In Box Card'),
        ),
      ],
    );
  }
}
