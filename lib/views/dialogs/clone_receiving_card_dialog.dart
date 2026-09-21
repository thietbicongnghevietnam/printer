import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/barcode/barcode.dart';
import 'package:smart_warehouse/entities/barcode/box_card_barcode.dart';
import 'package:smart_warehouse/entities/material_info.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:smart_warehouse/shared/extensions/table_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/views/widgets/app_alert_dialog.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';

Future<void> showCloneReceivingCardDialog(
  BuildContext context, {
  required ReceivingCard receivingCard,
  required MaterialInfo materialInfo,
  required void Function(int, List<Barcode>, String, bool) onUpdate,
}) {
  return showDialog(
    context: context,
    builder: (_) => _CloneReceivingCardDialog(
      receivingCard: receivingCard,
      onUpdate: onUpdate,
      materialInfo: materialInfo,
    ),
  );
}

class _CloneReceivingCardDialog extends StatefulWidget {
  const _CloneReceivingCardDialog({
    required this.receivingCard,
    required this.onUpdate,
    required this.materialInfo,
  });

  final ReceivingCard receivingCard;
  final MaterialInfo materialInfo;
  final void Function(int, List<Barcode>, String, bool) onUpdate;

  @override
  State<_CloneReceivingCardDialog> createState() =>
      _CloneReceivingCardDialogState();
}

class _CloneReceivingCardDialogState extends State<_CloneReceivingCardDialog> {
  late TextEditingController quantityController;
  late TextEditingController slocController;
  late TextEditingController standardPackingController;

  List<Barcode> barcodes = [];
  int box = 0;
  bool createBox = false;

  @override
  void initState() {
    quantityController = TextEditingController(
        text: widget.receivingCard.currentQuantity.toString());
    slocController = TextEditingController();
    standardPackingController = TextEditingController(
      text: widget.materialInfo.standardPacking?.toString(),
    );
    saveBoxCard(createBarcodes());
    super.initState();
  }

  void updateBox() {
    final quantity = quantityController.text.toInt();
    final standardPacking =
        standardPackingController.text.toInt(defaultValue: 1);
    setState(() {
      box = (quantity / standardPacking).ceil();
    });
  }

  void saveBoxCard(List<Barcode> value) {
    barcodes = value;
  }

  List<Barcode> createBarcodes() {
    final quantity = quantityController.text.toInt();
    final standardPacking =
        standardPackingController.text.toInt(defaultValue: 1);
    final box = (quantity / standardPacking).ceil();
    if (standardPacking == 0) {
      getIt<AppAlertDialog>().show(context,
          type: AppAlertType.error,
          message: 'Standard Packing không được bỏ trống');
    }

    if (barcodes.length == box && barcodes.first.quantity == standardPacking) {
      return barcodes;
    }

    final surplusQuantity = quantity % (standardPacking ?? 1);

    final list = List.generate(
      box,
      (index) => BoxCardBarcode(
        material: widget.receivingCard.material,
        quantity: index == box - 1 && surplusQuantity != 0
            ? surplusQuantity
            : standardPacking,
        unitNo: '${index + 1}',
        plant: widget.receivingCard.plant ?? '',
        sloc: slocController.text.toUpperCase(),
        box: box,
        deliveryPlan: widget.receivingCard.deliveryPlan,
        type: widget.materialInfo.type,
        frequency: widget.materialInfo.frequency,
        vendor: widget.receivingCard.vendorName,
      ),
    ).toList();
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return AppDialog(
      title: const Text('Sao chép Receiving Card'),
      content: Form(
        onChanged: () => updateBox(),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Table(
                columnWidths: const {
                  0: FixedColumnWidth(80),
                  1: FlexColumnWidth(),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    children: [
                      const Text('Số lượng:'),
                      AppFormField(
                        autoFocus: true,
                        keyboardType: TextInputType.number,
                        controller: quantityController,
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Text('Sloc:'),
                      AppFormField(
                        controller: slocController,
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Text('Standard packing:'),
                      Row(
                        children: [
                          Expanded(
                            child: AppFormField(
                              keyboardType: TextInputType.number,
                              controller: standardPackingController,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              onChanged: (_) => setState(() {
                                barcodes = createBarcodes();
                              }),
                            ),
                          ),
                          IconButton(
                            onPressed: () async {
                              final barcodes = createBarcodes();

                              await context
                                  .pushRoute<List<Barcode>>(
                                ListBoxCardRoute(
                                  barcodes: barcodes,
                                  totalQuantity:
                                      quantityController.text.toInt(),
                                ),
                              )
                                  .then((value) {
                                if (value != null) {
                                  saveBoxCard(value);
                                }
                              });
                            },
                            icon: Badge(
                              offset: const Offset(8, -4),
                              label: Text(box.toString()),
                              child: const Icon(Icons.format_list_bulleted),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  TableRow(
                    children: [
                      const Text('Tạo Box:'),
                      Row(
                        children: [
                          Checkbox(
                            value: createBox,
                            onChanged: (_) {
                              setState(() {
                                createBox = !createBox;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ].withSpaceBetween(4),
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            if (slocController.text == '') {
              getIt<AppAlertDialog>().show(context,
                  type: AppAlertType.error,
                  message: 'Sloc không được bỏ trống');
            } else {
              if (barcodes.isEmpty) {
                barcodes = createBarcodes();
              }
              widget.onUpdate(quantityController.text.toInt(), barcodes,
                  slocController.text.toUpperCase(), createBox);
            }
          },
          child: const Text(LocaleKeys.dialog_update_quantity_update).tr(),
        ),
      ],
    );
  }
}
