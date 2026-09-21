import 'dart:ui';

import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/enums/storage_scan_recard_error.dart';
import 'package:smart_warehouse/gen/assets.gen.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/extensions/duration_extensions.dart';
import 'package:smart_warehouse/shared/extensions/int_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/subsystem/pda/pda.dart';
import 'package:smart_warehouse/views/dialogs/receiving_card_dialog.dart';
import 'package:smart_warehouse/views/pages/storing/storing_widget/storage_receiving_item.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';

import 'check_rc_on_location_controller.dart';
import 'check_rc_on_location_state.dart';

@RoutePage()
class CheckRcOnLocationPage
    extends BasePage<CheckRcOnLocationController, CheckRcOnLocationState> {
  const CheckRcOnLocationPage({
    super.key,
  });

  @override
  BasePageState createState() => _CheckRcOnLocationPageState();
}

class _CheckRcOnLocationPageState
    extends BasePageState<CheckRcOnLocationController, CheckRcOnLocationState> {
  late TextEditingController locationController;
  late ScrollController scrollController;

  late FocusNode locationFocusNode;
  late PdaDevice pdaDevice;

  @override
  void initState() {
    super.initState();

    locationController = TextEditingController();
    scrollController = ScrollController();

    locationFocusNode = FocusNode()..requestFocus();

    pdaDevice = getIt<PdaDevice>();
    pdaDevice.listen(context, (data) async {
      if (locationFocusNode.hasFocus) {
        context.read<CheckRcOnLocationController>().scanBlock(data);
        locationController.text = data;
      }
    });
  }

  @override
  void dispose() {
    locationController.dispose();
    scrollController.dispose();

    pdaDevice.dispose();
    super.dispose();
  }

  @override
  Widget builder(context, cubit, state) {
    return MultiBlocListener(
        listeners: [
          BlocListener<CheckRcOnLocationController, CheckRcOnLocationState>(
            listenWhen: (prev, current) {
              return prev.listReCard != current.listReCard;
            },
            listener: (context, state) {
              ScaffoldMessenger.of(context).clearSnackBars();
              locationFocusNode.requestFocus();
            },
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title:
                const Text(LocaleKeys.inventory_check_receiving_card_on_block)
                    .tr(),
          ),
          body: _buildBody(cubit),
        ));
  }

  Widget _buildBody(CheckRcOnLocationController cubit) {
    return BlocBuilder<CheckRcOnLocationController, CheckRcOnLocationState>(
      buildWhen: (prev, current) {
        return prev.listReCard != current.listReCard;
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLocationTextField(cubit).paddingSymmetric(
              horizontal: 16,
              vertical: 8,
            ),
            if (state.listReCard.isNotEmpty) ...[
              Text('Tổng số lượng ReceivingCard: ${state.listReCard.length}')
                  .paddingSymmetric(
                horizontal: 16,
                vertical: 8,
              ),
              _buildReCardList(cubit),
            ],
          ],
        );
      },
    );
  }

  Widget _buildLocationTextField(CheckRcOnLocationController cubit) {
    return Row(
      children: [
        SizedBox(
          width: 70,
          child: const Text(LocaleKeys.inventory_barcode_block).tr(),
        ),
        Flexible(
          flex: 2,
          child: AppFormField(
            showCursor: true,
            readOnly: true,
            controller: locationController,
            focusNode: locationFocusNode,
            onChanged: cubit.scanBlock,
          ),
        ),
      ],
    );
  }

  Widget _buildReCardList(CheckRcOnLocationController cubit) {
    return BlocBuilder<CheckRcOnLocationController, CheckRcOnLocationState>(
      buildWhen: (prev, current) {
        return prev.listReCard != current.listReCard;
      },
      builder: (context, state) {
        return Expanded(
          child: ListView.separated(
            controller: scrollController,
            addRepaintBoundaries: false,
            addAutomaticKeepAlives: false,
            shrinkWrap: true,
            itemCount: state.listReCard.length,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            physics: const ClampingScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () async {
                  await Duration.zero.delay(() async {
                    await showReceivingCardDialog(
                      context,
                      dialogTitle: 'Balance Receiving Card',
                      receivingCard: state.listReCard[index],
                      onConfirm: (printer) async {},
                      onOkTap: () {
                        context.pushRoute(BalanceRcRoute(
                            rcBarcode: state.listReCard[index].barcode));
                      },
                      printerDevices: cubit.printerDevices ?? [],
                      previousPrinterDevice: cubit.savePrinterDevice,
                      showSelectPrint: false,
                      buttonTitle: 'Open BalanceRC',
                    );
                  });
                },
                child: StorageReceivingItem(
                  reCardData: state.listReCard[index],
                  hasRemove: false,
                  fromBalance: true,
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(height: 15);
            },
          ),
        );
      },
    );
  }
}
