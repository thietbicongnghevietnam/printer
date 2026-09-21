import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smart_warehouse/entities/delivery_plan.dart';
import 'package:smart_warehouse/enums/delivery_type.dart';
import 'package:smart_warehouse/gen/assets.gen.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';
import 'package:smart_warehouse/views/widgets/app_card.dart';

@RoutePage()
class ReceivingPage extends StatelessWidget {
  const ReceivingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(LocaleKeys.receiving_title).tr()),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          AppCard(
            title: 'GR Have Barcode',
            image: Assets.images.grHaveBarcode.image(width: 48, height: 48),
            onPressed: () => context.pushRoute(GRHaveBarcodeRoute()),
          ),
          AppCard(
            title: 'GR No Barcode',
            image: Assets.images.grNoBarcode.image(width: 48, height: 48),
            onPressed: () {
              context.pushRoute<DeliveryPlan>(
                SelectDAInvoiceRoute(
                  deliveryPlanType: DeliveryPlanType.invoice,
                  onSelect: (deliveryPlan, material) {
                    context.popRoute();
                    if (deliveryPlan != null) {
                      final route = GRNoBarcodeRoute(
                        deliveryPlan: deliveryPlan,
                        material: material,
                      );
                      context.pushRoute(route);
                    }
                  },
                ),
              );
            },
          ),
          AppCard(
            title: 'Nhận hàng giao bù',
            image: Assets.images.icOffsetReceiving.image(width: 48, height: 48),
            onPressed: () {
              context.pushRoute<DeliveryPlan>(
                SelectDAInvoiceRoute(
                  deliveryPlanType: DeliveryPlanType.invoice,
                  onSelect: (deliveryPlan, material) {
                    context.popRoute();
                    if (deliveryPlan != null) {
                      final route = GRNoBarcodeRoute(
                        deliveryPlan: deliveryPlan,
                        material: material,
                        isOffsetGoods: true,
                      );
                      context.pushRoute(route);
                    }
                  },
                ),
              );
            },
          ),
          AppCard(
            title: 'Xem Receiving Card',
            image: Assets.images.viewReceivingCard.image(width: 48, height: 48),
            onPressed: () {
              context.pushRoute(const OpenGoodReceiptRoute());
            },
          ),
          AppCard(
            title: 'Xem DA/INV',
            image: Assets.images.viewDaInv.image(width: 48, height: 48),
            onPressed: () {
              context.pushRoute<DeliveryPlan>(
                SelectDAInvoiceRoute(
                  includeGoodReceipt: true,
                  onSelect: (deliveryPlan, _) async {
                    if (deliveryPlan != null) {
                      context.pushRoute(
                        DAInvoiceRoute(deliveryPlan: deliveryPlan),
                      );
                    }
                  },
                ),
              );
            },
          ),
          AppCard(
            title: 'In lại Receiving Card',
            image:
                Assets.images.reprintReceivingCard.image(width: 48, height: 48),
            onPressed: () {
              context.pushRoute(const ReprintReceivingCardRoute());
            },
          ),
          AppCard(
            title: 'Kiểm tra Barcode Thiếu',
            image: Assets.images.checkBarcode.image(width: 48, height: 48),
            onPressed: () => context.pushRoute(CheckBarcodeLackRoute()),
          ),
          AppCard(
            title: 'In lại Barcode NG',
            image: Assets.images.barcodeNg.image(width: 48, height: 48),
            onPressed: () => context.pushRoute(const ReprintBarcodeNGRoute()),
          ),
        ].withWidgetBetween(const SizedBox(height: 8)),
      ), // body: SingleChildScrollView(
    );
  }
}
