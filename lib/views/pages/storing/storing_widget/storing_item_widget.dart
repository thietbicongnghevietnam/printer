import 'package:flutter/material.dart';
import 'package:smart_warehouse/views/widgets/app_text.dart';

class StoringItemWidget extends StatelessWidget {
  const StoringItemWidget({
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
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          image,
          const SizedBox(height: 4),
          AppText(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: 13,
            ),
          )
        ],
      ),
    );
  }
}
