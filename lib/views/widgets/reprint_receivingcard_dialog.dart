import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/kitting/kitting_card.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';
import 'package:smart_warehouse/subsystem/pda/pda.dart';
import 'package:smart_warehouse/subsystem/printer/printer.dart';
import 'package:smart_warehouse/views/widgets/app_alert_dialog.dart';
import 'package:smart_warehouse/views/widgets/app_drop_down.dart';
import 'package:smart_warehouse/views/widgets/app_text.dart';
import 'package:smart_warehouse/views/widgets/kitting_card_widget.dart';
import 'package:smart_warehouse/views/widgets/receiving_card_widget.dart';

typedef CreateReceivingCardCallBack = void Function(
    PrinterDevice printerDevice,
    );

Future<void> createRePrintReceivingCardDialog(
    BuildContext context, {
      required List<ReceivingCard> receivingCards,
      required CreateReceivingCardCallBack onConfirm,
      required List<PrinterDevice> printerDevices,
      required PrinterDevice? previousPrinterDevice,
    }) async {
  await showDialog<void>(
    context: context,
    builder: (_) => RePrintReceivingCardDialog(
      printerDevices: printerDevices,
      receivingCards: receivingCards,
      onConfirm: onConfirm,
      previousPrinterDevice: previousPrinterDevice,
    ),
  );
}

class RePrintReceivingCardDialog extends StatefulWidget {
  const RePrintReceivingCardDialog({
    super.key,
    required this.printerDevices,
    this.previousPrinterDevice,
    required this.receivingCards,
    required this.onConfirm,
  });

  final List<PrinterDevice> printerDevices;
  final PrinterDevice? previousPrinterDevice;
  final List<ReceivingCard> receivingCards;
  final CreateReceivingCardCallBack onConfirm;

  @override
  State<RePrintReceivingCardDialog> createState() => _RePrintReceivingCardDialogState();
}

class _RePrintReceivingCardDialogState extends State<RePrintReceivingCardDialog> {
  late PrinterDevice? selectedPrinterDevice;

  late PdaDevice pdaDevice;
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
    super.initState();
  }

  @override
  void dispose() {
    pdaDevice.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final receivingCards = widget.receivingCards;
    return AppDialog(
      contentTextStyle: const TextStyle(fontSize: 9, color: Colors.black),
      title: const Text('Print Receiving Card'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 200,
            child: PageView.builder(
              itemBuilder: (context, index) {
                return ReceivingCardWidget(receivingCard: receivingCards[index]);
              },
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  _activePage = page;
                });
              },
              itemCount: receivingCards.length,
            ),
          ),
          Text(
            '${_activePage + 1}/${receivingCards.length}',
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 8,
          ),
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
                  .show(context, message: 'Vui long chon may in');
              return;
            }
            Navigator.pop(context);
            widget.onConfirm(selectedPrinterDevice.value());
          },
          child: const Text('Print'),
        ),
      ],
    );
  }
}
