import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/barcode/barcode.dart';
import 'package:smart_warehouse/entities/barcode/local_barcode.dart';
import 'package:smart_warehouse/entities/barcode/oversea_barcode.dart';
import 'package:smart_warehouse/entities/barcode/simple_barcode.dart';
import 'package:smart_warehouse/entities/barcode/standard_barcode.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/extensions/datetime_extensions.dart';
import 'package:smart_warehouse/shared/extensions/duration_extensions.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:smart_warehouse/shared/extensions/table_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/subsystem/pda/pda.dart';
import 'package:smart_warehouse/views/dialogs/reprint_barcode_ng_dialog.dart';
import 'package:smart_warehouse/views/widgets/app_date_picker.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';
import 'package:smart_warehouse/views/widgets/app_text.dart';

import 'reprint_barcode_ng_controller.dart';
import 'reprint_barcode_ng_state.dart';

@RoutePage()
class ReprintBarcodeNGPage
    extends BasePage<ReprintBarcodeNGController, ReprintBarcodeNGState> {
  const ReprintBarcodeNGPage({super.key});

  @override
  BasePageState createState() => _ReprintBarcodeNGPageState();
}

class _ReprintBarcodeNGPageState
    extends BasePageState<ReprintBarcodeNGController, ReprintBarcodeNGState> {
  late TextEditingController barcodeController;
  late TextEditingController unitNoController;
  late TextEditingController materialController;
  late TextEditingController daController;
  late TextEditingController daItemController;
  late TextEditingController deliveryDateController;
  late TextEditingController poController;
  late TextEditingController poItemController;
  late TextEditingController boxQuantityController;
  late TextEditingController totalQuantityController;
  late TextEditingController boxController;
  late PdaDevice pdaDevice;

  @override
  void initState() {
    barcodeController = TextEditingController();
    unitNoController = TextEditingController();
    materialController = TextEditingController();
    daController = TextEditingController();
    daItemController = TextEditingController();
    deliveryDateController = TextEditingController();
    poController = TextEditingController();
    poItemController = TextEditingController();
    boxQuantityController = TextEditingController();
    totalQuantityController = TextEditingController();
    boxController = TextEditingController();

    pdaDevice = getIt<PdaDevice>();
    pdaDevice.listen(context,  (data) async {
      if (context.router.current.name == ReprintBarcodeNGRoute.name) {
        final barcode =
            await context.read<ReprintBarcodeNGController>().loadBarcode(data);
        barcodeController.text = data;
        unitNoController.text = barcode.unitNo ?? '';
        materialController.text = barcode.material;
        daController.text = barcode.deliveryPlan?.no ?? '';
        daItemController.text = barcode.as<LocalBarcode>()?.daItem ?? '';
        deliveryDateController.text =
            barcode.as<LocalBarcode>()?.deliveryDate.toText() ?? '';
        poController.text = barcode.po ?? '';
        poItemController.text = barcode.poItem?.toString() ?? '';
        boxQuantityController.text = barcode.quantity.toString();
        totalQuantityController.text = barcode.totalQuantity?.toString() ?? '';
        boxController.text = barcode.box?.toString() ?? '';
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    pdaDevice.dispose();
    super.dispose();
  }

  @override
  Widget builder(context, cubit, state) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reprint Barcode NG')),
      body: Column(
        children: [
          Row(
            children: [
              AppText.title('Barcode:'),
              const SizedBox(width: 8),
              Expanded(
                child: AppFormField(
                  autoFocus: true,
                  readOnly: true,
                  showCursor: true,
                  controller: barcodeController,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: SingleChildScrollView(
              child: BlocSelector<ReprintBarcodeNGController,
                  ReprintBarcodeNGState, Barcode?>(
                selector: (state) => state.barcode,
                builder: (context, barcode) {
                  if (barcode == null) {
                    return const Center(child: Text('Vui lòng quét barcode'));
                  }
                  return Table(
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    columnWidths: const {
                      0: FixedColumnWidth(100),
                      1: FlexColumnWidth(),
                    },
                    children: [
                      if (barcode is! StandardBarcode && barcode is! SimpleBarcode)
                        TableRow(
                          children: [
                            AppText.title('UnitNo'),
                            AppFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              controller: unitNoController,
                              onChanged: (value) {
                                cubit.updateBarcode(unitNo: value);
                              },
                            ),
                          ],
                        ),
                      TableRow(
                        children: [
                          AppText.title('Material:'),
                          AppFormField(
                            controller: materialController,
                            onChanged: (value) {
                              cubit.updateBarcode(material: value);
                            },
                          ),
                        ],
                      ),
                      if (barcode is LocalBarcode) ...[
                        TableRow(
                          children: [
                            AppText.title('DA:'),
                            AppFormField(
                              controller: daController,
                              onChanged: (value) {
                                cubit.updateBarcode(da: value);
                              },
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            AppText.title('DAItem:'),
                            AppFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              controller: daItemController,
                              onChanged: (value) {
                                cubit.updateBarcode(daItem: value);
                              },
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            AppText.title('Delivery Date:'),
                            AppDatePicker(
                              controller: deliveryDateController,
                              onChanged: (date) {
                                cubit.updateBarcode(deliveryDate: date);
                              },
                            ),
                          ],
                        ),
                      ],
                      if (barcode is LocalBarcode ||
                          barcode is OverseaBarcode) ...[
                        TableRow(
                          children: [
                            AppText.title('PO:'),
                            AppFormField(
                              controller: poController,
                              onChanged: (value) {
                                cubit.updateBarcode(po: value);
                              },
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            AppText.title('PO Item:'),
                            AppFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              controller: poItemController,
                              onChanged: (value) {
                                cubit.updateBarcode(poItem: value);
                              },
                            ),
                          ],
                        ),
                      ],
                      TableRow(
                        children: [
                          AppText.title('Box Quantity:'),
                          AppFormField(
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            controller: boxQuantityController,
                            onChanged: (value) {
                              cubit.updateBarcode(boxQuantity: value.toInt());
                            },
                          ),
                        ],
                      ),
                      if (barcode is LocalBarcode ||
                          barcode is OverseaBarcode) ...[
                        TableRow(
                          children: [
                            AppText.title('Total Quantity:'),
                            AppFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              controller: totalQuantityController,
                              onChanged: (value) {
                                cubit.updateBarcode(
                                  totalQuantity: value.toInt(),
                                );
                              },
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            AppText.title('Box'),
                            AppFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              controller: boxController,
                              onChanged: (value) {
                                cubit.updateBarcode(box: value.toInt());
                              },
                            ),
                          ],
                        ),
                      ],
                    ].withSpaceBetween(8),
                  );
                },
              ),
            ),
          ),
        ],
      ).paddingAll(16),
      bottomNavigationBar: ElevatedButton(
        onPressed: () async {
          final barcode = cubit.state.barcode;
          if (barcode == null) {
            return;
          }
          showReprintBarcodeNGDialog(
            context,
            barcode: barcode,
            onConfirm: (printerDevice) async {
              await cubit.printBarcode(printerDevice);
              await Duration.zero.delay(() async {
                getIt<AppAlertDialog>().show(
                  context,
                  message: LocaleKeys.dialog_print_success.tr(),
                );
              });
            },
            printerDevices: cubit.state.printerDevices,
            previousPrinterDevice: cubit.state.selectedPrinterDevice,
          );
        },
        child: const Text('In lại Barcode NG'),
      ).paddingSymmetric(horizontal: 16, vertical: 8),
    );
  }
}
