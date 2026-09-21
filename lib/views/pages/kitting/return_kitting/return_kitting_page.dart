import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/extensions/duration_extensions.dart';
import 'package:smart_warehouse/shared/extensions/int_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/subsystem/pda/pda.dart';
import 'package:smart_warehouse/views/dialogs/receiving_card_dialog.dart';
import 'package:smart_warehouse/views/dialogs/return_kitting_dialog.dart';
import 'package:smart_warehouse/views/pages/kitting/return_kitting/components/in_plan_widget.dart';
import 'package:smart_warehouse/views/pages/kitting/return_kitting/components/out_plan_widget.dart';
import 'package:smart_warehouse/views/pages/kitting/return_kitting/return_kitting_controller.dart';
import 'package:smart_warehouse/views/pages/kitting/return_kitting/return_kitting_state.dart';
import 'package:smart_warehouse/views/widgets/app_radio.dart';

enum ReturnKittingType {
  inPlan('InPlan'),
  outPlan('OutPlan'),
  ng('NG');

  const ReturnKittingType(this.code);

  final String code;
}

@RoutePage()
class ReturnKittingPage
    extends BasePage<ReturnKittingController, ReturnKittingState> {
  const ReturnKittingPage({super.key});

  @override
  BasePageState createState() => _ReturnKittingPageState();
}

class _ReturnKittingPageState
    extends BasePageState<ReturnKittingController, ReturnKittingState> {
  late PdaDevice pdaDevice;

  @override
  void initState() {
    final controller = context.read<ReturnKittingController>();
    pdaDevice = getIt<PdaDevice>();

    pdaDevice.listen(context, (data) {
      controller.scan(data);
    });
    super.initState();
  }

  @override
  Widget builder(
    BuildContext context,
    ReturnKittingController cubit,
    ReturnKittingState state,
  ) {
    return Scaffold(
      appBar: AppBar(title: const Text('Return Kitting')),
      body: BlocSelector<ReturnKittingController, ReturnKittingState,
          ReturnKittingType>(
        selector: (state) => state.returnKittingType,
        builder: (context, returnKittingType) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppRadio(
                    title: 'Inside',
                    value: ReturnKittingType.inPlan,
                    groupValue: returnKittingType,
                    onChanged: (type) => cubit.updateReturnKittingType(type),
                  ),
                  AppRadio(
                    title: 'Outside',
                    value: ReturnKittingType.outPlan,
                    groupValue: returnKittingType,
                    onChanged: (type) => cubit.updateReturnKittingType(type),
                  ),
                  AppRadio(
                    title: 'NG',
                    value: ReturnKittingType.ng,
                    groupValue: returnKittingType,
                    onChanged: (type) => cubit.updateReturnKittingType(type),
                  ),
                ],
              ),
              Expanded(
                child: returnKittingType == ReturnKittingType.outPlan
                    ? const OutPlanWidget()
                    : const InPlanWidget(),
              ),
            ],
          );
        },
      ).paddingOnly(right: 16),
      bottomNavigationBar: ElevatedButton(
        onPressed: () async {
          if (cubit.state.returnKittingType == ReturnKittingType.inPlan && cubit.state.kittingCards.isEmpty) {
            getIt<AppAlertDialog>().show(
              context,
              type: AppAlertType.error,
              message: 'Vui lòng quét Kitting Card',
            );
            return;
          }
          final receivingCard = await cubit.returnKitting(isPreview: true);
          0.seconds.delay(() {
            if (cubit.state.returnKittingType == ReturnKittingType.ng) {
              getIt<AppAlertDialog>().show(
                context,
                message: 'Xác nhận chuyển sang kho NG',
                confirmText: 'Chuyển kho',
                cancelText: 'Đóng',
                barrierDismissible: true,
                onConfirm: () async {
                 await  cubit.returnKitting();
                 0.seconds.delay(() {
                   getIt<AppAlertDialog>().show(
                     context,
                     message: 'Chuyển kho thành công',
                     onConfirm: () {
                       cubit.clearData();
                     },
                   );
                 });
                },
              );
            } else {
              showReceivingCardDialog(
                context,
                receivingCard: receivingCard,
                dialogTitle: 'Xác nhận Return Kitting',
                onConfirm: (device) async {
                  await cubit.confirmReturnKitting(device);

                  0.seconds.delay(() {
                    getIt<AppAlertDialog>().show(
                      context,
                      message: 'In thành công, vui lòng lưu kho',
                      confirmText: 'Lưu kho',
                      cancelText: 'Đóng',
                      onConfirm: () {
                        cubit.clearData();
                        context.pushRoute(StorageRCCardRoute());
                      },
                      onCancel: () {
                        cubit.clearData();
                      },
                    );
                  });
                },
                printerDevices: state.printerDevices,
                previousPrinterDevice: state.savePrinterDevice,
              );
            }
          });
        },
        child: const Text('Xác nhận'),
      ).paddingSymmetric(horizontal: 16, vertical: 8),
    );
  }
}
