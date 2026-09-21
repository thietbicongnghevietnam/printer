import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:smart_warehouse/shared/extensions/color_extensions.dart';

import 'e_map_kitting_factory.dart';

class EmapKittingZone extends IEmapKitting {
  EmapKittingZone(super.param);

  @override
  void build() {
    final canvas = param.canvas;
    final widget = param.widget;

    final rect = Rect.fromLTWH(widget.x, widget.y, widget.width, widget.height);

    final backgroundPaint = Paint()..color = widget.fill.toString().toColor();
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = widget.border.toString().toColor()
      ..strokeWidth = widget.borderWidth ?? 0;

    canvas.drawRect(rect, backgroundPaint);
    canvas.drawRect(rect, borderPaint);
  }
}
