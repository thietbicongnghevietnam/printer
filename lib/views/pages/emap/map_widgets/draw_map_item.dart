import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/e_map/emap_rack.dart';
import 'package:smart_warehouse/entities/e_map/emap_widget.dart';
import 'package:smart_warehouse/enums/map_item_type.dart';
import 'package:smart_warehouse/shared/utils/map_asset_icons.dart';
import 'package:smart_warehouse/views/pages/emap/map_widgets/map_item_transition.dart';

import 'map_global_functions.dart';

class DrawMapItem extends StatelessWidget {
  const DrawMapItem({
    super.key,
    required this.widgetMap,
    required this.newX,
    required this.newY,
    this.rackUnit,
    this.label = '',
  });

  final EMapWidget widgetMap;

  final double newX;
  final double newY;

  final int? rackUnit;

  final String label;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = widgetMap.fill?.replaceAll('#', '');
    final borderColor = widgetMap.border?.replaceAll('#', '');
    final type = widgetMap.type;
    if (type == WidgetMapType.ladder ||
        type == WidgetMapType.door ||
        type == WidgetMapType.singleDoor ||
        type == WidgetMapType.doubleDoor ||
        type == WidgetMapType.noDoor ||
        type == WidgetMapType.robotLine ||
        type == WidgetMapType.line) {
      return MapItemTransition(
        offsetX: newX,
        offsetY: newY,
        child: CustomPaint(
          isComplex: true,
          painter: CustomRenderPainter(
            backgroundColor: backgroundColor != null
                ? convertColorFromString(backgroundColor ?? '')
                : Colors.transparent,
            borderColor: borderColor != null
                ? convertColorFromString(borderColor ?? '')
                : Colors.transparent,
            widgetMap: widgetMap,
            labelName: label,
            newX: newX,
            newY: newY,
          ),
        ),
      );
    }

    return MapItemTransition(
      offsetX: newX,
      offsetY: newY,
      child: CustomPaint(
        size: Size(widgetMap.width ?? 0, widgetMap.height ?? 0),
        painter: CustomRenderPainter(
          backgroundColor: backgroundColor != null
              ? convertColorFromString(backgroundColor ?? '')
              : Colors.transparent,
          borderColor: borderColor != null
              ? convertColorFromString(borderColor ?? '')
              : Colors.transparent,
          widgetMap: widgetMap,
          labelName: label,
          newX: newX,
          newY: newY,
          rackUnit: rackUnit,
        ),
      ),
    );
  }
}

class CustomRenderPainter extends CustomPainter {
  CustomRenderPainter({
    required this.widgetMap,
    required this.backgroundColor,
    required this.borderColor,
    required this.labelName,
    required this.newX,
    required this.newY,
    this.rackUnit,
  });

  final String labelName;

  final double newX;
  final double newY;

  final int? rackUnit;

  final EMapWidget widgetMap;

  final Color backgroundColor;
  final Color borderColor;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();

