import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/enums/role.dart';
import 'package:smart_warehouse/flavor_settings.dart';
import 'package:smart_warehouse/gen/assets.gen.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/views/pages/home/components/home_item_widget.dart';
import 'package:smart_warehouse/views/pages/home/components/home_welcome_widget.dart';
import 'package:smart_warehouse/views/pages/home/home_controller.dart';
import 'package:smart_warehouse/views/pages/home/home_state.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class HomePage extends BasePage<HomeController, HomeState> {
  const HomePage({super.key});

  @override
  void handleError(
    BuildContext context,
    Object? error, [
    StackTrace? stackTrace,
  ]) {
    if (error is NewVersionError) {
      getIt<AppAlertDialog>().show(
        context,
        type: AppAlertType.confirm,
        message: error.message,
        confirmText: 'Cập nhật',
        onConfirm: () async {
          final baseUrl = getIt<FlavorSettings>().baseUrl;
          launchUrl(Uri.parse('$baseUrl/app/downloadfile'));
        },
      );
    } else {
      return super.handleError(context, error, stackTrace);
    }
  }

  @override
  Widget builder(context, cubit, state) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              HomeWelcomeWidget(
                userId: state.userId,
                onLogout: () {
                  cubit.logout().whenComplete(() {
                    context.router.replaceAll([const LoginRoute()]);
                  });
                },
              ),
              const SizedBox(height: 10),
              GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 15 / 14,
                ),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  HomeItemWidget(
                    title: LocaleKeys.home_receiving.tr(),
                    image:
                        Assets.images.goodReceipt.image(width: 70, height: 70),
                    onPressed: () {
                      if (!state.roles.contains(Role.receiving)) {
                        _showNotPermission(context);
                        return;
                      }

                      context.pushRoute(const ReceivingRoute());
                    },
                  ),
                  HomeItemWidget(
                    title: LocaleKeys.home_temporary_area.tr(),
                    image: Assets.images.temporaryArea
                        .image(width: 70, height: 70),
                    onPressed: () {
                      if (!state.roles.contains(Role.receiving)) {
                        _showNotPermission(context);
                        return;
                      }
                      context.pushRoute(const TemporaryAreaRoute());
                    },
                  ),
                  HomeItemWidget(
                    title: LocaleKeys.home_storage.tr(),
                    image: Assets.images.storage.image(width: 70, height: 70),
                    onPressed: () {
                      if (!state.roles.contains(Role.storage)) {
                        _showNotPermission(context);
                        return;
                      }
                      context.pushRoute(const StoringRoute());
                    },
                  ),
                  HomeItemWidget(
                    title: LocaleKeys.home_kitting.tr(),
                    image: Assets.images.kitting.image(width: 70, height: 70),
                    onPressed: () {
                      if (!state.roles.contains(Role.kitting)) {
                        _showNotPermission(context);
                        return;
                      }
                      context.pushRoute(const KittingIndexRoute());
                    },
                  ),
                  HomeItemWidget(
                    title: 'Inventory',
                    image:
                        Assets.images.icInventory.image(width: 70, height: 70),
                    onPressed: () {
                      if (!state.roles.contains(Role.inventory)) {
                        _showNotPermission(context);
                        return;
                      }
                      context.pushRoute(const InventoryRoute());
                    },
                  ),
                  HomeItemWidget(
                    title: 'One For All',
                    image:
                        Assets.images.icOneForAll.image(width: 70, height: 70),
                    onPressed: () {
                      context.pushRoute(const OneForAllRoute());
                    },
                  ),
                  // ===== THÊM ITEM MỚI Ở ĐÂY =====
                  HomeItemWidget(
                    title: 'IQC',
                    image: Assets.images.icInventory.image(width: 70, height: 70), // thay icon sau
                    onPressed: () {
                      context.pushRoute(const IQCMenuRoute());
                    },
                  ),

                ],
              ),
            ],
          ).paddingAll(16),
        ),
      ),
    );
  }

  void _showNotPermission(BuildContext context) {
    getIt<AppAlertDialog>().show(context,
        type: AppAlertType.error, message: 'Bạn không có quyền vào màn này');
  }

  void _showNotYetDevelopDialog(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text(LocaleKeys.dialog_the_feature_is_developing).tr(),
      ),
    );
  }
}
