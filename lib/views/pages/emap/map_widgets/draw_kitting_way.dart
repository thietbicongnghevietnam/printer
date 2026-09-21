import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:smart_warehouse/entities/e_map/suggest_path.dart';

class DrawKittingWay extends StatelessWidget {
  const   DrawKittingWay({
    super.key,
    required this.lineData,
    required this.lineColor,
    required this.lineWidth,
    required this.reOffsetX,
    required this.reOffsetY,
  });

  final Color lineColor;

  final double lineWidth;
  final double reOffsetX;
  final double reOffsetY;

  final List<SuggestPath> lineData;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: LinePainter(
        lineData: lineData,
        lineColor: lineColor,
        lineWidth: lineWidth,
        reOffsetX: reOffsetX,
        reOffsetY: reOffsetY,
      ),
    );
  }
}

class LinePainter extends CustomPainter {
  LinePainter({
    required this.lineData,
    required this.lineColor,
    required this.lineWidth,
    required this.reOffsetX,
    required this.reOffsetY,
  });

  final Color lineColor;

  final double lineWidth;
  final double reOffsetX;
  final double reOffsetY;

  final List<SuggestPath> lineData;

  @override
  void paint(Canvas canvas, Size size) {
    if (lineData.isEmpty) {
      return;
    }

    PictureRecorder recorder = PictureRecorder();
    Canvas recordingCanvas = Canvas(recorder);

    Path path = Path();

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = lineColor
      ..strokeWidth = lineWidth;

    path.moveTo(lineData.first.x + reOffsetX, lineData.first.y + reOffsetY);

    for (var i = 0; i < lineData.length; i++) {
      path.lineTo(lineData[i].x + reOffsetX, lineData[i].y + reOffsetY);
    }
    recordingCanvas.drawPath(path, paint);

    Picture picture = recorder.endRecording();
    canvas.drawPicture(picture);
  }

  @override
  bool shouldRepaint(covariant LinePainter oldDelegate) {
    return false;
  }
}
