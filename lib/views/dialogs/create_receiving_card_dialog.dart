import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/material_info.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/subsystem/pda/pda.dart';
import 'package:smart_warehouse/subsystem/printer/printer.dart';
import 'package:smart_warehouse/views/widgets/app_alert_dialog.dart';
import 'package:smart_warehouse/views/widgets/app_drop_down.dart';
import 'package:smart_warehouse/views/widgets/app_text.dart';
import 'package:smart_warehouse/views/widgets/receiving_card_widget.dart';

typedef CreateReceivingCardCallback = void Function(
  PrinterDevice printerDevice,
  bool printWithCurrentDate,
  bool sampleCheck,
  bool roshCheck,
);

Future<void> createReceivingCardDialog(
  BuildContext context, {
  required bool haveReceivingSchedule,
  required ReceivingCard receivingCard,
  required CreateReceivingCardCallback onConfirm,
  required List<PrinterDevice> printerDevices,
  required PrinterDevice? previousPrinterDevice,
  bool isOffsetGoods = false,
}) async {
  await showDialog<void>(
    context: context,
    builder: (_) => _CreateReceivingCardDialog(
      receivingCard: receivingCard,
      onConfirm: onConfirm,
      printerDevices: printerDevices,
      previousPrinterDevice: previousPrinterDevice,
      showReceivingSchedule: haveReceivingSchedule,
      isOffsetGoods: isOffsetGoods,
    ),
  );
}

class _CreateReceivingCardDialog extends StatefulWidget {
  const _CreateReceivingCardDialog({
    required this.printerDevices,
    required this.previousPrinterDevice,
    required this.receivingCard,
    required this.onConfirm,
    required this.showReceivingSchedule,
    required this.isOffsetGoods,
  });

  final List<PrinterDevice> printerDevices;
  final bool showReceivingSchedule;
  final PrinterDevice? previousPrinterDevice;
  final ReceivingCard receivingCard;
  final CreateReceivingCardCallback onConfirm;
  final bool isOffsetGoods;

  @override
  State<_CreateReceivingCardDialog> createState() =>
      _CreateReceivingCardDialogState();
}

class _CreateReceivingCardDialogState
    extends State<_CreateReceivingCardDialog> {
  late PrinterDevice? selectedPrinterDevice;
  bool _isPrintCurrentDate = false;
  bool _sampleCheck = false;
  bool _roshCheck = false;
  late ReceivingCard _receivingCard;

  late PdaDevice pdaDevice;

  @override
  void initState() {
    selectedPrinterDevice = widget.previousPrinterDevice;
    _receivingCard = widget.receivingCard;

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
          ReceivingCardWidget(receivingCard: _receivingCard),
          const SizedBox(height: 8),
          if (widget.showReceivingSchedule)
            CheckboxListTile(
              value: _isPrintCurrentDate,
              contentPadding: EdgeInsets.zero,
              title: const Text('In với ngày hiện tại'),
              onChanged: (_) {
                setState(() {
                  _isPrintCurrentDate = !_isPrintCurrentDate;
                  _receivingCard = _receivingCard.copyWith(
                    isCurrentDate: _isPrintCurrentDate,
                  );
                });
              },
            ),
          if (widget.isOffsetGoods)
            Row(
              children: [
                Expanded(
                  child: CheckboxListTile(
                    value: _sampleCheck,
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    title: const Text('Sample Check'),
                    onChanged: (_) {
                      setState(() {
                        _sampleCheck = !_sampleCheck;
                        _receivingCard = _receivingCard.copyWith(
                          samplingCheck: _sampleCheck,
                        );
                      });
                    },
                  ),
                ),
                Expanded(
                  child: CheckboxListTile(
                    value: _roshCheck,
                    contentPadding: EdgeInsets.zero,
                    dense: true,
                    title: const Text('Rosh Check'),
                    onChanged: (_) {
                      setState(() {
                        _roshCheck = !_roshCheck;
                        _receivingCard = _receivingCard.copyWith(
                          roshCheck: _roshCheck,
                        );
                      });
                    },
                  ),
                ),
              ],
            ),
          AppText.title(
            LocaleKeys.dialog_print_printer,
            style: const TextStyle(fontSize: 12),
          ).tr(),
          const SizedBox(height: 8),
          AppDropdown(
            hint: 'Chon may in',
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
            widget.onConfirm(
              selectedPrinterDevice.value(),
              _isPrintCurrentDate,
              _sampleCheck,
              _roshCheck,
            );
          },
          child: const Text(LocaleKeys.dialog_print_print).tr(),
        ),
      ],
    );
  }
}
