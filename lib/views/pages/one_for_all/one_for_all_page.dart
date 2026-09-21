import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/barcode/barcode.dart';
import 'package:smart_warehouse/entities/kitting/kitting_card.dart';
import 'package:smart_warehouse/entities/kitting_card.dart';
import 'package:smart_warehouse/entities/qr_card.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';
import 'package:smart_warehouse/subsystem/pda/pda.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';
import 'package:smart_warehouse/views/widgets/app_text.dart';
import 'package:smart_warehouse/views/widgets/barcode_widget.dart';
import 'package:smart_warehouse/views/widgets/kitting_card_widget.dart';
import 'package:smart_warehouse/views/widgets/receiving_card_widget.dart';

import 'one_for_all_controller.dart';
import 'one_for_all_state.dart';

@RoutePage()
class OneForAllPage extends BasePage<OneForAllController, OneForAllState> {
  const OneForAllPage({super.key});

  @override
  BasePageState createState() => _OneForAllPageState();
}

class _OneForAllPageState
    extends BasePageState<OneForAllController, OneForAllState> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    final cubit = context.read<OneForAllController>();

    getIt<PdaDevice>().listen(context, (data) async {
      logger.d('Barcode: $data');
      await cubit.scanCard(data);
      _controller.text = data;
    });
    super.initState();
  }

  @override
  Widget builder(context, cubit, state) {
    return Scaffold(
      appBar: AppBar(title: const Text('One For All')),
      body: Column(
        children: [
          Row(
            children: [
              const Text('Code: '),
              const SizedBox(width: 8),
              Expanded(
                child: AppFormField(
                  readOnly: true,
                  autoFocus: true,
                  controller: _controller,
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: 16, vertical: 8),
          const Divider(),
          BlocSelector<OneForAllController, OneForAllState, QRCard?>(
            selector: (state) => state.qrCard,
            builder: (context, qrCard) {
              if (qrCard == null) {
                return AppText.header('Quét mọi thứ bạn thích');
              }

              return Column(
                children: [
                  AppText.header(qrCard.runtimeType.toString()),
                  const SizedBox(height: 12),
                  Center(
                    child: switch (qrCard) {
                      ReceivingCard() => Column(
                          children: [
                            ReceivingCardWidget(receivingCard: qrCard),
                            const SizedBox(height: 16),
                            if (qrCard.location == null)
                              AppText.title('Receiving Card chưa được lưu kho')
                            else
                              AppText.title('Vị trí: ${qrCard.location}'),
                          ],
                        ),
                      Barcode() => BarcodeWidget(barcode: qrCard),
                      KittingCard() => KittingCardWidget(
                          kittingCard: qrCard,
                        ),
                      _ => AppText(qrCard.barcode)
                    },
                  ).paddingSymmetric(horizontal: 16)
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
