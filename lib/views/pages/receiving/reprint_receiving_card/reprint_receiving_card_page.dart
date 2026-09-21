import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/extensions/duration_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/subsystem/pda/pda.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';
import 'package:smart_warehouse/views/widgets/app_text.dart';
import 'package:smart_warehouse/views/widgets/receiving_card_widget.dart';

import '../../../widgets/app_drop_down.dart';
import 'reprint_receiving_card_controller.dart';
import 'reprint_receiving_card_state.dart';

@RoutePage()
class ReprintReceivingCardPage extends BasePage<ReprintReceivingCardController,
    ReprintReceivingCardState> {
  const ReprintReceivingCardPage({super.key});

  @override
  BasePageState createState() => _ReprintReceivingCardPageState();
}

class _ReprintReceivingCardPageState extends BasePageState<
    ReprintReceivingCardController, ReprintReceivingCardState> {
  late TextEditingController idController;
  late PdaDevice pdaDevice;
  final PageController _pageController = PageController();
  int _activePage = 0;

  @override
  void initState() {
    idController = TextEditingController();

    pdaDevice = getIt<PdaDevice>();
    pdaDevice.listen(context, (data) async {
      if (context.router.current.name == ReprintReceivingCardRoute.name) {
        await context
            .read<ReprintReceivingCardController>()
            .loadReceivingCard(data);
        idController.text = data;
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
      appBar: AppBar(
        title: const Text('Reprint Receiving Card'),
        actions: [
          BlocSelector<ReprintReceivingCardController,
              ReprintReceivingCardState, List<ReceivingCard>>(
            selector: (state) => state.receivingCard,
            builder: (context, receivingCard) {
              return Visibility(
                visible: receivingCard.isNotEmpty,
                child: IconButton(
                  onPressed: () => cubit.reloadReceivingCard(),
                  icon: const Icon(Icons.sync),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<ReprintReceivingCardController,
          ReprintReceivingCardState>(
        buildWhen: (prev, current) =>
            prev.receivingCard != current.receivingCard,
        builder: (context, state) {
          return SingleChildScrollView(
            child: Column(
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
                        controller: idController,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                if (state.receivingCard.isEmpty)
                  Center(child: Text('Vui lòng quét Barcode'))
                else ...[
                  SizedBox(
                    height: 250,
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (page) {
                        setState(() {
                          _activePage = page;
                        });
                      },
                      itemCount: state.receivingCard.length,
                      itemBuilder: (context, index) {
                        return ReceivingCardWidget(
                          receivingCard: state.receivingCard[index],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  if (state.receivingCard.length > 1)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        state.receivingCard.length,
                            (index) => Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _activePage == index ? Colors.blue : null,
                            border:
                            _activePage == index ? null : Border.all(),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ).withWidgetBetween(const SizedBox(width: 4)),
                    ),
                  const SizedBox(height: 16),
                  AppDropdown(
                    hint: 'Chọn máy in',
                    displayStringForOption: (option) => option.id,
                    options: cubit.state.printerDevices,
                    value: cubit.state.selectedPrinterDevice,
                    onChange: cubit.changePrinterDevice,
                  ),
                ]
              ],
            ).paddingAll(16),
          );
        },
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () {
              getIt<AppAlertDialog>().show(
                context,
                type: AppAlertType.confirm,
                message: 'Bạn có muốn Revert Receiving Card này?',
                onConfirm: () async {
                  await cubit.revertReceivingCard(_activePage);
                  await Duration.zero.delay(() async {
                    getIt<AppAlertDialog>().show(
                      context,
                      message: 'Hủy Receiving Card thành công',
                    );
                  });
                },
              );
            },
            child: const Text('Hủy Receiving Card'),
          ),
          ElevatedButton(
            onPressed: () async {
              await cubit.printReceivingCard(_activePage);
              await Duration.zero.delay(() async {
                getIt<AppAlertDialog>().show(
                  context,
                  message: LocaleKeys.dialog_print_success.tr(),
                );
              });
            },
            child: const Text('Print Receiving Card'),
          ),
        ],
      ).paddingSymmetric(horizontal: 16, vertical: 8),
    );
  }
}
