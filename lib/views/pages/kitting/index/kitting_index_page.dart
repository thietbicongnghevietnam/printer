import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/enums/kitting_type.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';
import 'package:smart_warehouse/shared/utils/storage_manager.dart';
import 'package:smart_warehouse/views/widgets/app_card.dart';
import 'package:smart_warehouse/views/widgets/app_expandable.dart';

import '../../../../gen/assets.gen.dart';

@RoutePage()
class KittingIndexPage extends StatefulWidget {
  const KittingIndexPage({super.key});

  @override
  State<KittingIndexPage> createState() => _KittingPageState();
}

class _KittingPageState extends State<KittingIndexPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    final storageManager = getIt<StorageManager>();
    final kittingIndex = storageManager.get<int>(StorageKeys.kittingIndex);
    _tabController = TabController(length: 5, vsync: this, initialIndex: kittingIndex ?? 0);

    _tabController.addListener(() {
      storageManager.set(StorageKeys.kittingIndex, _tabController.index);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kitting'),
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'FA'),
            Tab(text: 'DIP'),
            Tab(text: 'Subcon'),
            Tab(text: 'Outside'),
            Tab(text: 'Model'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildListView(context),
          _buildListView(context),
          _buildListView(context),
          _buildListView(context),
          _buildListView(context),
        ],
      ),
    );
  }

  ListView _buildListView(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: [
        AppCard(
          title: 'Kitting',
          image: Assets.images.kittingMaterial.image(width: 48, height: 48),
          onPressed: () {
            switch (_tabController.index) {
              case 0:
                context.pushRoute(
                    KittingRoute(kittingType: KittingType.fa));
              case 1:
                context.pushRoute(
                    KittingRoute(kittingType: KittingType.dip));
              case 2:
                context.pushRoute(
                    KittingRoute(kittingType: KittingType.subcon));
              case 3:
                context.pushRoute(
                    KittingRoute(kittingType: KittingType.outside));
              case 4:
                context.pushRoute(const KittingModelRoute());
            }
          },
        ),
        AppExpandable(
          buildHeader: (controller, isExpand) {
            return AppCard(
              title: 'Kitting Trolley',
              image:
              Assets.images.moveReceivingCard.image(width: 48, height: 48),
              trailing: Icon(
                isExpand ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
              ),
              onPressed: () =>
              isExpand ? controller.collapse() : controller.expand(),
            );
          },
          buildContent: (controller, isExpand) {
            return [
              AppCard(
                title: LocaleKeys.kitting_input_trolley.tr(),
                image: Assets.images.moveReceivingCard
                    .image(width: 48, height: 48),
                onPressed: () {
                  context.pushRoute(const InputTrolleyRoute());
                },
              ),
              AppCard(
                title: LocaleKeys.kitting_change_trolley.tr(),
                image:
                Assets.images.icCombinePallet.image(width: 48, height: 48),
                onPressed: () {
                  context.pushRoute(const ChangeTrolleyRoute());
                },
              ),
              AppCard(
                title: LocaleKeys.kitting_out_trolley.tr(),
                image: Assets.images.icOutTemp.image(width: 48, height: 48),
                onPressed: () {
                  context.pushRoute(const OutTrolleyRoute());
                },
              ),
            ];
          },
        ),
        AppCard(
          title: 'Find Kitting List',
          image: Assets.images.icSearch.image(width: 48, height: 48),
          onPressed: () {
            context.pushRoute(const FindKittingListRoute());
          },
        ),
        AppCard(
          title: 'Check List Kitting',
          image: Assets.images.checkKitting.image(width: 48, height: 48),
          onPressed: () {
            context.pushRoute(const CheckListKittingDetailRoute());
          },
        ),
        AppCard(
          title: 'Supply',
          image: Assets.images.icSupply.image(width: 48, height: 48),
          onPressed: () {
            context.pushRoute(
              SupplyKittingRoute(
                kittingType: _tabController.index < 4
                    ? KittingType.fromCode(_tabController.index)
                    : null,
              ),
            );
          },
        ),
        AppCard(
          title: 'Revert Kitting',
          image: Assets.images.icRevert.image(width: 48, height: 48),
          onPressed: () {
            context.pushRoute(const RevertKittingRoute());
          },
        ),
        AppCard(
          title: 'Return Kitting',
          image: Assets.images.icReturnKitting.image(width: 48, height: 48),
          onPressed: () {
            context.pushRoute(const ReturnKittingRoute());
          },
        ),
      ].withWidgetBetween(const SizedBox(height: 8)),
    );
  }
}
