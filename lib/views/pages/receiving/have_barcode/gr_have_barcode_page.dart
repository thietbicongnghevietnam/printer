import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/delivery_plan.dart';
import 'package:smart_warehouse/entities/draft_receiving_card.dart';
import 'package:smart_warehouse/entities/material_info.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/entities/receiving_card_item.dart';
import 'package:smart_warehouse/enums/scan_type.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/extensions/duration_extensions.dart';
import 'package:smart_warehouse/shared/extensions/int_extensions.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';
import 'package:smart_warehouse/shared/extensions/table_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';
import 'package:smart_warehouse/subsystem/pda/pda.dart';
import 'package:smart_warehouse/views/dialogs/draft_receiving_card_dialog.dart';
import 'package:smart_warehouse/views/dialogs/select_delivery_plan_detail_dialog.dart';
import 'package:smart_warehouse/views/dialogs/status_indication_dialog.dart';
import 'package:smart_warehouse/views/pages/receiving/have_barcode/components/list_scanned_barcode_widget.dart';
import 'package:smart_warehouse/views/pages/receiving/index/good_receipt_handle.dart';
import 'package:smart_warehouse/views/widgets/app_dotted_border.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';
import 'package:smart_warehouse/views/widgets/app_radio.dart';
import 'package:smart_warehouse/views/widgets/app_text.dart';

import '../../../../shared/router/router.gr.dart';
import 'gr_have_barcode_controller.dart';
import 'gr_have_barcode_state.dart';

@RoutePage()
class GRHaveBarcodePage
    extends BasePage<GRHaveBarcodeController, GRHaveBarcodeState> {
  const GRHaveBarcodePage({super.key, this.receivingCard});

  final ReceivingCard? receivingCard;

  @override
  GRHaveBarcodeController buildCubit(BuildContext context) {
    return getIt<GRHaveBarcodeController>()..receivingCard = receivingCard;
  }

  @override
  BasePageState createState() => _GRHaveBarcodeNewPageState();
}

