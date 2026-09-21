import 'package:flutter/material.dart';

class IndoorMapBorder extends StatelessWidget {
  const IndoorMapBorder({
    super.key,
    this.mapWidth,
    this.mapHeight,
    required this.offsetX,
    required this.offsetY,
  });

  final double? mapWidth;
  final double? mapHeight;
  final double offsetX;
  final double offsetY;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: IndoorMapPainter(
        mapWidth: mapWidth ?? 0,
        mapHeight: mapHeight ?? 0,
        offsetX: offsetX,
        offsetY: offsetY,
      ),
    );
  }
}

class IndoorMapPainter extends CustomPainter {
  IndoorMapPainter({
    super.repaint,
    required this.mapWidth,
    required this.mapHeight,
    required this.offsetX,
    required this.offsetY,
  });

  final double mapWidth;
  final double mapHeight;
  final double offsetX;
  final double offsetY;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 20.0
      ..style = PaintingStyle.stroke;

    canvas.drawRect(
        Offset(offsetX, offsetY) & Size(mapWidth, mapHeight), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
