import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/extensions/duration_extensions.dart';
import 'package:smart_warehouse/shared/extensions/int_extensions.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:smart_warehouse/shared/extensions/table_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/subsystem/pda/pda.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';
import 'package:smart_warehouse/views/widgets/receiving_card_item_widget.dart';

import 'input_location_controller.dart';
import 'input_location_state.dart';

@RoutePage()
class InputLocationPage
    extends BasePage<InputLocationController, InputLocationState> {
  const InputLocationPage({super.key});

  @override
  BasePageState createState() => _InputLocationPageState();
}

class _InputLocationPageState
    extends BasePageState<InputLocationController, InputLocationState> {
  late TextEditingController _palletController;
  late TextEditingController _barcodeController;
  late ScrollController scrollController;

  late FocusNode palletFocusNode;
  late FocusNode barcodeFocusNode;

  late PdaDevice pdaDevice;

  @override
  void initState() {
    super.initState();

    _palletController = TextEditingController();
    _barcodeController = TextEditingController();
    scrollController = ScrollController();

    palletFocusNode = FocusNode()..requestFocus();
    barcodeFocusNode = FocusNode();

    pdaDevice = getIt<PdaDevice>();
    pdaDevice.listen(context, (data) {
      if (palletFocusNode.hasFocus) {
        context.read<InputLocationController>().updatePallet(data);
      } else if (barcodeFocusNode.hasFocus) {
        context.read<InputLocationController>().addReceivingCard(data);
      }
    });
  }

  @override
  void dispose() {
    _palletController.dispose();
    _barcodeController.dispose();
    pdaDevice.dispose();
    super.dispose();
  }

  @override
  Widget builder(context, cubit, state) {
    return MultiBlocListener(
      listeners: [
        BlocListener<InputLocationController, InputLocationState>(
          listenWhen: (prev, current) {
            return prev.palletData != current.palletData;
          },
          listener: (context, state) {
            ScaffoldMessenger.of(context).clearSnackBars();

            if (state.palletData.isNotEmpty()) {
              barcodeFocusNode.requestFocus();
            }
            _palletController.text = state.palletData ?? '';
          },
        ),
        BlocListener<InputLocationController, InputLocationState>(
          listenWhen: (prev, current) {
            return prev.receivingCardData != current.receivingCardData ||
                prev.listReceivingCard != current.listReceivingCard;
          },
          listener: (context, state) {
            ScaffoldMessenger.of(context).clearSnackBars();

            _barcodeController.text = state.receivingCardData ?? '';

            if (state.listReceivingCard.isNotEmpty) {
              200.milliseconds.delay(() {
                scrollController.animateTo(
                  scrollController.position.maxScrollExtent,
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.linear,
                );
              });
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title:
              const Text(LocaleKeys.temporary_area_input_location_title).tr(),
        ),
        body: Column(
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
                    const Text(LocaleKeys.temporary_area_pallet).tr(),
                    AppFormField(
                      showCursor: true,
                      readOnly: true,
                      controller: _palletController,
                      focusNode: palletFocusNode,
                      onChanged: cubit.updatePallet,
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Text(LocaleKeys.temporary_area_re_card).tr(),
                    AppFormField(
                      readOnly: true,
                      showCursor: true,
                      controller: _barcodeController,
                      focusNode: barcodeFocusNode,
                      onChanged: cubit.addReceivingCard,
                    ),
                  ],
                ),
              ].withSpaceBetween(8),
            ).paddingAll(16),
            Expanded(child: _buildBarcodeList(cubit)),
          ],
        ),
        bottomNavigationBar: ElevatedButton(
          onPressed: () async {
            await cubit.inputLocation();

            await Duration.zero.delay(() async {
              getIt<AppAlertDialog>().show(
                context,
                message: LocaleKeys.temporary_area_input_location_success.tr(),
                onConfirm: () {
                  cubit.clearData();
                  palletFocusNode.requestFocus();
                },
              );
            });
          },
          child:
              const Text(LocaleKeys.temporary_area_input_location_title).tr(),
        ).paddingSymmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  Widget _buildBarcodeList(InputLocationController cubit) {
    return BlocSelector<InputLocationController, InputLocationState,
        List<String>>(
      selector: (state) => state.listReceivingCard,
      builder: (context, listReceivingCard) {
        if (listReceivingCard.isEmpty) {
          return const SizedBox();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(LocaleKeys.temporary_area_barcode_added)
                .tr()
                .paddingSymmetric(horizontal: 16),
            const SizedBox(height: 15),
            Expanded(
              child: ListView.separated(
                controller: scrollController,
                shrinkWrap: true,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                addAutomaticKeepAlives: false,
                addRepaintBoundaries: false,
                itemCount: listReceivingCard.length,
                physics: const ClampingScrollPhysics(),
                separatorBuilder: (_, __) => const SizedBox(height: 15),
                itemBuilder: (context, index) {
                  return ReceivingCardItemWidget(
                    label: LocaleKeys.temporary_area_barcode,
                    reCardMaterial: listReceivingCard[index],
                    onRemoved: () async {
                      final res = cubit.removeBarcode(index);
                      if (res && mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Re-card has been removed'),
                            duration: Duration(milliseconds: 500),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