class _GRHaveBarcodeNewPageState
    extends BasePageState<GRHaveBarcodeController, GRHaveBarcodeState>
    with GoodReceiptHandle {
  late TextEditingController _codeController;
  late FocusNode _codeFocusNode;
  late PdaDevice pdaDevice;

  @override
  void handleError(
    BuildContext context,
    Object? error, [
    StackTrace? stackTrace,
  ]) {
    final cubit = context.read<GRHaveBarcodeController>();
    if (error is ValidationError) {
      if (error.type == ValidationErrorType.barcodeNotSame &&
          cubit.receivingCard == null) {
        getIt<AppAlertDialog>().show(
          context,
          type: AppAlertType.confirm,
          barrierDismissible: true,
          message:
              '${error.message}\n${LocaleKeys.dialog_discard_current_receive_card.tr()}',
          onConfirm: cubit.discardReceivingCard,
        );
        return;
      } else if (error.type == ValidationErrorType.draftReceivingCard &&
          cubit.receivingCard == null) {
        getIt<AppAlertDialog>().show(
          context,
          type: AppAlertType.confirm,
          message:
              '${error.message}\n${LocaleKeys.dialog_discard_current_receive_card.tr()}',
          onConfirm: () {
            cubit.clearData();
            cubit.updateScanType();
          },
        );
        return;
      } else if (error.type == ValidationErrorType.barcodeHaveManyDASame) {
        getIt<AppAlertDialog>().show(
          context,
          type: AppAlertType.warning,
          message: error.message,
          confirmText: LocaleKeys.gr_have_barcode_choose_da_inv.tr(),
          onConfirm: () => _chooseDAInv(cubit, context),
        );
        return;
      } else if (error.type
          case ValidationErrorType.connectPrinterError ||
              ValidationErrorType.printError) {
        getIt<AppAlertDialog>().show(
          context,
          type: AppAlertType.error,
          message: error.message,
          confirmText: LocaleKeys.dialog_print_reprint.tr(),
          onConfirm: () async {
            await cubit.reprintReceivingCard();
            await Duration.zero.delay(() async {
              getIt<AppAlertDialog>().show(
                context,
                message: LocaleKeys.dialog_print_success.tr(),
                onConfirm: () => cubit.clearData(),
              );
            });
          },
          onCancel: () {},
        );
        return;
      } else if (error.type == ValidationErrorType.barcodeHaveManyPlantSame) {
        final list = cubit.state.deliveryPlan?.details
            .where(
              (element) => element.material == cubit.newBarcode?.material,
            )
            .toList();

        showSelectDeliveryPlanDetailDialog(
          context,
          details: list ?? [],
          onSelect: (detail) => cubit.chooseDeliveryPlanDetail(detail),
        );
        return;
      }
    }

    if (error is ServerError && error.type == ServerErrorType.cannotFindDAInv) {
      getIt<AppAlertDialog>().show(
        context,
        type: AppAlertType.warning,
        message: error.message,
        confirmText: LocaleKeys.gr_have_barcode_choose_da_inv.tr(),
        onConfirm: () => _chooseDAInv(cubit, context),
      );
      return;
    }

    return super.handleError(context, error, stackTrace);
  }

  Future<void> _chooseDAInv(
    GRHaveBarcodeController cubit,
    BuildContext context,
  ) async {
    final barcode = cubit.newBarcode;

    await context.pushRoute<DeliveryPlan>(
      SelectDAInvoiceRoute(
        material: barcode?.material,
        po: barcode?.po,
        poItem: barcode?.poItem,
        deliveryPlanNo: barcode?.deliveryPlan?.no,
        deliveryPlanType: barcode?.deliveryPlanType,
        quantity: barcode?.totalQuantity ?? barcode?.quantity,
        onSelect: (deliveryPlan, _) async {
          await context.popRoute();
          if (deliveryPlan != null) {
            await cubit.chooseDeliveryPlan(deliveryPlan);
          }
        },
      ),
    );
  }

  @override
  void initState() {
    final cubit = context.read<GRHaveBarcodeController>();

    _codeController = TextEditingController();
    _codeFocusNode = FocusNode()..requestFocus();
    pdaDevice = getIt<PdaDevice>();
    pdaDevice.listen(context, (data) {
      cubit.scanBarcode(data);
    });
    super.initState();
  }

  @override
  void dispose() {
    pdaDevice.dispose();
    super.dispose();
  }

  @override
  void onViewLoaded(context, cubit, state) {
    _codeController.text = state.scanningItem?.material ?? '';
    super.onViewLoaded(context, cubit, state);
  }

  @override
  Widget builder(context, cubit, state) {
    return PopScope(
      onPopInvoked: (_) {
        cubit.saveDraftReceivingCard();
      },
      child: MultiBlocListener(
        listeners: [
          BlocListener<GRHaveBarcodeController, GRHaveBarcodeState>(
            listenWhen: (preState, state) =>
                preState.scanningItem != state.scanningItem,
            listener: (context, state) {
              ScaffoldMessenger.of(context).clearSnackBars();
              _codeController.text = state.scanningItem?.material ?? '';
            },
          ),
          BlocListener<GRHaveBarcodeController, GRHaveBarcodeState>(
            listenWhen: (preState, state) {
              return preState.receivingCardItems != state.receivingCardItems &&
                  state.scanningItem != null &&
                  state.receivingCardItems.isNotEmpty;
            },
            listener: (context, state) {
              if (cubit.scannedQuantity == null ||
                  cubit.totalQuantity != cubit.scannedQuantity) {
                return;
              }

              200.milliseconds.delay(() {
                getIt<AppAlertDialog>().show(
                  context,
                  message: 'Số lượng đã đầy, vui lòng tạo Receiving Card',
                );
              });
            },
          ),
        ],
        child: Scaffold(
          appBar: _buildAppBar(cubit),
          body: _buildBody(cubit, state),
          bottomNavigationBar: _buildBottomNavigation(cubit),
        ),
      ),
    );
  }

  AppBar _buildAppBar(GRHaveBarcodeController cubit) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          context.popRoute();
          cubit.saveDraftReceivingCard();
        },
      ),
      title: const Text(LocaleKeys.gr_have_barcode_title).tr(),
      actions: [
        BlocSelector<GRHaveBarcodeController, GRHaveBarcodeState,
            (int, List<DraftReceivingCard>)>(
          selector: (state) =>
              (state.draftReceivingCards.length, state.draftReceivingCards),
          builder: (context, data) {
            final count = data.$1;
            final draftReceivingCards = data.$2;
            return Visibility(
              visible: count > 0,
              child: IconButton(
                onPressed: () {
                  showDraftReceivingCardDialog(
                    context,
                    draftReceivingCards: draftReceivingCards,
                    onSelect: (_) {},
                    onClear: cubit.clearDraftReceivingCard,
                  );
                },
                icon: Badge(
                  label: Text(count.toString()),
                  child: const Icon(Icons.restore),
                ),
              ),
            );
          },
        ),
        BlocSelector<GRHaveBarcodeController, GRHaveBarcodeState,
            DeliveryPlan?>(
          selector: (state) => state.deliveryPlan,
          builder: (context, deliveryPlan) {
            return Visibility(
              visible: deliveryPlan != null,
              child: IconButton(
                icon: const Icon(Icons.checklist),
                onPressed: () {
                  context.pushRoute(
                    DAInvoiceRoute(deliveryPlan: deliveryPlan.value()),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildBody(
    GRHaveBarcodeController cubit,
    GRHaveBarcodeState state,
  ) {
    return Column(
      children: [
        if (cubit.receivingCard == null)
          BlocSelector<GRHaveBarcodeController, GRHaveBarcodeState, ScanType>(
            selector: (state) => state.scanType,
            builder: (context, scanType) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppRadio(
                    title: LocaleKeys.gr_have_barcode_box_by_box.tr(),
                    value: ScanType.scanByBox,
                    groupValue: scanType,
                    onChanged: cubit.updateScanType,
                  ),
                  AppRadio(
                    title: LocaleKeys.gr_have_barcode_box_by_lot.tr(),
                    value: ScanType.scanByLot,
                    groupValue: scanType,
                    onChanged: cubit.updateScanType,
                  ),
                ],
              );
            },
          )
        else
          const SizedBox(height: 8),
        BlocSelector<GRHaveBarcodeController, GRHaveBarcodeState,
            ReceivingCardItem?>(
          selector: (state) => state.scanningItem,
          builder: (context, scanningItem) {
            return Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: const {
                0: FixedColumnWidth(85),
                1: FlexColumnWidth(),
              },
              children: [
                TableRow(
                  children: [
                    Text(
                      state.deliveryPlan?.type.toString() ?? 'DA/INV:',
                    ),
                    BlocSelector<GRHaveBarcodeController, GRHaveBarcodeState,
                        String?>(
                      selector: (state) => state.deliveryPlan?.no,
                      builder: (context, da) {
                        return AppText.title(da ?? '-');
                      },
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    Row(
                      children: [
                        const Text(LocaleKeys.gr_have_barcode_code).tr(),
                        IconButton(
                          onPressed: () {
                            showStatusIndicationDialog(context);
                          },
                          icon: const Icon(Icons.info_outline),
                        ),
                      ],
                    ),
                    BlocSelector<GRHaveBarcodeController, GRHaveBarcodeState,
                        MaterialInfo?>(
                      selector: (state) => state.materialInfo,
                      builder: (context, materialInfo) {
                        return AppDottedBorder(
                          visible: materialInfo?.urgent ?? false,
                          radius: const Radius.circular(8),
                          strokeWith: 3,
                          child: AppFormField(
                            readOnly: true,
                            showCursor: true,
                            showClear: false,
                            controller: _codeController,
                            focusNode: _codeFocusNode,
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
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Text(LocaleKeys.gr_have_barcode_box_scanned).tr(),
                    BlocSelector<GRHaveBarcodeController, GRHaveBarcodeState,
                        List<ReceivingCardItem>>(
                      selector: (state) => state.receivingCardItems,
                      builder: (context, receivingCardItems) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            AppText.title(
                              cubit.scannedBox?.toString() ?? '-',
                            ),
                            Row(
                              children: [
                                const Text(
                                  LocaleKeys.gr_have_barcode_actual_total_qty,
                                ).tr(),
                                AppText.title(
                                  '${cubit.scannedQuantity ?? '-'}/${cubit.totalQuantity ?? '-'}',
                                  color: cubit.totalQuantity != null &&
                                          cubit.scannedQuantity ==
                                              cubit.totalQuantity
                                      ? Colors.green
                                      : Colors.black,
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ].withSpaceBetween(8),
            );
          },
        ),
        Expanded(
          child: ListScannedBarcodeWidget(
            receivingCardItems: state.receivingCardItems,
          ),
        ),
      ].withWidgetBetween(const SizedBox(height: 8)),
    ).paddingSymmetric(horizontal: 16);
  }

  Widget _buildBottomNavigation(GRHaveBarcodeController cubit) {
    return cubit.receivingCard == null
        ? ElevatedButton(
            onPressed: () => createReceivingCard(context, cubit),
            child:
                const Text(LocaleKeys.gr_have_barcode_print_receive_card).tr(),
          ).paddingSymmetric(horizontal: 16, vertical: 8)
        : ElevatedButton(
            onPressed: () => updateReceivingCard(context, cubit),
            child: const Text('Update Receiving Card'),
          ).paddingSymmetric(horizontal: 16, vertical: 8);
  }
}
