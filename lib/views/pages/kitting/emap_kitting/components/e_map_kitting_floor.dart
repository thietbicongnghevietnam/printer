import 'dart:ui';

import 'package:flutter/material.dart';

import 'e_map_kitting_factory.dart';

class EmapKittingFloor extends IEmapKitting {
  EmapKittingFloor(super.param);

  @override
  void build() {
    final canvas = param.canvas;
    final widget = param.widget;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.blue
      ..strokeWidth = 30;

    // Border
    canvas.drawRect(Rect.fromLTWH(0, 0, widget.width, widget.height), paint);
  }
}
