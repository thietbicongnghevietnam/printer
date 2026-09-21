import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/enums/in_out_type.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/extensions/duration_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/subsystem/pda/pda.dart';
import 'package:smart_warehouse/views/pages/temporary_area/out_receiving_card/components/out_one_by_one_rc.dart';
import 'package:smart_warehouse/views/pages/temporary_area/out_receiving_card/components/out_pallet.dart';
import 'package:smart_warehouse/views/widgets/app_radio.dart';

import 'out_receiving_card_controller.dart';
import 'out_receiving_card_state.dart';

@RoutePage()
class OutReceivingCardPage
    extends BasePage<OutReceivingCardController, OutReceivingCardState> {
  const OutReceivingCardPage({super.key});

  @override
  BasePageState createState() => _OutReceivingCardPageState();
}

class _OutReceivingCardPageState
    extends BasePageState<OutReceivingCardController, OutReceivingCardState> {
  late TextEditingController palletController;
  late FocusNode palletFocusNode;
  late PdaDevice pdaDevice;

  @override
  void initState() {
    palletController = TextEditingController();
    palletFocusNode = FocusNode()..requestFocus();
    pdaDevice = getIt<PdaDevice>();
    final controller = context.read<OutReceivingCardController>();
    pdaDevice.listen(context, (data) async {
      if (controller.state.inOutType == InOutType.oneByOne) {
        context.read<OutReceivingCardController>().updateReceivingCard(data);
      } else {
        context.read<OutReceivingCardController>().updatePallet(data);
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
        title: const Text(LocaleKeys.temporary_area_out_receiving_card).tr(),
      ),
      body: _buildBody(cubit),
      bottomNavigationBar: ElevatedButton(
        child: const Text(LocaleKeys.temporary_area_out_receiving_card).tr(),
        onPressed: () async {
          await cubit.outTemporary();

          await Duration.zero.delay(() async {
            getIt<AppAlertDialog>().show(
              context,
              message:
                  LocaleKeys.temporary_area_out_receiving_card_successful.tr(),
              onConfirm: () => cubit.clearData(),
            );
          });
        },
      ).paddingSymmetric(horizontal: 16, vertical: 8),
    );
  }

  Widget _buildBody(OutReceivingCardController cubit) {
    return BlocSelector<OutReceivingCardController, OutReceivingCardState,
        InOutType>(
      selector: (state) => state.inOutType,
      builder: (context, inOutType) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppRadio(
                  title: InOutType.oneByOne.toString(),
                  value: InOutType.oneByOne,
                  groupValue: inOutType,
                  onChanged: cubit.updateInOutType,
                ),
                AppRadio(
                  title: InOutType.all.toString(),
                  value: InOutType.all,
                  groupValue: inOutType,
                  onChanged: cubit.updateInOutType,
                ),
              ],
            ),
            Visibility(
              visible: inOutType == InOutType.oneByOne,
              child: const OutOneByOneRC(),
            ),
            Visibility(
              visible: inOutType == InOutType.all,
              child: const Expanded(child: OutPallet()),
            ),
          ],
        );
      },
    ).paddingAll(16);
  }
}
