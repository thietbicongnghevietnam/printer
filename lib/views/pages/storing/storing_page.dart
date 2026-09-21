import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smart_warehouse/gen/assets.gen.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';
import 'package:smart_warehouse/views/widgets/app_card.dart';

@RoutePage()
class StoringPage extends StatelessWidget {
  const StoringPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(LocaleKeys.storing_storage).tr()),
      body: ListView(
        padding: const EdgeInsets.all(12),
        physics: const ClampingScrollPhysics(),
        children: [
          AppCard(
            title: LocaleKeys.storing_storing_receiving.tr(),
            image: Assets.images.icStorageItem.image(width: 48, height: 48),
            onPressed: () {
              context.pushRoute(StorageRCCardRoute());
            },
          ),
          AppCard(
            title: LocaleKeys.storing_check_material_in_store.tr(),
            image:
                Assets.images.icProductInformation.image(width: 48, height: 48),
            onPressed: () {
              context.pushRoute(CheckMaterialInStoreRoute());
            },
          ),
          AppCard(
            title: LocaleKeys.storing_change_store_location.tr(),
            image: Assets.images.icChangeLocation.image(width: 48, height: 48),
            onPressed: () {
              context.pushRoute(const ChangeStoreLocationRoute());
            },
          ),
          AppCard(
            title: LocaleKeys.storing_move_out_storage.tr(),
            image: Assets.images.icRevert.image(width: 48, height: 48),
            onPressed: () {
              context.pushRoute(const OutStorageRoute());
            },
          ),
          AppCard(
            title: LocaleKeys.storing_split_receiving_card.tr(),
            image: Assets.images.icSplitRcCard.image(width: 48, height: 48),
            onPressed: () {
              context.pushRoute(const SplitReceivingRoute());
            },
          ),
          AppCard(
            title: LocaleKeys.storing_iqc_borrow_receiving_card.tr(),
            image: Assets.images.icIqcBorrowRc.image(width: 48, height: 48),
            onPressed: () {
              context.pushRoute(const IQCBorrowReceivingCardRoute());
            },
          ),
          AppCard(
            title: LocaleKeys.storing_find_boxcard_lost.tr(),
            image:
            Assets.images.icFindBarcodeLost.image(width: 48, height: 48),
            onPressed: () {
              context.pushRoute(const FindBarcodeLostRoute());
            },
          ),
          AppCard(
            title: LocaleKeys.storing_stock_to_receiving_card.tr(),
            image:
            Assets.images.icStockToReceiving.image(width: 48, height: 48),
            onPressed: () {
              context.pushRoute(const StockToReceivingCardRoute());
            },
          ),
          AppCard(
            title: LocaleKeys.storing_storing_jupiter.tr(),
            image: Assets.images.icJupiter.image(width: 48, height: 48),
            onPressed: () {
              context.pushRoute(const StorageJupiterRoute());
            },
          ),
          AppCard(
            title: LocaleKeys.storing_borrow_goods_list.tr(),
            image: Assets.images.icBorrowGoodsList.image(width: 48, height: 48),
            onPressed: () {
              context.pushRoute(const ListBorrowItemRoute());
            },
          ),
          // AppCard(
          //   title: 'Check Map',
          //   image:
          //       Assets.images.icStockToReceiving.image(width: 48, height: 48),
          //   onPressed: () {
          //     context.pushRoute(TrolleyMapHTMLRoute(
          //         trolleyCode: 'trolleyCode', kittingListId: 1));
          //   },
          // ),
        ].withWidgetBetween(const SizedBox(height: 8)),
      ),
    );
  }
}
