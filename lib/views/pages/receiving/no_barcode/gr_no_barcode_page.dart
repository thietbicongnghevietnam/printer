import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/barcode/barcode.dart';
import 'package:smart_warehouse/entities/barcode/box_card_barcode.dart';
import 'package:smart_warehouse/entities/delivery_plan.dart';
import 'package:smart_warehouse/entities/delivery_plan_detail.dart';
import 'package:smart_warehouse/entities/material_info.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/enums/storage_location.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/extensions/context_extensions.dart';
import 'package:smart_warehouse/shared/extensions/duration_extensions.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/shared/utils/keyboard.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';
import 'package:smart_warehouse/subsystem/pda/pda.dart';
import 'package:smart_warehouse/views/dialogs/status_indication_dialog.dart';
import 'package:smart_warehouse/views/pages/receiving/index/good_receipt_handle.dart';
import 'package:smart_warehouse/views/widgets/app_autocomplete.dart';
import 'package:smart_warehouse/views/widgets/app_dotted_border.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';
import 'package:smart_warehouse/views/widgets/app_text.dart';

import 'gr_no_barcode_controller.dart';
import 'gr_no_barcode_state.dart';

@RoutePage()
class GRNoBarcodePage
    extends BasePage<GRNoBarcodeController, GRNoBarcodeState> {
  const GRNoBarcodePage({
    super.key,
    this.receivingCard,
    this.material,
    required this.deliveryPlan,
    this.isOffsetGoods = false,
  });

  final DeliveryPlan deliveryPlan;
  final String? material;
  final ReceivingCard? receivingCard;
  final bool isOffsetGoods;

  @override
  GRNoBarcodeController buildCubit(BuildContext context) {
    return getIt<GRNoBarcodeController>()
      ..deliveryPlan = deliveryPlan
      ..material = material
      ..isOffsetGoods = isOffsetGoods
      ..receivingCard = receivingCard;
  }

  @override
  BasePageState createState() => _GRNoBarcodePageState();
}

