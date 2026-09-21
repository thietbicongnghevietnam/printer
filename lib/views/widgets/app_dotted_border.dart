import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AppDottedBorder extends StatelessWidget {
  const AppDottedBorder({
    super.key,
    required this.child,
    this.radius = Radius.zero,
    this.strokeWith = 2,
    this.visible = true,
  });

  final Widget child;
  final Radius radius;
  final double strokeWith;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    if (!visible) {
      return child;
    }
    return DottedBorder(
      strokeWidth: strokeWith,
      color: Colors.red,
      radius: radius,
      borderType: BorderType.RRect,
      padding: EdgeInsets.zero,
      dashPattern: const <double>[4, 2],
      child: child,
    );
  }
}
