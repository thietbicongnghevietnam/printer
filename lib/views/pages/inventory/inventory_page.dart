import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smart_warehouse/gen/assets.gen.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';
import 'package:smart_warehouse/views/widgets/app_card.dart';

@RoutePage()
class InventoryPage extends StatelessWidget {
  const InventoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inventory')),
      body: Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(12),
          physics: const ClampingScrollPhysics(),
          children: [
            AppCard(
              title: 'Balance All',
              image: Assets.images.icBalance.image(width: 48, height: 48),
              onPressed: () {
                context.pushRoute(const BalanceAllRoute());
              },
            ),
            AppCard(
              title: 'Balance ReceivingCard',
              image: Assets.images.icBalance.image(width: 48, height: 48),
              onPressed: () async {
                context.pushRoute(BalanceRcRoute());
              },
            ),
            AppCard(
              title: LocaleKeys.inventory_check_receiving_card_on_block.tr(),
              image: Assets.images.icFindLocation.image(width: 48, height: 48),
              onPressed: () {
                context.pushRoute(const CheckRcOnLocationRoute());
              },
            ),
          ].withWidgetBetween(const SizedBox(height: 8)),
        ),
      ),
    );
  }
}
