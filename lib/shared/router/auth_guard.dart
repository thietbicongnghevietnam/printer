import 'package:auto_route/auto_route.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';
import 'package:smart_warehouse/shared/utils/storage_manager.dart';

@AutoRouterConfig()
class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final authenticated =
        getIt<StorageManager>().get<String>(StorageKeys.accessToken);
    if (authenticated != null || resolver.route.name == LoginRoute.name) {
      resolver.next();
    } else {
      resolver.redirect(const LoginRoute());
    }
  }
}
