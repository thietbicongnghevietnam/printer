import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/flavor_settings.dart';

@module
abstract class FlavorModule {
  @preResolve
  Future<FlavorSettings> getFlavorSettings() async {
    final flavor =
        await const MethodChannel('flavor').invokeMethod<String>('getFlavor');

    return switch (flavor) {
      'staging' => FlavorSettings.staging(),
      'production' => FlavorSettings.production(),
      _ => FlavorSettings.development(),
    };
  }
}
