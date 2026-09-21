import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:smart_warehouse/shared/extensions/color_extensions.dart';
import 'package:smart_warehouse/shared/extensions/path_extensions.dart';

import 'e_map_kitting_factory.dart';

class EmapKittingRack extends IEmapKitting {
  EmapKittingRack(super.param);

  @override
  void build() {
    final canvas = param.canvas;
    final widget = param.widget;

    final rect = Rect.fromLTWH(0, 0, widget.width, widget.height);

    final backgroundPaint = Paint()..color = widget.fill.toString().toColor();
    final borderPaint = Paint()
      ..style = PaintingStyle.stroke
      ..color = widget.border.toString().toColor()
      ..strokeWidth = widget.borderWidth ?? 0;

    canvas.save();
    canvas.translate((param.parentPosition?.dx ?? 0) + (widget.x),
        (param.parentPosition?.dy ?? 0) + (widget.y));
    canvas.rotate((widget.rotation) * pi / 180);

    canvas.drawRect(rect, backgroundPaint);

    if (widget.data != null) {
      canvas.drawPath(widget.data!.toPath(), borderPaint);
    }

    canvas.restore();
  }
}
