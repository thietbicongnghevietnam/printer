import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/extensions/duration_extensions.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:smart_warehouse/shared/extensions/table_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/subsystem/pda/pda.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';

import 'change_trolley_controller.dart';
import 'change_trolley_state.dart';

@RoutePage()
class ChangeTrolleyPage
    extends BasePage<ChangeTrolleyController, ChangeTrolleyState> {
  const ChangeTrolleyPage({super.key});

  @override
  BasePageState createState() => _ChangeTrolleyPageState();
}

class _ChangeTrolleyPageState
    extends BasePageState<ChangeTrolleyController, ChangeTrolleyState> {
  late TextEditingController trolleySourceController;
  late TextEditingController trolleyEndController;
  late TextEditingController kittingListControllerController;
  late ScrollController scrollController;

  late FocusNode trolleySourceFocusNode;
  late FocusNode trolleyEndFocusNode;
  late FocusNode kittingListFocusNode;

  late PdaDevice pdaDevice;

  @override
  void initState() {
    trolleySourceController = TextEditingController();
    trolleyEndController = TextEditingController();
    kittingListControllerController = TextEditingController();
    scrollController = ScrollController();

    trolleySourceFocusNode = FocusNode()..requestFocus();
    kittingListFocusNode = FocusNode();
    trolleyEndFocusNode = FocusNode();

    pdaDevice = getIt<PdaDevice>();
    pdaDevice.listen(context, (data) async {
      if (trolleySourceFocusNode.hasFocus) {
        context.read<ChangeTrolleyController>().updateTrolleySource(data);
      } else if (trolleyEndFocusNode.hasFocus) {
        context.read<ChangeTrolleyController>().updateTrolleyEnd(data);
      } else if (kittingListFocusNode.hasFocus) {
        context.read<ChangeTrolleyController>().scanKittingList(data);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    trolleySourceController.dispose();
    trolleyEndController.dispose();
    kittingListControllerController.dispose();
    trolleyEndFocusNode.dispose();
    trolleySourceFocusNode.dispose();
    kittingListFocusNode.dispose();
    scrollController.dispose();

    pdaDevice.dispose();
    super.dispose();
  }

  @override
  Widget builder(context, cubit, state) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ChangeTrolleyController, ChangeTrolleyState>(
          listenWhen: (prev, current) {
            return prev.trolleySource != current.trolleySource;
          },
          listener: (context, state) {
            ScaffoldMessenger.of(context).clearSnackBars();
            trolleySourceController.text = state.trolleySource ?? '';
            if (state.trolleySource.isNotEmpty()) {
              trolleyEndFocusNode.requestFocus();
            }
          },
        ),
        BlocListener<ChangeTrolleyController, ChangeTrolleyState>(
          listenWhen: (prev, current) {
            return prev.trolleyEnd != current.trolleyEnd;
          },
          listener: (context, state) {
            ScaffoldMessenger.of(context).clearSnackBars();
            trolleyEndController.text = state.trolleyEnd ?? '';
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text(LocaleKeys.kitting_change_trolley).tr(),
        ),
        body: _buildBody(cubit),
        bottomNavigationBar: ElevatedButton(
          child: const Text(LocaleKeys.kitting_change_trolley).tr(),
          onPressed: () async {
            await cubit.changeTrolley();

            await Duration.zero.delay(() async {
              getIt<AppAlertDialog>().show(
                context,
                message: LocaleKeys.kitting_change_trolley_success.tr(),
                onConfirm: () {
                  cubit.clearData();

                  trolleySourceFocusNode.requestFocus();
                },
              );
            });
          },
        ).paddingSymmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  Widget _buildBody(ChangeTrolleyController cubit) {
    return BlocBuilder<ChangeTrolleyController, ChangeTrolleyState>(
      buildWhen: (prev, current) {
        return prev.trolleySource != current.trolleySource ||
            prev.barCodeKittingList != current.barCodeKittingList;
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: const {
                0: FixedColumnWidth(80),
                1: FlexColumnWidth(),
              },
              children: [
                TableRow(
                  children: [
                    const Text(LocaleKeys.kitting_trolley_old).tr(),
                    AppFormField(
                      readOnly: true,
                      showCursor: true,
                      enabled: state.barCodeKittingList.isEmpty,
                      controller: trolleySourceController,
                      focusNode: trolleySourceFocusNode,
                      onChanged: cubit.updateTrolleySource,
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Text('KittingList Barcode'),
                    AppFormField(
                      showCursor: true,
                      readOnly: true,
                      enabled: state.trolleySource.isEmpty(),
                      controller: kittingListControllerController,
                      focusNode: kittingListFocusNode,
                      onChanged: cubit.scanKittingList,
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Text(LocaleKeys.kitting_trolley_new).tr(),
                    AppFormField(
                      showCursor: true,
                      readOnly: true,
                      controller: trolleyEndController,
                      focusNode: trolleyEndFocusNode,
                      onChanged: cubit.updateTrolleyEnd,
                    ),
                  ],
                ),
              ].withSpaceBetween(8),
            ),
            const SizedBox(height: 15),
            if (state.barCodeKittingList.isNotEmpty) ...[
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
                      text: ' ${state.barCodeKittingList.length}',
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 15,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              _buildBarcodeList(cubit),
            ],
          ],
        );
      },
    ).paddingAll(16);
  }

  Widget _buildBarcodeList(ChangeTrolleyController cubit) {
    return BlocSelector<ChangeTrolleyController, ChangeTrolleyState,
        List<String>>(
      selector: (state) => state.barCodeKittingList,
      builder: (context, barCodeKittingList) {
        return Expanded(
          child: ListView.separated(
            controller: scrollController,
            shrinkWrap: true,
            addAutomaticKeepAlives: false,
            addRepaintBoundaries: false,
            itemCount: barCodeKittingList.length,
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
                        barCodeKittingList[i],
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
