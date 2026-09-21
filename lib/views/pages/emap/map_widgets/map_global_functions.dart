import 'package:flutter/material.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';

void drawDashedLineHorizon(
  Canvas canvas,
  Offset start,
  Offset end,
  Paint paint,
) {
  const dashWidth = 10.0;
  const dashSpace = 10.0;

  final distance = (end - start).distance;
  final segments = (distance / (dashWidth + dashSpace)).floor();

  var currentX = start.dx;
  final currentY = start.dy;

  for (var i = 0; i < segments; i++) {
    canvas.drawLine(
      Offset(currentX, currentY),
      Offset(currentX + dashWidth, currentY),
      paint,
    );
    currentX += dashWidth + dashSpace;
  }
}

void drawDashedLineVertical(
  Canvas canvas,
  Offset start,
  Offset end,
  Paint paint,
) {
  const dashWidth = 10.0;
  const dashSpace = 10.0;

  final distanceX = (end.dx - start.dx).abs();
  final distanceY = (end.dy - start.dy).abs();

  final segmentsX = (distanceX / (dashWidth + dashSpace)).floor();
  final segmentsY = (distanceY / (dashWidth + dashSpace)).floor();

  var currentX = start.dx;
  var currentY = start.dy;

  for (var i = 0; i < segmentsX; i++) {
    canvas.drawLine(
      Offset(currentX, currentY),
      Offset(currentX + dashWidth, currentY),
      paint,
    );
    currentX += dashWidth + dashSpace;
  }

  currentX = start.dx;

  for (var i = 0; i < segmentsY; i++) {
    canvas.drawLine(
      Offset(currentX, currentY),
      Offset(currentX, currentY + dashWidth),
      paint,
    );
    currentY += dashWidth + dashSpace;
  }
}

String convertFFColor(String backgroundColor) {
  String zoneColor = backgroundColor;
  return '0xff$zoneColor';
}

Color convertColorFromString(String value) {
  if (value.isNotEmpty) {
    String currentColorKey = value;
    if (currentColorKey.contains('rgba')) {
      RegExp regExp = RegExp(r'rgba\((\d+),\s*(\d+),\s*(\d+),\s*(\d+\.?\d*)\)');
      final match = regExp.firstMatch(currentColorKey);

      int r = int.parse(match!.group(1)!);
      int g = int.parse(match.group(2)!);
      int b = int.parse(match.group(3)!);
      double a = double.parse(match.group(4)!);

      // Convert alpha to an integer between 0 and 255
      int alpha = (a * 255).round();

      return Color.fromARGB(alpha, r, g, b);
    } else if (currentColorKey.contains('rgb')) {
      RegExp regExp = RegExp(r'\d+');
      Iterable<Match> matches = regExp.allMatches(currentColorKey);
      List<int> numbers =
          matches.map((match) => int.parse(match.group(0)!)).toList();
      int r = numbers[0];
      int g = numbers[1];
      int b = numbers[2];

      return Color.fromRGBO(r, g, b, 1);
    } else {
      return Color('0xff$currentColorKey'.toInt());
    }
  }
  return Colors.transparent;
}
