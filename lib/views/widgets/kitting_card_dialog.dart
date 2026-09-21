import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/kitting/kitting_card.dart';
import 'package:smart_warehouse/enums/kitting_type.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';
import 'package:smart_warehouse/subsystem/pda/pda.dart';
import 'package:smart_warehouse/subsystem/printer/printer.dart';
import 'package:smart_warehouse/views/widgets/app_alert_dialog.dart';
import 'package:smart_warehouse/views/widgets/app_drop_down.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';
import 'package:smart_warehouse/views/widgets/app_text.dart';
import 'package:smart_warehouse/views/widgets/kitting_card_widget.dart';

typedef CreateKittingCardCallBack = void Function(
    PrinterDevice printerDevice,
    KittingCard kittingCard,
);

Future<void> createKittingCardDialog(
  BuildContext context, {
  required List<KittingCard> kittingCards,
  required CreateKittingCardCallBack onConfirm,
  required List<PrinterDevice> printerDevices,
  required PrinterDevice? previousPrinterDevice,
}) async {
  await showDialog<void>(
    context: context,
    builder: (_) => KittingCardDialog(
      printerDevices: printerDevices,
      kittingCards: kittingCards,
      onConfirm: onConfirm,
      previousPrinterDevice: previousPrinterDevice,
    ),
  );
}

class KittingCardDialog extends StatefulWidget {
  const KittingCardDialog({
    super.key,
    required this.printerDevices,
    this.previousPrinterDevice,
    required this.kittingCards,
    required this.onConfirm,
  });

  final List<PrinterDevice> printerDevices;
  final PrinterDevice? previousPrinterDevice;
  final List<KittingCard> kittingCards;
  final CreateKittingCardCallBack onConfirm;

  @override
  State<KittingCardDialog> createState() => _KittingCardDialogState();
}

class _KittingCardDialogState extends State<KittingCardDialog> {
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
    final kittingCards = widget.kittingCards;
    return AppDialog(
      contentTextStyle: const TextStyle(fontSize: 9, color: Colors.black),
      title: const Text('Print Kitting Card'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 150,
            child: PageView.builder(
              itemBuilder: (context, index) {
                return KittingCardWidget(kittingCard: kittingCards[index]);
              },
              controller: _pageController,
              onPageChanged: (page) {
                setState(() {
                  _activePage = page;
                });
              },
              itemCount: kittingCards.length,
            ),
          ),
          Text(
            '${_activePage + 1}/${kittingCards.length}',
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
            final kittingCard = widget.kittingCards[_activePage];
            if (selectedPrinterDevice == null) {
              getIt<AppAlertDialog>()
                  .show(context, message: 'Vui long chon may in');
              return;
            }
            Navigator.pop(context);
            widget.onConfirm(selectedPrinterDevice.value(), kittingCard);
          },
          child: const Text('Print'),
        ),
      ],
    );
  }
}
