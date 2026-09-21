import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/extensions/duration_extensions.dart';
import 'package:smart_warehouse/shared/extensions/table_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/subsystem/pda/pda.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';

import 'input_trolley_controller.dart';
import 'input_trolley_state.dart';

@RoutePage()
class InputTrolleyPage
    extends BasePage<InputTrolleyController, InputTrolleyState> {
  const InputTrolleyPage({super.key});

  @override
  BasePageState createState() => _InputTrolleyPageState();
}

class _InputTrolleyPageState
    extends BasePageState<InputTrolleyController, InputTrolleyState> {
  late TextEditingController _trolleyController;
  late TextEditingController _kittingCardController;
  late ScrollController scrollController;

  late FocusNode trolleyFocusNode;
  late FocusNode kittingCardFocusNode;

  late PdaDevice pdaDevice;

  @override
  void initState() {
    super.initState();

    _trolleyController = TextEditingController();
    _kittingCardController = TextEditingController();
    scrollController = ScrollController();

    trolleyFocusNode = FocusNode()..requestFocus();
    kittingCardFocusNode = FocusNode();

    pdaDevice = getIt<PdaDevice>();
    pdaDevice.listen(context, (data) {
      if (trolleyFocusNode.hasFocus) {
        context.read<InputTrolleyController>().updateTrolley(data);
      } else if (kittingCardFocusNode.hasFocus) {
        context.read<InputTrolleyController>().addKittingList(data);
      }
    });
  }

  @override
  void dispose() {
    _trolleyController.dispose();
    _kittingCardController.dispose();
    pdaDevice.dispose();
    super.dispose();
  }

  @override
  Widget builder(context, cubit, state) {
    return MultiBlocListener(
      listeners: [
        BlocListener<InputTrolleyController, InputTrolleyState>(
          listenWhen: (prev, current) {
            return prev.trolley != current.trolley;
          },
          listener: (context, state) {
            ScaffoldMessenger.of(context).clearSnackBars();

            if (trolleyFocusNode.hasFocus) {
              _trolleyController.text = state.trolley;
              kittingCardFocusNode.requestFocus();
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text(LocaleKeys.kitting_input_trolley).tr(),
        ),
        body: BlocBuilder<InputTrolleyController, InputTrolleyState>(
          buildWhen: (prev, current) {
            return prev.listKittingCardQr != current.listKittingCardQr;
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  columnWidths: const {
                    0: FixedColumnWidth(70),
                    1: FlexColumnWidth(),
                  },
                  children: [
                    TableRow(
                      children: [
                        const Text(LocaleKeys.kitting_trolley).tr(),
                        AppFormField(
                          showCursor: true,
                          readOnly: true,
                          controller: _trolleyController,
                          focusNode: trolleyFocusNode,
                          onChanged: cubit.updateTrolley,
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        const Text(LocaleKeys.kitting_list).tr(),
                        AppFormField(
                          readOnly: true,
                          showCursor: true,
                          controller: _kittingCardController,
                          focusNode: kittingCardFocusNode,
                          onChanged: cubit.addKittingList,
                        ),
                      ],
                    ),
                  ].withSpaceBetween(8),
                ).paddingAll(16),
                if (state.listKittingCardQr.isNotEmpty) ...[
                  RichText(
                    text: TextSpan(
                      text: LocaleKeys.kitting_kitting_list_scanned.tr(),
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                      ),
                      children: [
                        TextSpan(
                          text: ' ${state.listKittingCardQr.length}',
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 15,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ).paddingSymmetric(horizontal: 16),
                  const SizedBox(height: 15),
                  _buildBarcodeList(cubit),
                ],
              ],
            );
          },
        ),
        bottomNavigationBar: ElevatedButton(
          onPressed: () async {
            await cubit.inputLocation();

            await Duration.zero.delay(() async {
              getIt<AppAlertDialog>().show(
                context,
                message: LocaleKeys.kitting_input_trolley_success.tr(),
                onConfirm: () {
                  cubit.clearData();
                  _trolleyController.text = '';
                  _kittingCardController.text = '';
                  trolleyFocusNode.requestFocus();
                },
              );
            });
          },
          child: const Text(LocaleKeys.kitting_input_trolley).tr(),
        ).paddingSymmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  Widget _buildBarcodeList(InputTrolleyController cubit) {
    return BlocSelector<InputTrolleyController, InputTrolleyState,
        List<String>>(
      selector: (state) => state.listKittingCardQr,
      builder: (context, listKittingCardQr) {
        return Expanded(
          child: ListView.separated(
            controller: scrollController,
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
            addAutomaticKeepAlives: false,
            addRepaintBoundaries: false,
            itemCount: listKittingCardQr.length,
            physics: const ClampingScrollPhysics(),
            separatorBuilder: (_, __) => const SizedBox(height: 15),
            itemBuilder: (c, i) {
              return Container(
                decoration: BoxDecoration(
                  color: const Color(0xff53B1F5),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        listKittingCardQr[i],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    GestureDetector(
                      onTap: () {
                        cubit.removeKittingBarcode(i);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(1000),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.close,
                          color: Colors.red,
                          size: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
