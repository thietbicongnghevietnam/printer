import 'package:flutter/material.dart';
import 'package:smart_warehouse/views/widgets/app_text.dart';

class HomeItemWidget extends StatelessWidget {
  const HomeItemWidget({
    super.key,
    required this.title,
    required this.image,
    required this.onPressed,
  });

  final String title;
  final Widget image;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFE6E6E6),
        foregroundColor: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: EdgeInsets.zero,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [image, AppText(title)],
      ),
    );
  }
}