class _GRNoBarcodePageState
    extends BasePageState<GRNoBarcodeController, GRNoBarcodeState>
    with GoodReceiptHandle {
  late TextEditingController codeController;
  late TextEditingController quantityController;
  late TextEditingController standardPackingController;
  late FocusNode codeFocusNote;
  late FocusNode boxFocusNote;
  late PdaDevice pdaDevice;

  @override
  void initState() {
    pdaDevice = getIt<PdaDevice>();
    pdaDevice.listen(context, (data) async {
      context.read<GRNoBarcodeController>().scanBarcode(data);
    });

    codeController = TextEditingController();
    quantityController = TextEditingController();
    standardPackingController = TextEditingController();
    codeFocusNote = FocusNode()..requestFocus();
    boxFocusNote = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    pdaDevice.dispose();
    super.dispose();
  }

  @override
  void onViewLoaded(context, cubit, state) {
    codeController.text = state.selectItem?.material ?? '';
    quantityController.text = state.quantity.toString();
    super.onViewLoaded(context, cubit, state);
  }

  @override
  void handleError(
    BuildContext context,
    Object? error, [
    StackTrace? stackTrace,
  ]) {
    final controller = context.read<GRNoBarcodeController>();
    if (error is ValidationError && controller.savedReceivingCard != null) {
      if (error.type
          case ValidationErrorType.connectPrinterError ||
              ValidationErrorType.printError) {
        getIt<AppAlertDialog>().show(
          context,
          type: AppAlertType.error,
          message: error.message,
          confirmText: LocaleKeys.dialog_print_reprint.tr(),
          onConfirm: () async {
            await controller.reprintReceivingCard();
            await Duration.zero.delay(() async {
              getIt<AppAlertDialog>().show(
                context,
                message: LocaleKeys.dialog_print_success.tr(),
                onConfirm: () => controller.clearData(),
              );
            });
          },
          onCancel: () {},
        );
        return;
      }
    }

    super.handleError(context, error, stackTrace);
  }

  @override
  Widget builder(context, cubit, state) {
    return MultiBlocListener(
      listeners: [
        BlocListener<GRNoBarcodeController, GRNoBarcodeState>(
          listenWhen: (preState, state) => preState.quantity != state.quantity,
          listener: (context, state) {
            quantityController.text = state.quantity.toString();
          },
        ),
        BlocListener<GRNoBarcodeController, GRNoBarcodeState>(
          listenWhen: (preState, state) =>
              preState.selectItem != state.selectItem,
          listener: (context, state) {
            codeController.text = state.selectItem?.material ?? '';
          },
        ),
        BlocListener<GRNoBarcodeController, GRNoBarcodeState>(
          listenWhen: (preState, state) =>
              preState.standardPacking != state.standardPacking,
          listener: (context, state) {
            standardPackingController.text =
                state.standardPacking?.toString() ?? '';
          },
        ),
      ],
      child:
          BlocSelector<GRNoBarcodeController, GRNoBarcodeState, DeliveryPlan?>(
        selector: (state) => state.deliveryPlan,
        builder: (context, deliveryPlan) {
          return Scaffold(
            appBar: AppBar(
              title: Text(cubit.isOffsetGoods ? 'Nhận hàng giao bù' : LocaleKeys.gr_no_barcode_title).tr(),
              actions: [
                IconButton(
                  onPressed: () {
                    context.pushRoute(
                      DAInvoiceRoute(
                        deliveryPlan: deliveryPlan.value(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.checklist),
                ),
              ],
            ),
            body: ListView(
              children: [
                Table(
                  columnWidths: const {
                    0: FixedColumnWidth(75),
                    1: FlexColumnWidth(),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      children: [
                        Text(deliveryPlan?.type.toString() ?? ''),
                        Row(
                          children: [
                            AppText.title(deliveryPlan?.no ?? ''),
                            const SizedBox(width: 8),
                            if (cubit.receivingCard == null)
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.zero,
                                  backgroundColor: const Color(0xFF4D4D4D),
                                  minimumSize: const Size(100, 28),
                                  textStyle: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                onPressed: () async {
                                  await context.pushRoute<DeliveryPlan>(
                                    SelectDAInvoiceRoute(
                                      onSelect: (deliveryPlan, material) {
                                        context.maybePop();
                                        if (deliveryPlan != null) {
                                          cubit.updateDAInvoice(deliveryPlan);
                                        }
                                        if (material != null) {
                                          cubit.updateItemByMaterial(material);
                                        }
                                      },
                                    ),
                                  );
                                },
                                child: const Text(
                                  LocaleKeys.gr_no_barcode_change_da_inv,
                                ).tr(),
                              ),
                          ],
                        ),
                      ],
                    ),
                    const TableRow(children: [SizedBox(height: 8), SizedBox()]),
                    TableRow(
                      children: [
                        Row(
                          children: [
                            const Text(LocaleKeys.gr_no_barcode_code).tr(),
                            IconButton(
                              onPressed: () {
                                showStatusIndicationDialog(context);
                              },
                              icon: const Icon(Icons.info_outline),
                            ),
                          ],
                        ),
                        BlocSelector<GRNoBarcodeController, GRNoBarcodeState,
                            MaterialInfo?>(
                          selector: (state) => state.materialInfo,
                          builder: (context, materialInfo) {
                            return AppDottedBorder(
                              visible: materialInfo?.urgent ?? false,
                              radius: const Radius.circular(8),
                              strokeWith: 3,
                              child: AppAutoComplete<DeliveryPlanDetail>(
                                displayStringForOption: (value) =>
                                    value.material,
                                focusNode: codeFocusNote,
                                controller: codeController,
                                readOnly: cubit.receivingCard != null,
                                decoration: InputDecoration(
                                  filled: materialInfo != null,
                                  fillColor: materialInfo?.isInspection ?? true
                                      ? Colors.yellowAccent.withOpacity(0.5)
                                      : Colors.orangeAccent.withOpacity(0.5),
                                  focusedBorder: materialInfo?.urgent ?? false
                                      ? const OutlineInputBorder(
                                          borderSide: BorderSide(
                                            style: BorderStyle.none,
                                          ),
                                        )
                                      : null,
                                  suffixIcon: cubit.receivingCard == null
                                      ? IconButton(
                                          onPressed: () async {
                                            final selectCode =
                                                await context.pushRoute<String>(
                                              const CameraCaptureRoute(),
                                            );
                                            codeController.text =
                                                selectCode ?? '';
                                          },
                                          icon: const Icon(
                                            Icons.document_scanner,
                                          ),
                                        )
                                      : null,
                                ),
                                optionsBuilder: (textEditingValue) {
                                  return deliveryPlan?.details.where(
                                        (element) =>
                                            element.material.materialCompare(
                                              textEditingValue.text,
                                            ) &&
                                            element.totalQuantity >
                                                (element.gredQuantity ?? 0),
                                      ) ??
                                      [];
                                },
                                onSelect: (result) {
                                  cubit.updateItem(result);
                                  hideKeyboard();
                                },
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const TableRow(children: [SizedBox(height: 8), SizedBox()]),
                    TableRow(
                      children: [
                        const Text(LocaleKeys.gr_no_barcode_qty).tr(),
                        AppFormField(
                          keyboardType: TextInputType.number,
                          controller: quantityController,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          onChanged: (value) =>
                              cubit.updateQuantity(value.toInt()),
                        ),
                      ],
                    ),
                    const TableRow(children: [SizedBox(height: 8), SizedBox()]),
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
                                onChanged: (value) =>
                                    cubit.updateStandardPacking(value.toInt()),
                              ),
                            ),
                            BlocSelector<GRNoBarcodeController,
                                GRNoBarcodeState, int>(
                              selector: (state) => state.box,
                              builder: (context, boxCount) {
                                return IconButton(
                                  onPressed: () async {
                                    hideKeyboard();
                                    await cubit
                                        .createBoxCard()
                                        .then((barcodes) async {
                                      await context
                                          .pushRoute<List<Barcode>>(
                                        ListBoxCardRoute(
                                          barcodes: barcodes,
                                          totalQuantity: cubit.state.quantity,
                                        ),
                                      )
                                          .then((value) {
                                        if (value != null) {
                                          cubit.saveBoxCard(value);
                                        }
                                      });
                                    });
                                  },
                                  icon: Badge(
                                    offset: const Offset(8, -4),
                                    label: Text(boxCount.toString()),
                                    child:
                                        const Icon(Icons.format_list_bulleted),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                BlocSelector<GRNoBarcodeController, GRNoBarcodeState,
                    (int?, int?)>(
                  selector: (state) =>
                      (state.gredQuantity, state.totalQuantity),
                  builder: (context, data) {
                    return Text.rich(
                      TextSpan(
                        text: LocaleKeys.gr_no_barcode_received_plan_qty.tr(),
                        children: [
                          TextSpan(
                            text: '${data.$1 ?? '-'}/${data.$2 ?? '-'}',
                            style: context.theme.textTheme.titleMedium,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ).paddingAll(16),
            bottomNavigationBar: cubit.receivingCard == null
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      BlocSelector<GRNoBarcodeController, GRNoBarcodeState,
                          (bool, bool)>(
                        selector: (state) => (
                          state.materialInfo?.storageLocation !=
                              StorageLocation.smt,
                          state.isPrintBoxCard
                        ),
                        builder: (context, data) {
                          return CheckboxListTile(
                            value: data.$1 && data.$2,
                            enabled: data.$1,
                            title: const Text('In Box Card'),
                            onChanged: (v) =>
                                cubit.updateIsPrintBoxCard(v ?? false),
                          );
                        },
                      ),
                      ElevatedButton(
                        onPressed: () => createReceivingCard(context, cubit),
                        child: const Text(
                                LocaleKeys.gr_no_barcode_print_receive_card)
                            .tr(),
                      ).paddingSymmetric(horizontal: 16, vertical: 4),
                    ],
                  )
                : ElevatedButton(
                    onPressed: () => updateReceivingCard(context, cubit),
                    child: const Text('Update Receiving Card'),
                  ).paddingSymmetric(horizontal: 16, vertical: 8),
          );
        },
      ),
    );
  }
}
