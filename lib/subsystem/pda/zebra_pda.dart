import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_datawedge/flutter_datawedge.dart';
import 'package:flutter_datawedge/models/scan_result.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';
import 'package:smart_warehouse/subsystem/pda/pda.dart';

@Injectable(as: PdaDevice)
class ZebraPda implements PdaDevice {
  static late FlutterDataWedge dataWedge;
  late StreamSubscription<ScanResult> onScanSubscription;

  @override
  Future<void> initialize() async {
    dataWedge = FlutterDataWedge(profileName: 'FlutterDataWedge');
    await dataWedge.initialize();
  }

  @override
  void listen(
    BuildContext context,
    void Function(String data) onResult, {
    bool onDialog = false,
  }) {
    onScanSubscription = dataWedge.onScanResult.listen((result) {
      if ((!context.mounted || ModalRoute.of(context)?.isCurrent == false) &&
          !onDialog) {
        return;
      }

      onResult(result.data);
    });
  }

  @override
  void dispose() {
    onScanSubscription.cancel();
  }
}
