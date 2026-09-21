import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class ButtonBackEMap extends StatelessWidget {
  const ButtonBackEMap({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.maybePop();
      },
      child: Container(
        height: 35,
        width: 35,
        margin: const EdgeInsets.only(left: 10, top: 10),
        padding: const EdgeInsets.only(left: 4),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(1000),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(
                2,
                1,
              ),
            ),
          ],
        ),
        child: Center(
          child: Icon(
            Icons.arrow_back_ios,
            size: 15,
            color: Colors.red.withOpacity(0.7),
          ),
        ),
      ),
    );
  }
}
