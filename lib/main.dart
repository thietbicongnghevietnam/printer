import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:easy_logger/easy_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:smart_warehouse/app.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/draft_receiving_card.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/utils/bloc_observer.dart';
import 'package:smart_warehouse/shared/utils/camera_manager.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';
import 'package:smart_warehouse/shared/utils/receiving_card_adapter.dart';
import 'package:smart_warehouse/subsystem/pda/pda.dart';

import 'shared/utils/map_asset_icons.dart';

void main() {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
    Bloc.observer = AppObserver();
    EasyLocalization.logger.enableLevels = [
      LevelMessages.error,
      LevelMessages.warning,
    ];
    await configureDependencies();
    await getIt<CameraManager>().initCamera();
    await getIt<PdaDevice>().initialize();
    await getIt<MapAssetIcons>().initialLocalIcon();
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
    Hive.registerAdapter(DraftReceivingCardAdapter());
    await Hive.openBox<DraftReceivingCard>('draft_receiving_card');
    runApp(
      EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('vi')],
        path: 'assets/translations',
        fallbackLocale: const Locale('vi'),
        child: const MyApp(),
      ),
    );
  }, (error, stackTrace) {
    if (error is ErrorEntity && error is! NullPointerErrorEntity) {
      loggerNoStack.e('${error.runtimeType}: ${error.message}');
    } else {
      logger.e('$error $stackTrace');
    }
  });
}
