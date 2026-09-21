import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ReceivingCardItemWidget extends StatelessWidget {
  const ReceivingCardItemWidget({
    super.key,
    required this.label,
    required this.reCardMaterial,
    this.onRemoved,
  });

  final String label;
  final String reCardMaterial;
  final VoidCallback? onRemoved;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, color: Colors.black),
          ).tr(),
          const SizedBox(width: 5),
          Expanded(
            child: Text(
              reCardMaterial,
              style: const TextStyle(fontSize: 14, color: Colors.black),
              maxLines: 1,
            ),
          ),
          const SizedBox(width: 5),
          IconButton(
            onPressed: onRemoved,
            icon:
                const Icon(Icons.highlight_remove_outlined, color: Colors.red),
          ),
        ],
      ),
    );
  }
}
