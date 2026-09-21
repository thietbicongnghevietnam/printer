import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/enums/in_out_type.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/extensions/duration_extensions.dart';
import 'package:smart_warehouse/shared/extensions/int_extensions.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:smart_warehouse/shared/extensions/table_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';
import 'package:smart_warehouse/subsystem/pda/pda.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';
import 'package:smart_warehouse/views/widgets/app_radio.dart';
import 'package:smart_warehouse/views/widgets/receiving_card_item_widget.dart';

import 'move_receiving_card_controller.dart';
import 'move_receiving_card_state.dart';

@RoutePage()
class MoveReceivingCardPage
    extends BasePage<MoveReceivingCardController, MoveReceivingCardState> {
  const MoveReceivingCardPage({super.key});

  @override
  BasePageState createState() => _CombinePalletPageState();
}

class _CombinePalletPageState
    extends BasePageState<MoveReceivingCardController, MoveReceivingCardState> {
  late TextEditingController palletSourceController;
  late TextEditingController receivingCardController;
  late TextEditingController palletEndController;
  late ScrollController scrollController;

  late FocusNode receivingCardFocusNode;
  late FocusNode palletSourceFocusNode;
  late FocusNode palletEndFocusNode;

  late PdaDevice pdaDevice;

  @override
  void initState() {
    palletSourceController = TextEditingController();
    receivingCardController = TextEditingController();
    palletEndController = TextEditingController();
    scrollController = ScrollController();

    receivingCardFocusNode = FocusNode()..requestFocus();
    palletSourceFocusNode = FocusNode();
    palletEndFocusNode = FocusNode();

    pdaDevice = getIt<PdaDevice>();
    pdaDevice.listen(context, (data) async {
      if (receivingCardFocusNode.hasFocus) {
        context.read<MoveReceivingCardController>().addReceivingCard(data);
      } else if (palletSourceFocusNode.hasFocus) {
        context.read<MoveReceivingCardController>().updatePalletSource(data);
      } else if (palletEndFocusNode.hasFocus) {
        context.read<MoveReceivingCardController>().updatePalletEnd(data);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    palletSourceController.dispose();
    receivingCardController.dispose();
    palletEndController.dispose();
    scrollController.dispose();

    pdaDevice.dispose();
    super.dispose();
  }

  @override
  Widget builder(context, cubit, state) {
    return MultiBlocListener(
      listeners: [
        BlocListener<MoveReceivingCardController, MoveReceivingCardState>(
          listenWhen: (prev, current) {
            return prev.listReceivingCards != current.listReceivingCards ||
                prev.currentReceivingCard != current.currentReceivingCard;
          },
          listener: (context, state) {
            ScaffoldMessenger.of(context).clearSnackBars();
            receivingCardController.text = state.currentReceivingCard ?? '';
            palletSourceController.text = state.palletSource ?? '';
            if (state.listReceivingCards.isNotEmpty) {
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
        BlocListener<MoveReceivingCardController, MoveReceivingCardState>(
          listenWhen: (prev, current) {
            return prev.palletSource != current.palletSource;
          },
          listener: (context, state) {
            ScaffoldMessenger.of(context).clearSnackBars();
            palletSourceController.text = state.palletSource ?? '';
            if (state.inOutType == InOutType.all &&
                state.palletSource.isNotEmpty()) {
              palletEndFocusNode.requestFocus();
            }
          },
        ),
        BlocListener<MoveReceivingCardController, MoveReceivingCardState>(
          listenWhen: (prev, current) {
            return prev.palletEnd != current.palletEnd;
          },
          listener: (context, state) {
            ScaffoldMessenger.of(context).clearSnackBars();
            palletEndController.text = state.palletEnd ?? '';
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text(LocaleKeys.temporary_area_combine_pallet).tr(),
        ),
        body: _buildBody(cubit),
        bottomNavigationBar: ElevatedButton(
          child: const Text(LocaleKeys.temporary_area_combine_pallet).tr(),
          onPressed: () async {
            await cubit.combinePallet();

            await Duration.zero.delay(() async {
              getIt<AppAlertDialog>().show(
                context,
                message: 'Move Receiving Card thành công',
                onConfirm: () {
                  cubit.clearData();

                  if (cubit.state.inOutType == InOutType.oneByOne) {
                    receivingCardFocusNode.requestFocus();
                  } else {
                    palletSourceFocusNode.requestFocus();
                  }
                },
              );
            });
          },
        ).paddingSymmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  Widget _buildBody(MoveReceivingCardController cubit) {
    return BlocConsumer<MoveReceivingCardController, MoveReceivingCardState>(
      listenWhen: (prev, current) {
        return prev.inOutType != current.inOutType;
      },
      listener: (context, state) {
        if (palletEndFocusNode.hasFocus) {
          return;
        }

        100.milliseconds.delay(() {
          switch (state.inOutType) {
            case InOutType.oneByOne:
              receivingCardFocusNode.requestFocus();
            case InOutType.all:
              palletSourceFocusNode.requestFocus();
          }
        });
      },
      buildWhen: (prev, current) => prev.inOutType != current.inOutType,
      builder: (context, state) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppRadio(
                  title: InOutType.oneByOne.toString(),
                  value: InOutType.oneByOne,
                  groupValue: state.inOutType,
                  onChanged: cubit.updateInOutType,
                ),
                AppRadio(
                  title: InOutType.all.toString(),
                  value: InOutType.all,
                  groupValue: state.inOutType,
                  onChanged: cubit.updateInOutType,
                ),
              ],
            ),
            Table(
              defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              columnWidths: const {
                0: FixedColumnWidth(80),
                1: FlexColumnWidth(),
              },
              children: [
                TableRow(
                  children: [
                    Visibility(
                      visible: state.inOutType == InOutType.oneByOne,
                      child: const Text(LocaleKeys.temporary_area_re_card).tr(),
                    ),
                    Visibility(
                      visible: state.inOutType == InOutType.oneByOne,
                      maintainState: true,
                      child: AppFormField(
                        readOnly: true,
                        showCursor: true,
                        controller: receivingCardController,
                        focusNode: receivingCardFocusNode,
                        enabled: state.inOutType == InOutType.oneByOne,
                        onChanged: cubit.addReceivingCard,
                      ),
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Text(LocaleKeys.temporary_area_pl_source).tr(),
                    AppFormField(
                      showCursor: state.inOutType == InOutType.all,
                      readOnly: true,
                      controller: palletSourceController,
                      focusNode: palletSourceFocusNode,
                      enabled: state.inOutType == InOutType.all,
                      onChanged: cubit.updatePalletSource,
                    ),
                  ],
                ),
                TableRow(
                  children: [
                    const Text(LocaleKeys.temporary_area_pl_end).tr(),
                    AppFormField(
                      showCursor: true,
                      readOnly: true,
                      controller: palletEndController,
                      focusNode: palletEndFocusNode,
                      onChanged: cubit.updatePalletEnd,
                    ),
                  ],
                ),
              ].withSpaceBetween(8),
            ),
            if (state.inOutType == InOutType.oneByOne)
              Expanded(
                child: BlocSelector<MoveReceivingCardController,
                    MoveReceivingCardState, List<ReceivingCard>>(
                  selector: (state) => state.listReceivingCards,
                  builder: (context, listReceivingCards) {
                    return Visibility(
                      visible: listReceivingCards.isNotEmpty,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          const Text(
                            LocaleKeys.temporary_area_receiving_card_added,
                          ).tr(),
                          const SizedBox(height: 15),
                          Expanded(child: _buildReCardList(cubit)),
                        ],
                      ),
                    );
                  },
                ),
              ),
          ],
        );
      },
    ).paddingAll(16);
  }

  Widget _buildReCardList(MoveReceivingCardController cubit) {
    return BlocBuilder<MoveReceivingCardController, MoveReceivingCardState>(
      buildWhen: (prev, current) {
        return prev.listReceivingCards != current.listReceivingCards ||
            prev.currentReceivingCard != current.currentReceivingCard;
      },
      builder: (context, state) {
        return Expanded(
          child: ListView.separated(
            controller: scrollController,
            addRepaintBoundaries: false,
            addAutomaticKeepAlives: false,
            shrinkWrap: true,
            itemCount: state.listReceivingCards.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return ReceivingCardItemWidget(
                label: LocaleKeys.temporary_area_re_card,
                reCardMaterial: state.listReceivingCards[index].barcode ?? '',
                onRemoved: () async {
                  final res = await cubit.removeReceivingCard(index);
                  if (res && mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Receiving card has been removed'),
                        duration: Duration(milliseconds: 500),
                      ),
                    );
                  }
                },
              );
            },
            separatorBuilder: (context, index) => const SizedBox(height: 15),
          ),
        );
      },
    );
  }
}
