import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/enums/out_storage_type.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/extensions/duration_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/subsystem/pda/pda.dart';
import 'package:smart_warehouse/views/pages/storing/storing_widget/storage_receiving_item.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';
import 'package:smart_warehouse/views/widgets/app_radio.dart';

import 'out_storage_controller.dart';
import 'out_storage_state.dart';

@RoutePage()
class OutStoragePage extends BasePage<OutStorageController, OutStorageState> {
  const OutStoragePage({super.key});

  @override
  BasePageState createState() => _OutStoragePage();
}

class _OutStoragePage
    extends BasePageState<OutStorageController, OutStorageState> {
  late PdaDevice pdaDevice;

  @override
  void initState() {
    super.initState();
    context.read<OutStorageController>().initDataController();

    pdaDevice = getIt<PdaDevice>();
    pdaDevice.listen(context, (data) async {
      if (context
          .read<OutStorageController>()
          .receivingCardFocusNode
          .hasFocus) {
        context.read<OutStorageController>().addReceivingCard(data);
      }
      if (context.read<OutStorageController>().locationFocusNode.hasFocus) {
        context.read<OutStorageController>().locationController.text = data;
      }
      if (context.read<OutStorageController>().remarkFocusNode.hasFocus) {
        // context.read<OutStorageController>().remarkController.text = data;
      }
    });
  }

  @override
  void dispose() {
    context.read<OutStorageController>().dispose();

    pdaDevice.dispose();
    super.dispose();
  }

  @override
  Widget builder(context, cubit, state) {
    return MultiBlocListener(
      listeners: [
        BlocListener<OutStorageController, OutStorageState>(
          listenWhen: (prev, current) {
            return prev.currentReceivingCard != current.currentReceivingCard;
          },
          listener: (context, state) {
            ScaffoldMessenger.of(context).clearSnackBars();
            cubit.receivingCardController.text =
                state.currentReceivingCard?.material ?? '';
            cubit.remarkFocusNode.requestFocus();
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text(LocaleKeys.storing_move_out_storage).tr(),
        ),
        body: _buildBody(cubit),
        bottomNavigationBar: ElevatedButton(
          child: const Text(LocaleKeys.storing_move_out_storage).tr(),
          onPressed: () async {
            await cubit.moveOutReceivingCard();

            await Duration.zero.delay(() async {
              getIt<AppAlertDialog>().show(
                context,
                message: LocaleKeys.storing_move_out_storage_successful.tr(),
                onConfirm: () {
                  cubit.receivingCardController.clear();
                  cubit.remarkController.clear();
                  cubit.receivingCardFocusNode.requestFocus();

                  cubit.clearData();
                },
              );
            });
          },
        ).paddingSymmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  Widget _buildBody(OutStorageController cubit) {
    return BlocBuilder<OutStorageController, OutStorageState>(
      buildWhen: (prev, current) {
        return prev.currentReceivingCard != current.currentReceivingCard ||
            prev.outType != current.outType;
      },
      builder: (context, state) {
        return SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (state.outType == OutStorageType.oneByOne)
                Row(
                  children: [
                    SizedBox(
                      width: 80,
                      child: const Text(LocaleKeys.storing_re_card).tr(),
                    ),
                    Expanded(
                      child: AppFormField(
                        showCursor: true,
                        readOnly: true,
                        controller: cubit.receivingCardController,
                        focusNode: cubit.receivingCardFocusNode,
                        onChanged: cubit.addReceivingCard,
                      ),
                    ),
                  ],
                )
              else
                Row(
                  children: [
                    SizedBox(
                      width: 80,
                      child: const Text(LocaleKeys.storing_location).tr(),
                    ),
                    Expanded(
                      child: AppFormField(
                        showCursor: true,
                        controller: cubit.locationController,
                        focusNode: cubit.locationFocusNode,
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(
                    width: 80,
                    child: const Text(LocaleKeys.storing_remark).tr(),
                  ),
                  Expanded(
                    child: AppFormField(
                      showCursor: true,
                      controller: cubit.remarkController,
                      focusNode: cubit.remarkFocusNode,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              if (state.currentReceivingCard != null)
                _buildOutReCardItem(state),
            ],
          ),
        );
      },
    ).paddingAll(16);
  }

  Widget _buildOutReCardItem(OutStorageState state) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      LocaleKeys.storing_material,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ).tr(),
                    Expanded(
                      child: Text(
                        ': ${state.currentReceivingCard?.material}' ?? '',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Text(
                      LocaleKeys.storing_old_location,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ).tr(),
                    Expanded(
                      child: Text(
                        ': ${state.currentReceivingCard?.oldLocation}' ??
                            '',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Text(
                      LocaleKeys.storing_current_qty,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ).tr(),
                    Expanded(
                      child: Text(
                        ': ${state.currentReceivingCard?.currentQuantity}' ??
                            '',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                        ),
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
