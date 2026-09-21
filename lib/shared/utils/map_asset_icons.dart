import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@singleton
class MapAssetIcons {
  late ui.Image icArrowNotFill;
  late ui.Image icArrowFill;
  late ui.Image icFolkLift;
  late ui.Image icFolkLiftWorking;
  late ui.Image icContainerTruck;
  late ui.Image icDoorMap;
  late ui.Image icDoubleDoorMap;
  late ui.Image icFolkLift2;
  late ui.Image icContainer2;
  late ui.Image icTrolley;
  late ui.Image icPallet;
  late ui.Image icPlSign;
  late ui.Image icPL;

  Future<void> initialLocalIcon() async {
    final imagePaths = [
      'assets/images/ic_arrow_fill.png',
      'assets/images/ic_arrow_not_fill.png',
      'assets/images/ic_container_truck.png',
      'assets/images/ic_door_map.png',
      'assets/images/ic_double_door_map.png',
      'assets/images/ic_folklift.png',
      'assets/images/ic_folklift_working.png',
      'assets/images/ic_folklift_2.png',
      'assets/images/ic_container_2.png',
      'assets/images/ic_trolley.jpg',
      'assets/images/ic_pallet.png',
      'assets/images/ic_pl_sign.png',
      'assets/images/ic_pl.png',
    ];

    for (final path in imagePaths) {
      final data = await rootBundle.load(path);
      final completer = Completer<ui.Image>();
      ui.decodeImageFromList(data.buffer.asUint8List(), completer.complete);
      final image = await completer.future;
      switch (path) {
        case 'assets/images/ic_arrow_not_fill.png':
          icArrowNotFill = image;
        case 'assets/images/ic_arrow_fill.png':
          icArrowFill = image;
        case 'assets/images/ic_folklift.png':
          icFolkLift = image;
        case 'assets/images/ic_folklift_working.png':
          icFolkLiftWorking = image;
        case 'assets/images/ic_container_truck.png':
          icContainerTruck = image;
        case 'assets/images/ic_door_map.png':
          icDoorMap = image;
        case 'assets/images/ic_double_door_map.png':
          icDoubleDoorMap = image;
        case 'assets/images/ic_folklift_2.png':
          icFolkLift2 = image;
        case 'assets/images/ic_container_2.png':
          icContainer2 = image;
        case 'assets/images/ic_trolley.jpg':
          icTrolley = image;
        case 'assets/images/ic_pallet.png':
          icPallet = image;
        case 'assets/images/ic_pl_sign.png':
          icPlSign = image;
        case 'assets/images/ic_pl.png':
          icPL = image;
      }
    }
  }
}
