import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/enums/receving_card_type.dart';
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

typedef CreateReCardByStockCallBack = void Function(
  PrinterDevice printerDevice,
);

Future<void> showReceivingCardDialog(
  BuildContext context, {
  required ReceivingCard receivingCard,
  VoidCallback? onClose,
  Function? onOkTap,
  required CreateReCardByStockCallBack onConfirm,
  String? dialogTitle,
  String? buttonTitle,
  required List<PrinterDevice> printerDevices,
  required PrinterDevice? previousPrinterDevice,
  bool showSelectPrint = true,
}) async {
  await showDialog<void>(
    context: context,
    builder: (_) => _CreateReceivingCardDialog(
      receivingCard: receivingCard,
      onClose: onClose,
      onConfirm: onConfirm,
      dialogTitle: dialogTitle,
      printerDevices: printerDevices,
      previousPrinterDevice: previousPrinterDevice,
      showSelectPrint: showSelectPrint,
      buttonTitle: buttonTitle,
      onOkTap: onOkTap,
    ),
  );
}

class _CreateReceivingCardDialog extends StatefulWidget {
  const _CreateReceivingCardDialog({
    required this.receivingCard,
    this.onClose,
    required this.onConfirm,
    this.dialogTitle,
    required this.printerDevices,
    this.previousPrinterDevice,
    this.showSelectPrint = true,
    this.buttonTitle,
    this.onOkTap,
  });

  final List<PrinterDevice> printerDevices;
  final PrinterDevice? previousPrinterDevice;
  final ReceivingCard receivingCard;

  final VoidCallback? onClose;
  final Function? onOkTap;
  final CreateReCardByStockCallBack onConfirm;

  final String? dialogTitle;
  final String? buttonTitle;
  final bool showSelectPrint;

  @override
  State<_CreateReceivingCardDialog> createState() =>
      _CreateReceivingCardDialogState();
}

class _CreateReceivingCardDialogState
    extends State<_CreateReceivingCardDialog> {
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
      title: Center(
        child: Text(
          widget.dialogTitle ?? LocaleKeys.dialog_print_print_receiving_card,
        ).tr(),
      ),
      content: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          ReceivingCardWidget(
            receivingCard: widget.receivingCard,
            // rcType: widget.rcType,
          ),
          const SizedBox(
            height: 8,
          ),
          if (widget.showSelectPrint) ...[
            AppText.title(
              'print',
              style: const TextStyle(fontSize: 12),
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
        ],
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(
          onPressed: () {
            if (widget.onOkTap != null) {
              Navigator.pop(context);

              widget.onOkTap?.call();
            } else {
              if (selectedPrinterDevice == null) {
                getIt<AppAlertDialog>()
                    .show(context, message: 'Vui long chon may in');
                return;
              }
              Navigator.pop(context);
              widget.onConfirm(selectedPrinterDevice.value());
            }
          },
          child: Text(widget.buttonTitle ?? 'Print'),
        ),
      ],
    );
  }
}
