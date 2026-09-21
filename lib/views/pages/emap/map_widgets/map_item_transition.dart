import 'package:flutter/material.dart';

class MapItemTransition extends StatelessWidget {
  const MapItemTransition({
    super.key,
    required this.offsetX,
    required this.offsetY,
    required this.child,
    this.onTap,
  });

  final double offsetX;
  final double offsetY;
  final Widget child;

  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(
        offsetX,
        offsetY,
      ),
      child: GestureDetector(
          onTap: (){
            onTap?.call();
          },
          child: child),
    );
  }
}