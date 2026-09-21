import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:smart_warehouse/shared/resources/themes.dart';
import 'package:smart_warehouse/shared/router/router.dart';


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouter = AppRouter();

  @override
  void initState() {
    // WidgetsBinding.instance.addObserver(
    //   LifecycleEventHandler(
    //     resumeCallBack: () async {
    //       final lastTime =
    //           getIt<StorageManager>().get<DateTime>(StorageKeys.lastTime);
    //       if ((lastTime?.difference(DateTime.now()).inSeconds ?? 0).abs() >
    //           30) {
    //         await getIt<AuthRepository>().logout().whenComplete(() {
    //           _appRouter.replaceAll([const LoginRoute()]);
    //         });
    //       }
    //     },
    //     pauseCallBack: () async {
    //       getIt<StorageManager>().set(StorageKeys.lastTime, DateTime.now());
    //     },
    //   ),
    // );

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    super.initState();
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.dartTheme,
      themeMode: ThemeMode.light,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      routerConfig: _appRouter.config(),
    );
  }
}