    if (_isZoneRackType(widgetMap.type)) {
      _drawZoneRack(
          canvas: canvas,
          size: size,
          forRack: widgetMap.type == WidgetMapType.rack);
    } else if (widgetMap.type == WidgetMapType.line) {
      _drawLine(canvas: canvas);
    } else if (widgetMap.type == WidgetMapType.text) {
      _drawMapText(canvas);
    } else if (_isPathType(widgetMap.type)) {
      _drawPath(canvas, size);
    } else {
      _drawIconType(canvas, size);
    }
    canvas.restore();
  }

  bool _isZoneRackType(WidgetMapType? type) {
    return type == WidgetMapType.group ||
        type == WidgetMapType.floor ||
        type == WidgetMapType.zone ||
        type == WidgetMapType.rack ||
        type == WidgetMapType.zoneSingleDoor ||
        type == WidgetMapType.zoneDoubleDoor ||
        type == WidgetMapType.zoneNoDoor ||
        type == WidgetMapType.rectangle;
  }

  bool _isPathType(WidgetMapType? type) {
    return type == WidgetMapType.ladder ||
        type == WidgetMapType.door ||
        type == WidgetMapType.singleDoor ||
        type == WidgetMapType.doubleDoor ||
        type == WidgetMapType.noDoor ||
        type == WidgetMapType.robotLine;
  }

  // Draw Zone, Rack
  void _drawZoneRack({
    required Canvas canvas,
    required Size size,
    bool forRack = false,
  }) {
    EMapWidget emapItem = widgetMap;
    canvas.rotate((emapItem.rotation ?? 1) * 3.1415927 / 180);

    canvas.scale(emapItem.scaleX ?? 1, emapItem.scaleY ?? 1);

    Rect rect = Rect.fromLTWH(
      (size.width - (emapItem.width ?? 0)) / 2,
      (size.height - (emapItem.height ?? 0)) / 2,
      emapItem.width ?? 0,
      emapItem.height ?? 0,
    );

    final fillColor = backgroundColor;
    final borColor = borderColor;

    Paint paint = Paint()
      ..color = fillColor
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, Radius.zero),
      paint,
    );

    if (emapItem.borderWidth != null && emapItem.borderWidth! > 0) {
      paint = Paint()
        ..color = borColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = emapItem.borderWidth ?? 0;

      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, Radius.zero),
        paint,
      );
    }

    if (rackUnit != null && rackUnit! > 0) {
      double moveX = 0;
      double plusX = (emapItem.width ?? 1) / (rackUnit ?? 1);
      for (var i = 0; i < (rackUnit ?? 1); i++) {
        moveX = plusX * i;
        paint = Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke;

        canvas.drawRect(
          Offset(moveX, 0) & Size(1, emapItem.height ?? 1),
          paint,
        );
      }
    }

    if (labelName.isNotEmpty && forRack) {
      TextPainter textPainter = TextPainter(
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
      );

      double maxFontSize = 100;
      double minFontSize = 15;
      double fontSize = maxFontSize;

      while (maxFontSize - minFontSize > 0.1) {
        textPainter.text =
            TextSpan(text: labelName, style: TextStyle(fontSize: fontSize));
        textPainter.layout();

        if (textPainter.width <= rect.width &&
            textPainter.height <= rect.height) {
          minFontSize = fontSize;
        } else {
          maxFontSize = fontSize;
        }
        fontSize = (minFontSize + maxFontSize) / 2;
      }

      textPainter.text = TextSpan(
          text: labelName,
          style: TextStyle(
            fontSize: fontSize - 8,
            color: Colors.black,
            fontWeight: FontWeight.w700,
          ));
      textPainter.layout();

      double dx = 10;
      double dy = rect.top + (rect.height - textPainter.height) / 2;

      textPainter.paint(canvas, Offset(dx, dy));
    }

    if (emapItem is EMapRack) {
      if (emapItem.pl.toUpperCase() == 'PL') {
        _drawPlIcon(canvas, size, Offset.zero);
      }
    }
  }

  // Draw Line
  void _drawLine({required Canvas canvas}) {
    final lineData = widgetMap.points;
    final lineWidth = widgetMap.width;
    final borderColor = widgetMap.border?.replaceAll('#', '') ?? '';

    if (lineData.isEmpty) {
      return;
    }

    final paint = Paint()
      ..color = borderColor.isNotEmpty
          ? convertColorFromString(borderColor ?? '')
          : Colors.black
      ..strokeWidth = lineWidth ?? 1;

    for (int i = 0; i < lineData.length - 1; i++) {
      final p1 = lineData[i];
      final p2 = lineData[i + 1];
      canvas.drawLine(
        Offset((p1.x ?? 0).toDouble(), (p1.y ?? 0).toDouble()),
        Offset((p2.x ?? 0).toDouble(), (p2.y ?? 0).toDouble()),
        paint,
      );
    }
  }

  // Draw Text
  void _drawMapText(Canvas canvas) {
    canvas.rotate((widgetMap.rotation ?? 1) * 3.1415927 / 180);

    canvas.scale(widgetMap.scaleX ?? 1, widgetMap.scaleY ?? 1);

    final fillColor = backgroundColor;

    if (widgetMap.label != null && widgetMap.label!.isNotEmpty) {
      final label = widgetMap.label ?? '';
      TextPainter textPainter;
      textPainter = TextPainter(
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );

      textPainter.text = TextSpan(
        text: label,
        style: TextStyle(
          color: fillColor,
          fontSize: widgetMap.fontSize ?? 19,
          fontWeight: FontWeight.w700,
        ),
      );

      const position = Offset(10, 20);

      if (textPainter.text != null) {
        textPainter.layout();
        textPainter.paint(canvas, position);
      }
    }
  }

  // Draw Icon
  void _drawIconType(Canvas canvas, Size size) {
    final type = widgetMap.type;
    final _assetIcons = getIt<MapAssetIcons>();
    ui.Image? image;
    if (type == WidgetMapType.arrow) {
      image = _assetIcons.icArrowNotFill;
    } else if (type == WidgetMapType.arrowFill) {
      image = _assetIcons.icArrowFill;
    } else if (type == WidgetMapType.folklift) {
      image = _assetIcons.icFolkLift;
    } else if (type == WidgetMapType.folkliftWorking) {
      image = _assetIcons.icFolkLiftWorking;
    } else if (type == WidgetMapType.container) {
      image = _assetIcons.icContainerTruck;
    } else if (type == WidgetMapType.forklift2) {
      image = _assetIcons.icFolkLift2;
    } else if (type == WidgetMapType.container2) {
      image = _assetIcons.icContainer2;
    } else if (type == WidgetMapType.trolley) {
      image = _assetIcons.icTrolley;
    }

    canvas.scale(widgetMap.scaleX ?? 1, widgetMap.scaleY ?? 1);

    // Calculate the center of the canvas
    final center = Offset(size.width / 2, size.height / 2);

    // Move the canvas to the center
    canvas.translate(center.dx, center.dy);

    // Rotate the canvas
    canvas.rotate((widgetMap.rotation ?? 1) * 3.1415927 / 180);

    // Move the canvas back
    canvas.translate(-center.dx, -center.dy);

    paintImage(
      canvas: canvas,
      rect: Rect.fromCenter(
        center: Offset(size.width / 2, size.height / 2),
        width: image!.width.toDouble(),
        height: image.height.toDouble(),
      ),
      image: image,
      fit: BoxFit.contain,
    );
  }

  // Draw PL Icon
  void _drawPlIcon(Canvas canvas, Size size, Offset offset) {
    final _assetIcons = getIt<MapAssetIcons>();
    ui.Image? image;
    image = _assetIcons.icPlSign;

    canvas.drawImageRect(
      image,
      Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      Rect.fromLTWH(offset.dx + 100, offset.dy, 65, 65),
      Paint(),
    );
  }

  // Draw SVGPath
  void _drawPath(Canvas canvas, Size size) {
    canvas.scale(widgetMap.scaleX ?? 1, widgetMap.scaleY ?? 1);

    canvas.save();

    final center = Offset(size.width / 2, size.height / 2);

    canvas.translate(center.dx, center.dy);

    canvas.rotate((widgetMap.rotation ?? 0) * 3.1415927 / 180);

    canvas.translate(-center.dx, -center.dy);
    Paint paint = Paint();
    Path path = Path();

    if (widgetMap.data != null) {
      path = parseSvgPathData(widgetMap.data ?? '');
    }

    if (widgetMap.type == WidgetMapType.ladder) {
      paint = Paint()
        ..color = backgroundColor
        ..style = PaintingStyle.fill
        ..strokeWidth = widgetMap.borderWidth ?? 10;

      canvas.drawPath(path, paint);
    }

    paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = widgetMap.borderWidth ?? 10;

    canvas.drawPath(path, paint);

    canvas.restore();
  }

  Path convertSvgPathData(String pathData) {
    final path = Path();
    final commands = pathData.split(' ');

    for (var i = 0; i < commands.length; i++) {
      final command = commands[i];
      if (command == 'M') {
        final x = double.parse(commands[++i]);
        final y = double.parse(commands[++i]);
        path.moveTo(x, y);
      } else if (command == 'c') {
        final x1 = double.parse(commands[++i]);
        final y1 = double.parse(commands[++i]);
        final x2 = double.parse(commands[++i]);
        final y2 = double.parse(commands[++i]);
        final x3 = double.parse(commands[++i]);
        final y3 = double.parse(commands[++i]);
        path.relativeCubicTo(x1, y1, x2, y2, x3, y3);
      } else if (command == 's') {
        final x2 = double.parse(commands[++i]);
        final y2 = double.parse(commands[++i]);
        final x3 = double.parse(commands[++i]);
        final y3 = double.parse(commands[++i]);
        path.relativeCubicTo(0, 0, x2, y2, x3, y3);
      } else if (command == 'C') {
        final x1 = double.parse(commands[++i]);
        final y1 = double.parse(commands[++i]);
        final x2 = double.parse(commands[++i]);
        final y2 = double.parse(commands[++i]);
        final x3 = double.parse(commands[++i]);
        final y3 = double.parse(commands[++i]);
        path.cubicTo(x1, y1, x2, y2, x3, y3);
      } else if (command == 'z') {
        path.close();
      }
    }

    return path;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
