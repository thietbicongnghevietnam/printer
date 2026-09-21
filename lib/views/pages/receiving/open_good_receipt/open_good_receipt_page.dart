import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/enums/receiving_card_reason.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/extensions/duration_extensions.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/subsystem/pda/pda.dart';
import 'package:smart_warehouse/views/dialogs/clone_receiving_card_dialog.dart';
import 'package:smart_warehouse/views/dialogs/create_receiving_card_dialog.dart';
import 'package:smart_warehouse/views/dialogs/print_box_card_dialog.dart';
import 'package:smart_warehouse/views/dialogs/receiving_card_dialog.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';
import 'package:smart_warehouse/views/widgets/app_text.dart';
import 'package:smart_warehouse/views/widgets/receiving_card_widget.dart';

import 'open_good_receipt_controller.dart';
import 'open_good_receipt_state.dart';

enum ReceivingCardAction {
  refresh,
  reprint,
  listBoxCard,
  clone,
  listRCClone,
  delete;

  @override
  String toString() {
    return switch (this) {
      refresh => 'Làm mới',
      reprint => 'In lại',
      listBoxCard => 'Danh sách box card',
      clone => 'Tách Receiving Card',
      listRCClone => 'Danh sách RC đã tách',
      delete => 'Hủy Receiving Card',
    };
  }
}

@RoutePage()
class OpenGoodReceiptPage
    extends BasePage<OpenGoodReceiptController, OpenGoodReceiptState> {
  const OpenGoodReceiptPage({super.key});

  @override
  BasePageState createState() => _OpenGoodReceiptPageState();
}

class _OpenGoodReceiptPageState
    extends BasePageState<OpenGoodReceiptController, OpenGoodReceiptState> {
  late TextEditingController idController;
  late PdaDevice pdaDevice;

  @override
  void initState() {
    idController = TextEditingController();

    pdaDevice = getIt<PdaDevice>();
    pdaDevice.listen(context, (data) {
      if (context.router.current.name == OpenGoodReceiptRoute.name) {
        context.read<OpenGoodReceiptController>().loadReceivingCard(data);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    pdaDevice.dispose();
    super.dispose();
  }

  void handleClick(ReceivingCardAction value) {
    final cubit = context.read<OpenGoodReceiptController>();
    switch (value) {
      case ReceivingCardAction.refresh:
        cubit.reloadReceivingCard();
      case ReceivingCardAction.reprint:
        showReceivingCardDialog(
          context,
          receivingCard: cubit.state.receivingCard.value(),
          onConfirm: (printer) {
            cubit.reprintReceivingCard(
              receivingCard: cubit.state.receivingCard.value(),
              printerDevice: printer,
            );
          },
          printerDevices: cubit.state.printerDevices,
          previousPrinterDevice: cubit.state.selectedPrinterDevice,
        );
      case ReceivingCardAction.clone:
        showCloneReceivingCardDialog(
          context,
          receivingCard: cubit.state.receivingCard.value(),
          materialInfo: cubit.state.materialInfo.value(),
          onUpdate: (quantity, barcodes, sloc, createBox) async {
            final receivingCardPreview = await cubit.cloneReceivingCard(
              barcodes: barcodes,
              sloc: sloc,
              quantity: quantity,
              createBox: createBox,
              isPreview: true,
            );

            final haveReceivingSchedule =
                await cubit.checkHaveReceivingSchedule();
            await Duration.zero.delay(() async {
              await createReceivingCardDialog(
                context,
                receivingCard: receivingCardPreview,
                onConfirm: (printer, useCurrentDate, _, __) async {
                  await cubit.confirmPrintReceivingCard(
                    barcodes: barcodes,
                    sloc: sloc,
                    quantity: quantity,
                    createBox: createBox,
                    printerDevice: printer,
                  );
                  await Duration.zero.delay(() async {
                    getIt<AppAlertDialog>().show(
                      context,
                      message: LocaleKeys.dialog_print_success.tr(),
                      onCancel: () {
                        cubit.reloadReceivingCard();
                      },
                    );
                  });
                },
                printerDevices: cubit.state.printerDevices,
                previousPrinterDevice: cubit.state.selectedPrinterDevice,
                haveReceivingSchedule: haveReceivingSchedule,
              );
            });
          },
        );
      case ReceivingCardAction.listRCClone:
        context.pushRoute(
          ReceivingCardListRoute(parentId: cubit.state.receivingCard?.id),
        );
      case ReceivingCardAction.listBoxCard:
        final barcodes =
            cubit.state.receivingCard?.items.map((e) => e.partCard).toList() ??
                [];
        showPrintBoxCardDialog(
          context,
          barcodes: barcodes,
          onConfirm: (printer, from, to) {
            cubit.printBoxCards(
              barcodes: barcodes.sublist(from - 1, to),
              printerDevice: printer,
            );
          },
          printerDevices: cubit.state.printerDevices,
          previousPrinterDevice: cubit.state.selectedPrinterDevice,
        );
      case ReceivingCardAction.delete:
        getIt<AppAlertDialog>().show(
          context,
          type: AppAlertType.confirm,
          message: 'Bạn có muốn Revert Receiving Card này?',
          onConfirm: () async {
            await cubit.revertReceivingCard();
            await Duration.zero.delay(() async {
              getIt<AppAlertDialog>().show(
                context,
                message: 'Hủy Receiving Card thành công',
              );
            });
          },
        );
    }
  }

  @override
  Widget builder(context, cubit, state) {
    return BlocConsumer<OpenGoodReceiptController, OpenGoodReceiptState>(
      listenWhen: (preState, state) =>
          preState.receivingCard != state.receivingCard,
      listener: (context, state) {
        idController.text = state.receivingCard?.material ?? '';
      },
      buildWhen: (preState, state) =>
          preState.receivingCard != state.receivingCard,
      builder: (context, state) {
        final receivingCard = state.receivingCard;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Xem Receiving Card'),
            actions: [
              Visibility(
                visible: receivingCard != null,
                child: PopupMenuButton(
                  onSelected: handleClick,
                  itemBuilder: (context) {
                    return ReceivingCardAction.values.map((choice) {
                      return PopupMenuItem(
                        value: choice,
                        child: Text(choice.toString()),
                      );
                    }).toList();
                  },
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    AppText.title('Receiving Card: '),
                    const SizedBox(width: 8),
                    Expanded(
                      child: AppFormField(
                        autoFocus: true,
                        readOnly: true,
                        showCursor: true,
                        controller: idController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                if (receivingCard != null)
                  ReceivingCardWidget(receivingCard: receivingCard),
              ],
            ).paddingAll(16),
          ),
          bottomNavigationBar: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final receivingCard = cubit.state.receivingCard;

                  await cubit.openReceivingCard();

                  if (receivingCard == null || !mounted) {
                    return;
                  }

                  final deliveryPlan = receivingCard.deliveryPlan;
                  if (receivingCard.haveBarcode) {
                    await context.pushRoute(
                      GRHaveBarcodeRoute(receivingCard: receivingCard),
                    );
                  } else {
                    await context.pushRoute(
                      GRNoBarcodeRoute(
                        deliveryPlan: deliveryPlan.value(),
                        receivingCard: receivingCard,
                      ),
                    );
                  }

                  cubit.reloadReceivingCard();
                },
                child: const Text('Xem Receiving Card'),
              ),
            ],
          ).paddingSymmetric(horizontal: 16, vertical: 8),
        );
      },
    );
  }
}
