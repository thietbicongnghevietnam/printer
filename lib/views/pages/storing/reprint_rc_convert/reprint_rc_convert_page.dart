import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/delivery_plan.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/enums/receving_card_type.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/extensions/duration_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/views/pages/storing/reprint_rc_convert/reprint_rc_convert_controller.dart';
import 'package:smart_warehouse/views/widgets/app_drop_down.dart';
import 'package:smart_warehouse/views/widgets/receiving_card_widget.dart';

import 'reprint_rc_convert_state.dart';

@RoutePage()
class RePrintRcConvertPage
    extends BasePage<RePrintRcConvertController, RePrintRcConvertState> {
  const RePrintRcConvertPage({
    super.key,
    required this.stockBarcode,
  });

  final String stockBarcode;

  @override
  RePrintRcConvertController buildCubit(BuildContext context) {
    return getIt<RePrintRcConvertController>()..stockBarcode = stockBarcode;
  }

  @override
  BasePageState createState() => _RePrintRcConvertPageState();
}

class _RePrintRcConvertPageState
    extends BasePageState<RePrintRcConvertController, RePrintRcConvertState> {

  @override
  Widget builder(context, cubit, state) {
    return Scaffold(
      appBar: AppBar(title: const Text('In lại RC Convert')),
      body: BlocBuilder<RePrintRcConvertController, RePrintRcConvertState>(
        buildWhen: (prev, current) {
          return prev.receivingCard != current.receivingCard;
        },
        builder: (context, state) {
          if (state.receivingCard == null) {
            return const Center(
              child: Text('Mã này chưa in RC Convert'),
            );
          }
          return Column(
            children: [
              SizedBox(
                height: 250,
                child: ReceivingCardWidget(
                  receivingCard: state.receivingCard!,
                  // rcType: ReceivingCardType.rcConvert,
                ),
              ),
              const SizedBox(height: 16),
              AppDropdown(
                hint: 'Chọn máy in',
                displayStringForOption: (option) => option.id,
                options: cubit.state.printerDevices,
                value: cubit.state.selectedPrinterDevice,
                onChange: cubit.changePrinterDevice,
              ),
            ],
          ).paddingAll(16);
        },
      ),
      bottomNavigationBar: Visibility(
        visible: cubit.state.receivingCard != null,
        child: ElevatedButton(
          onPressed: () async {
            await cubit.printReceivingCard();
            await Duration.zero.delay(() async {
              getIt<AppAlertDialog>().show(
                context,
                message: LocaleKeys.dialog_print_success.tr(),
              );
            });
          },
          child: const Text('Print RC Convert'),
        ).paddingSymmetric(horizontal: 16, vertical: 8),
      ),
    );
  }
}
