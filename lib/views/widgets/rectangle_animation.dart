import 'dart:async';

import 'package:flutter/material.dart';

class RectangleAnimation extends StatefulWidget {
  RectangleAnimation({
    super.key,
    required this.child,
    required this.color,
    this.delay = const Duration(milliseconds: 0),
    this.repeat = false,
    this.minWidth = 60,
    this.maxWidth = 120,
    this.minHeight = 40,
    this.maxHeight = 80,
    this.rectanglesCount = 5,
    this.duration = const Duration(milliseconds: 2300),
  });

  final Widget child;
  final Duration delay;
  final double minWidth;
  final double maxWidth;
  final double minHeight;
  final double maxHeight;
  Color color = Colors.black;
  final int rectanglesCount;
  final Duration duration;
  final bool repeat;

  @override
  _RectangleAnimationState createState() => _RectangleAnimationState();
}

class _RectangleAnimationState extends State<RectangleAnimation>
    with TickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    // repeating or just forwarding the animation once.
    Timer(widget.delay, () {
      widget.repeat ? _controller?.repeat() : _controller?.forward();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: RectanglePainter(
        _controller,
        color: widget.color,
        minWidth: widget.minWidth,
        maxWidth: widget.maxWidth,
        minHeight: widget.minHeight,
        maxHeight: widget.maxHeight,
        rectanglesCount: widget.rectanglesCount + 2,
      ),
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }
}

class RectanglePainter extends CustomPainter {
  RectanglePainter(
    this._animation, {
    this.minWidth,
    this.maxWidth,
    this.minHeight,
    this.maxHeight,
    this.rectanglesCount,
    required this.color,
  }) : super(repaint: _animation);

  final Color color;
  final double? minWidth;
  final double? maxWidth;
  final double? minHeight;
  final double? maxHeight;
  final int? rectanglesCount;
  final Animation<double>? _animation;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Rect.fromLTRB(0.0, 0.0, size.width, size.height);
    for (var rectangle = 0; rectangle <= rectanglesCount!; rectangle++) {
      drawRectangle(
        canvas,
        rect,
        minWidth,
        maxWidth,
        minHeight,
        maxHeight,
        rectangle,
        _animation!.value,
        rectanglesCount!,
      );
    }
  }

  void drawRectangle(
    Canvas canvas,
    Rect rect,
    double? minWidth,
    double? maxWidth,
    double? minHeight,
    double? maxHeight,
    int rectangle,
    double value,
    int length,
  ) {
    Color _color;
    double width, height;

    if (rectangle != 0) {
      double opacity = (1 - ((rectangle - 1) / length) - value).clamp(0.0, 1.0);
      _color = color.withOpacity(opacity);

      width = minWidth! + ((maxWidth! - minWidth) * rectangle * value);
      height = minHeight! + ((maxHeight! - minHeight) * rectangle * value);

      final Paint paint = Paint()..color = _color;
      final double left = rect.center.dx - (width / 2);
      final double top = rect.center.dy - (height / 2);
      final double right = left + width;
      final double bottom = top + height;
      final Rect rectangleRect = Rect.fromLTRB(left, top, right, bottom);
      canvas.drawRect(rectangleRect, paint);
    }
  }

  @override
  bool shouldRepaint(RectanglePainter oldDelegate) => true;
}
