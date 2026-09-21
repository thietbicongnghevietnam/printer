import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/kitting/kitting_card.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/extensions/datetime_extensions.dart';
import 'package:smart_warehouse/shared/extensions/duration_extensions.dart';
import 'package:smart_warehouse/shared/extensions/int_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/router/auth_guard.gr.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/subsystem/pda/pda.dart';
import 'package:smart_warehouse/views/dialogs/receiving_card_dialog.dart';
import 'package:smart_warehouse/views/dialogs/view_kitting_card_dialog.dart';
import 'package:smart_warehouse/views/pages/kitting/revert_kitting/revert_kitting_controller.dart';
import 'package:smart_warehouse/views/pages/kitting/revert_kitting/revert_kitting_state.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';
import 'package:smart_warehouse/views/widgets/app_text.dart';

@RoutePage()
class RevertKittingPage
    extends BasePage<RevertKittingController, RevertKittingState> {
  const RevertKittingPage({super.key});

  @override
  BasePageState createState() => _RevertKittingPageState();
}

class _RevertKittingPageState
    extends BasePageState<RevertKittingController, RevertKittingState> {
  late PdaDevice pdaDevice;
  late TextEditingController _codeController;

  @override
  void initState() {
    final controller = context.read<RevertKittingController>();
    _codeController = TextEditingController();
    pdaDevice = getIt<PdaDevice>();

    pdaDevice.listen(context, (data) async {
      await controller.scanKittingCard(data);
      _codeController.text = data;
    });
    super.initState();
  }

  @override
  Widget builder(
    BuildContext context,
    RevertKittingController cubit,
    RevertKittingState state,
  ) {
    return Scaffold(
      appBar: AppBar(title: const Text('Revert Kitting')),
      body: Column(
        children: [
          Row(
            children: [
              const Text('Kitting Card:'),
              const SizedBox(width: 8),
              Expanded(
                child: AppFormField(
                  readOnly: true,
                  autoFocus: true,
                  controller: _codeController,
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: 10, vertical: 8),
          const Divider(),
          Expanded(
            child: BlocSelector<RevertKittingController, RevertKittingState,
                List<KittingCard>>(
              selector: (state) => state.kittingCards,
              builder: (context, kittingCards) {
                if (kittingCards.isEmpty) {
                  return AppText.header('Vui lòng quét Kitting Card');
                }

                return Column(
                  children: [
                    AppText.header('Danh sách Kitting Card'),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 8),
                        itemCount: kittingCards.length,
                        itemBuilder: (context, index) {
                          final kittingCard = kittingCards[index];
                          final quantity = kittingCard.quantity?.toInt() ?? 0;
                          final qtyTotal = kittingCard.qtyTotal?.toInt() ?? 0;
                          return Slidable(
                            endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (_) =>
                                      cubit.deleteKittingCard(kittingCard),
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                  icon: Icons.delete,
                                  label: 'Xóa',
                                ),
                              ],
                            ),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ListTile(
                                onTap: () {
                                  viewKittingCardDialog(context, kittingCards: [kittingCard]);
                                },
                                minLeadingWidth: 0,
                                horizontalTitleGap: 8,
                                leading: Padding(
                                  padding: const EdgeInsets.only(top: 12),
                                  child: Text(
                                    '#${kittingCard.id}',
                                    style: const TextStyle(
                                      color: Colors.blue,
                                      fontSize: 10,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                title: Text('Material: ${kittingCard.material}'),
                                subtitle: Text(
                                  'Date: ${kittingCard.kittingHour} ${kittingCard.kittingDate?.toText()}',
                                ),
                                trailing: Text(
                                  quantity == qtyTotal
                                      ? qtyTotal.toString()
                                      : '$quantity/$qtyTotal',
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () async {
          if (cubit.state.kittingCards.isEmpty) {
            getIt<AppAlertDialog>().show(
              context,
              type: AppAlertType.error,
              message: 'Vui lòng quét Kitting Card',
            );
            return;
          }
          final receivingCard = await cubit.revertKitting(isPreview: true);
          0.seconds.delay(() {
            showReceivingCardDialog(
              context,
              receivingCard: receivingCard,
              dialogTitle: 'Xác nhận Revert Kitting',
              onConfirm: (device) {
                cubit.confirmRevertKitting(device).then((value) {
                  getIt<AppAlertDialog>().show(
                    context,
                    message: 'In thành công, vui lòng lưu kho',
                    onConfirm: () {
                      context.pushRoute(StorageRCCardRoute());
                    },
                  );
                });
              },
              printerDevices: state.printerDevices,
              previousPrinterDevice: state.savePrinterDevice,
            );
          });
        },
        child: const Text('Xác nhận'),
      ).paddingSymmetric(horizontal: 16, vertical: 8),
    );
  }
}
