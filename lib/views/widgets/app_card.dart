import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_warehouse/views/widgets/app_text.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.title,
    required this.image,
    required this.onPressed,
    this.onLongPress,
    this.itemHeight,
    this.padding = const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
    this.textStyle,
    this.trailing,
  });

  final String title;
  final Widget image;
  final VoidCallback onPressed;
  final VoidCallback? onLongPress;
  final EdgeInsets padding;

  final double? itemHeight;
  final TextStyle? textStyle;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      onLongPress: onLongPress,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFE6E6E6),
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: padding,
      ),
      child: Row(
        children: [
          image,
          const SizedBox(width: 8),
          Expanded(
            child: AppText(
              title,
              textAlign: TextAlign.left,
              style: textStyle,
            ),
          ),
          trailing ?? const SizedBox(),
        ],
      ),
    );
  }
}
