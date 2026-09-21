import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/barcode/barcode.dart';
import 'package:smart_warehouse/entities/barcode/local_barcode.dart';
import 'package:smart_warehouse/entities/receiving_card_item.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';
import 'package:smart_warehouse/subsystem/pda/pda.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';
import 'package:smart_warehouse/views/widgets/app_text.dart';

import 'check_barcode_lack_controller.dart';
import 'check_barcode_lack_state.dart';

@RoutePage()
class CheckBarcodeLackPage
    extends BasePage<CheckBarcodeLackController, CheckBarcodeLackState> {
  const CheckBarcodeLackPage({super.key, this.barcode, this.scanningBarcode});

  final Barcode? barcode;
  final List<ReceivingCardItem>? scanningBarcode;

  @override
  CheckBarcodeLackController buildCubit(BuildContext context) {
    return getIt<CheckBarcodeLackController>()
      ..barcode = barcode
      ..scanningBarcode = scanningBarcode;
  }

  @override
  BasePageState createState() => _CheckBarcodeLackPageState();
}

class _CheckBarcodeLackPageState
    extends BasePageState<CheckBarcodeLackController, CheckBarcodeLackState> {
  late TextEditingController barcodeController;
  late PdaDevice pdaDevice;

  @override
  void initState() {
    barcodeController = TextEditingController();
    pdaDevice = getIt<PdaDevice>();

    final barcode = widget.as<CheckBarcodeLackPage>()?.barcode;
    if(barcode != null) {
      barcodeController.text = barcode.barcode;
    }

    pdaDevice.listen(context, (data) async {
      if (context.router.current.name == CheckBarcodeLackRoute.name) {
        await context.read<CheckBarcodeLackController>().loadBarcode(data);
        barcodeController.text = data;
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
      appBar: AppBar(title: const Text('Kiểm tra Barcode thiếu')),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Row(
            children: [
              AppText.title('Barcode:'),
              const SizedBox(width: 8),
              Expanded(
                child: AppFormField(
                  autoFocus: true,
                  readOnly: true,
                  showCursor: true,
                  controller: barcodeController,
                ),
              ),
            ],
          ).paddingSymmetric(horizontal: 16),
          const SizedBox(height: 4),
          Expanded(
            child: BlocSelector<CheckBarcodeLackController,
                CheckBarcodeLackState, List<Barcode>>(
              selector: (state) => state.barcodes,
              builder: (context, barcodes) {
                if (barcodes.isEmpty) {
                  return const Text('Vui lòng quét barcode');
                }

                final firstBarcode = barcodes.first;

                return Column(
                  children: [
                    AppText.header('Material: ${firstBarcode.material}'),
                    const SizedBox(height: 4),
                    if (firstBarcode is LocalBarcode)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText.title(
                              '${firstBarcode.deliveryPlanType}: ${firstBarcode.deliveryPlan?.no}'),
                          AppText.title(
                              '${firstBarcode.deliveryPlanType} Item: ${firstBarcode.daItem}'),
                        ],
                      ).paddingSymmetric(horizontal: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AppText.title('PO: ${firstBarcode.po}'),
                        AppText.title('PO Item: ${firstBarcode.poItem}'),
                      ],
                    ).paddingSymmetric(horizontal: 16),
                    Expanded(
                      child: GridView.count(
                        padding: const EdgeInsets.all(16),
                        crossAxisCount: 3,
                        childAspectRatio: 3,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        children: barcodes.map((item) {
                          return Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: cubit.state.scannedBarcodes.any(
                                      (element) =>
                                          element.barcode == item.barcode)
                                  ? Colors.greenAccent
                                  : Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: const Offset(
                                    2,
                                    1,
                                  ), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Text('${item.unitNo}'),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
