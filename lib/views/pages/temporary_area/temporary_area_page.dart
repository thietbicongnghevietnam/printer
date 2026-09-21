import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smart_warehouse/gen/assets.gen.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';
import 'package:smart_warehouse/views/widgets/app_card.dart';

@RoutePage()
class TemporaryAreaPage extends StatelessWidget {
  const TemporaryAreaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(LocaleKeys.temporary_area_title).tr()),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          AppCard(
            title: LocaleKeys.temporary_area_input_location_title.tr(),
            image: Assets.images.inputLocation.image(width: 48, height: 48),
            onPressed: () => context.pushRoute(const InputLocationRoute()),
          ),
          AppCard(
            title: LocaleKeys.temporary_area_combine_pallet.tr(),
            image: Assets.images.moveReceivingCard.image(width: 48, height: 48),
            onPressed: () => context.pushRoute(const MoveReceivingCardRoute()),
          ),
          AppCard(
            title: LocaleKeys.temporary_area_out_receiving_card.tr(),
            image:
                Assets.images.icOutPallet.image(width: 48, height: 48),
            onPressed: () => context.pushRoute(const OutReceivingCardRoute()),
          ),
        ].withWidgetBetween(const SizedBox(height: 8)),
      ),
    );
  }
}
