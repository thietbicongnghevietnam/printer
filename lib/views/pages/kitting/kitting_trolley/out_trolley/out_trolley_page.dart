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
import 'package:smart_warehouse/views/widgets/app_form_field.dart';
import 'package:smart_warehouse/views/widgets/app_text.dart';

import 'out_trolley_controller.dart';
import 'out_trolley_state.dart';

@RoutePage()
class OutTrolleyPage extends BasePage<OutTrolleyController, OutTrolleyState> {
  const OutTrolleyPage({super.key});

  @override
  BasePageState createState() => _OutTrolleyPageState();
}

class _OutTrolleyPageState
    extends BasePageState<OutTrolleyController, OutTrolleyState> {
  late TextEditingController barcode;

  late FocusNode barcodeFocusNode;

  late PdaDevice pdaDevice;

  @override
  void initState() {
    super.initState();
    barcode = TextEditingController();

    barcodeFocusNode = FocusNode()..requestFocus();

    pdaDevice = getIt<PdaDevice>();
    pdaDevice.listen(context, (data) async {
      if (barcodeFocusNode.hasFocus) {
        context.read<OutTrolleyController>().inputBarcode(data);
      }
    });

  }

  @override
  void dispose() {
    barcode.dispose();

    pdaDevice.dispose();
    super.dispose();
  }

  @override
  Widget builder(context, cubit, state) {
    return MultiBlocListener(
      listeners: [
        BlocListener<OutTrolleyController, OutTrolleyState>(
          listenWhen: (prev, current) {
            return prev.trolleyBarcode != current.trolleyBarcode;
          },
          listener: (context, state) {
            ScaffoldMessenger.of(context).clearSnackBars();
            barcode.text = state.trolleyBarcode ?? '';
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Text(LocaleKeys.kitting_out_trolley).tr(),
        ),
        body: _buildBody(cubit),
        bottomNavigationBar: ElevatedButton(
          child: const Text(LocaleKeys.kitting_out_trolley).tr(),
          onPressed: () async {
            await cubit.outTrolley();

            await Duration.zero.delay(() async {
              getIt<AppAlertDialog>().show(
                context,
                message: LocaleKeys.kitting_out_trolley_success.tr(),
                onConfirm: () => cubit.clearData(),
              );
            });
          },
        ).paddingSymmetric(horizontal: 16, vertical: 8),
      ),
    );
  }

  Widget _buildBody(OutTrolleyController cubit) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: AppFormField(
                showCursor: true,
                readOnly: true,
                controller: barcode,
                focusNode: barcodeFocusNode,
                onChanged: cubit.inputBarcode,
              ),
            ),
          ],
        ).paddingAll(16),
        const Divider(),
        AppText.title('Vui lòng quét Trolley hoặc Kitting List')
      ],
    );
  }
}
