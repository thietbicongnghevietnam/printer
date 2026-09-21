import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/shared/extensions/duration_extensions.dart';
import 'package:smart_warehouse/shared/extensions/int_extensions.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/views/dialogs/create_receiving_card_dialog.dart';
import 'package:smart_warehouse/views/pages/receiving/index/good_receipt_controller.dart';

mixin GoodReceiptHandle {
  Future<void> createReceivingCard(
    BuildContext context,
    GoodReceiptController controller,
  ) async {
    final receivingCardPreview =
        await controller.createReceivingCard(isPreview: true);

    final haveReceivingSchedule = await controller.checkHaveReceivingSchedule();

    await Duration.zero.delay(() async {
      await createReceivingCardDialog(
        context,
        receivingCard: receivingCardPreview,
        isOffsetGoods: controller.isOffsetGoods,
        onConfirm: (printer, useCurrentDate, samplingCheck, rohsCheck) async {
          await controller.confirmPrintReceivingCard(
            printerDevice: printer,
            useCurrentDate: useCurrentDate,
            samplingCheck: samplingCheck,
            roshCheck: rohsCheck,
          );
          await Duration.zero.delay(() async {
            getIt<AppAlertDialog>().show(
              context,
              message: LocaleKeys.dialog_print_success.tr(),
              onConfirm: () => controller.clearData(),
            );
          });
        },
        printerDevices: controller.printerDevices ?? [],
        previousPrinterDevice: controller.savedPrinterDevice,
        haveReceivingSchedule: haveReceivingSchedule,
      );
    });
  }

  Future<void> updateReceivingCard(
    BuildContext context,
    GoodReceiptController controller,
  ) async {
    final newReceivingCard = await controller.updateReceivingCard();
    final haveReceivingSchedule = await controller.checkHaveReceivingSchedule();

    await 0.seconds.delay(() async {
      createReceivingCardDialog(
        context,
        receivingCard: newReceivingCard.value(),
        onConfirm: (printer, useCurrentDate, samplingCheck, rohsCheck) async {
          await controller.confirmUpdateReceivingCard(printerDevice: printer);
          await Duration.zero.delay(() async {
            getIt<AppAlertDialog>().show(
              context,
              message: LocaleKeys.dialog_print_success.tr(),
              onConfirm: () => Navigator.pop(context, true),
            );
          });
        },
        printerDevices: controller.printerDevices ?? [],
        previousPrinterDevice: controller.savedPrinterDevice,
        haveReceivingSchedule: haveReceivingSchedule,
      );
    });
  }
}
