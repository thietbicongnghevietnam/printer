import 'dart:math';

import 'package:flutter/material.dart';
import 'package:smart_warehouse/shared/extensions/color_extensions.dart';

import 'e_map_kitting_factory.dart';

class EmapKittingLabel extends IEmapKitting {
  EmapKittingLabel(super.param);

  @override
  void build() {
    final canvas = param.canvas;
    final widget = param.widget;

    canvas.save();
    // Rotate the canvas

    canvas.translate((param.parentPosition?.dx ?? 0) + (widget.x),
        (param.parentPosition?.dy ?? 0) + (widget.y));
    canvas.rotate((widget.rotation) * pi / 180);

    canvas.scale(widget.scaleX, widget.scaleY);


    final fillColor = widget.fill.toColor();

    if (widget.label != null && widget.label!.isNotEmpty) {
      final label = widget.label ?? '';
      TextPainter textPainter;
      textPainter = TextPainter(
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      textPainter.text = TextSpan(
        text: label,
        style: TextStyle(
          color: fillColor,
          fontSize: (widget.fontSize ?? 19) * 1.0,
          fontWeight: FontWeight.bold,
        ),
      );

      textPainter.layout();
      textPainter.paint(canvas, Offset.zero);
    }

    canvas.restore();
  }
}
