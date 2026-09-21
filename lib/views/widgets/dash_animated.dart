import 'dart:math';

import 'package:flutter/material.dart';

class DashedAnimated extends StatefulWidget {
  const DashedAnimated({super.key});

  @override
  _DashedAnimatedState createState() => _DashedAnimatedState();
}

class _DashedAnimatedState extends State<DashedAnimated>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 200,
        height: 200,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return CustomPaint(
              painter: DashedSquarePainter(
                progress: _controller.value,
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class DashedSquarePainter extends CustomPainter {
  final double progress;

  DashedSquarePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    final double sideLength = size.width;
    final double dashLength = 10.0;
    final double totalDashes = 4;

    for (double i = 0; i < totalDashes; i++) {
      final double progressForSide = progress - (i / totalDashes);

      final double startX;
      final double startY;
      final double endX;
      final double endY;

      if (progressForSide >= 0.0) {
        if (progressForSide < 1.0) {
          startX = i / totalDashes * sideLength;
          startY = 0;
          endX = i / totalDashes * sideLength + progressForSide * sideLength;
          endY = 0;
        } else if (progressForSide < 2.0) {
          startX = sideLength;
          startY = (progressForSide - 1.0) * sideLength;
          endX = sideLength;
          endY = sideLength * min(1, progressForSide - 1.0);
        } else if (progressForSide < 3.0) {
          startX = sideLength - (progressForSide - 2.0) * sideLength;
          startY = sideLength;
          endX = 0;
          endY = sideLength;
        } else {
          startX = 0;
          startY = sideLength - (progressForSide - 3.0) * sideLength;
          endX = 0;
          endY = 0;
        }

        canvas.drawRect(
          Rect.fromLTRB(startX, startY, endX, endY),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
