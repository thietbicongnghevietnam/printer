import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/di/di.dart';

import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/extensions/duration_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/subsystem/pda/pda.dart';
import 'package:smart_warehouse/views/dialogs/print_box_card_dialog.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';
import 'package:smart_warehouse/views/widgets/app_text.dart';
import 'package:smart_warehouse/views/widgets/barcode_widget.dart';

import 'find_barcode_lost_controller.dart';
import 'find_barcode_lost_state.dart';

@RoutePage()
class FindBarcodeLostPage
    extends BasePage<FindBarcodeLostController, FindBarcodeLostState> {
  const FindBarcodeLostPage({super.key});

  @override
  BasePageState createState() => _FindBarcodeLostPageState();
}

class _FindBarcodeLostPageState
    extends BasePageState<FindBarcodeLostController, FindBarcodeLostState> {
  late TextEditingController rcController;
  late TextEditingController findBoxLostController;

  late FocusNode receivingCardFocusNode;
  late FocusNode findBoxLostFocusNode;

  final PageController _pageOnRcController = PageController();
  final PageController _pageBoxController = PageController();

  late PdaDevice pdaDevice;

  @override
  void initState() {
    rcController = TextEditingController();
    findBoxLostController = TextEditingController();

    receivingCardFocusNode = FocusNode()..requestFocus();
    findBoxLostFocusNode = FocusNode();

    pdaDevice = getIt<PdaDevice>();
    pdaDevice.listen(context, (data) async {
      if (receivingCardFocusNode.hasFocus) {
        await context.read<FindBarcodeLostController>().scanReceivingCard(data);
      } else if (findBoxLostFocusNode.hasFocus) {
        await context.read<FindBarcodeLostController>().scanBoxForRemove(data);
      }
      rcController.text = data;
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
      appBar:
          AppBar(title: const Text(LocaleKeys.storing_find_boxcard_lost).tr()),
      body: _buildBody(cubit).paddingAll(16),
    );
  }

  Widget _buildBody(FindBarcodeLostController cubit) {
    return BlocBuilder<FindBarcodeLostController, FindBarcodeLostState>(
      buildWhen: (prev, current) {
        return prev.receivingCard != current.receivingCard;
      },
      builder: (context, state) {
        final rc = state.receivingCard;
        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                primary: true,
                child: Column(
                  children: [
                    Row(
                      children: [
                        AppText.title('Re-Card:'),
                        const SizedBox(width: 8),
                        Expanded(
                          child: AppFormField(
                            autoFocus: true,
                            readOnly: true,
                            showCursor: true,
                            focusNode: receivingCardFocusNode,
                            controller: rcController,
                          ),
                        ),
                      ],
                    ),
                    if (state.receivingCard != null) ...[
                      const SizedBox(height: 16),
                      if (rc != null && rc.items.isNotEmpty) ...[
                        const Text(
                                LocaleKeys.storing_scan_box_alive_for_find_box)
                            .tr(),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            AppText.title('Boxcard:'),
                            const SizedBox(width: 8),
                            Expanded(
                              child: AppFormField(
                                readOnly: true,
                                showCursor: true,
                                focusNode: findBoxLostFocusNode,
                                controller: findBoxLostController,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                      const Text(LocaleKeys.storing_list_box_lost).tr(),
                      const SizedBox(height: 16),
                      _buildBoxList(cubit),//
                      const SizedBox(height: 16),
                      _buildNumberOfBox(cubit),
                      // const SizedBox(height: 16),
                      // _buildBoxAliveList(cubit),
                    ] else ...[
                      const SizedBox(height: 16),
                      const Center(child: Text('Vui lòng quét Receiving Card')),
                    ],
                  ],
                ),
              ),
            ),
            _buildButtonPrintBox(cubit),
          ],
        );
      },
    );
  }

  Widget _buildBoxList(FindBarcodeLostController cubit) {
    return BlocBuilder<FindBarcodeLostController, FindBarcodeLostState>(
      buildWhen: (prev, current) => prev.listBoxAlive != current.listBoxAlive,
      builder: (context, state) {
        final rcItem = state.listBoxAlive;
        if (rcItem.isEmpty) {
          return const SizedBox();
        }
        final barcodes = rcItem.map((e) => e.partCard).toList();

        return SizedBox(
          height: 160,
          child: BlocSelector<FindBarcodeLostController, FindBarcodeLostState,
              int?>(
            selector: (state) {
              return state.activePage;
            },
            builder: (context, activePage) {
              return PageView.builder(
                itemBuilder: (context, index) {
                  return BarcodeWidget(barcode: barcodes[index]);
                },
                controller: _pageOnRcController,
                onPageChanged: (page) {
                  cubit.onChangePageOnRc(page);
                },
                itemCount: barcodes.length,
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildNumberOfBox(FindBarcodeLostController cubit) {
    return BlocBuilder<FindBarcodeLostController, FindBarcodeLostState>(
        buildWhen: (prev, current) {
      return prev.listBoxAlive != current.listBoxAlive ||
          prev.activePage != current.activePage;
    }, builder: (context, state) {
      if (state.listBoxAlive.isNotEmpty) {
        final rcItem = state.listBoxAlive;
        if (rcItem.isEmpty) {
          return const SizedBox();
        }
        final barcodes = rcItem.map((e) => e.partCard).toList();
        final total = barcodes.length;
        return RichText(
          text: TextSpan(
            text: '${state.activePage + 1}',
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 15,
              color: Colors.red,
            ),
            children: [
              TextSpan(
                text: ' / $total',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        );
      }
      return const SizedBox.shrink();
    });
  }

  Widget _buildBoxAliveList(FindBarcodeLostController cubit) {
    return BlocBuilder<FindBarcodeLostController, FindBarcodeLostState>(
      buildWhen: (prev, current) => prev.listBoxAlive != current.listBoxAlive,
      builder: (context, state) {
        final rcItem = state.listBoxAlive;
        if (rcItem.isEmpty) {
          return const SizedBox();
        }
        final barcodes = rcItem.map((e) => e.partCard).toList();

        return SizedBox(
          height: 160,
          child: BlocSelector<FindBarcodeLostController, FindBarcodeLostState,
              int?>(
            selector: (state) {
              return state.activePage;
            },
            builder: (context, activePage) {
              return PageView.builder(
                itemBuilder: (context, index) {
                  return BarcodeWidget(barcode: barcodes[index]);
                },
                controller: _pageBoxController,
                itemCount: barcodes.length,
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildButtonPrintBox(FindBarcodeLostController cubit) {
    return BlocBuilder<FindBarcodeLostController, FindBarcodeLostState>(
      buildWhen: (prev, current) =>
          prev.receivingCard != current.receivingCard ||
          prev.listBoxAlive != current.listBoxAlive,
      builder: (context, state) {
        if (state.receivingCard == null) {
          return const SizedBox.shrink();
        }
        return ElevatedButton(
          child: const Text(LocaleKeys.storing_re_print_box_lost).tr(),
          onPressed: () async {
            final rcItem = state.listBoxAlive;
            if (rcItem.isEmpty) {
              await Duration.zero.delay(() async {
                getIt<AppAlertDialog>().show(
                  context,
                  type: AppAlertType.error,
                  message:
                      'Receiving Card không có box, vui lòng quét Receiving Card cần re print',
                  onConfirm: () {},
                );
              });
            }
            final barcodes = rcItem.map((e) => e.partCard).toList();
            Duration.zero.delay(() async {
              showPrintBoxCardDialog(
                context,
                barcodes: barcodes,
                onConfirm: (printer, from, to) async {
                  await cubit.printBoxCards(
                    barcodes: barcodes.sublist(from - 1, to),
                    printerDevice: printer,
                  );

                  Duration.zero.delay(() async {
                    getIt<AppAlertDialog>().show(
                      context,
                      type: AppAlertType.success,
                      message: 'In thành công!',
                      onConfirm: () async {
                        receivingCardFocusNode.requestFocus();
                        rcController.text = '';
                        cubit.clearData();
                      },
                    );
                  });
                },
                printerDevices: cubit.printerDevices ?? [],
                previousPrinterDevice: cubit.savePrinterDevice,
              );
            });
          },
        );
      },
    );
  }
}
