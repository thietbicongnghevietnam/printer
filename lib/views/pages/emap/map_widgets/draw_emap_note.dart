import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:smart_warehouse/entities/e_map/emap_widget.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';

class DrawEMapNote extends StatelessWidget {
  const DrawEMapNote({
    super.key,
    required this.eMapChildWidget,
    required this.totalTempQty,
    required this.totalStorageQty,
    required this.areaName,
    required this.lastNode,
  });

  final EMapWidget eMapChildWidget;

  final int totalTempQty;
  final int totalStorageQty;

  final String areaName;
  final String lastNode;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Colors.black.withOpacity(0.5),
            ),
            color: Colors.white.withOpacity(0.5),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 6,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRichTextNote(
                  label: LocaleKeys.storing_storage.tr(),
                  value: totalStorageQty.toString()),
              const SizedBox(height: 5),
              _buildRichTextNote(
                  label: LocaleKeys.storing_temporary.tr(),
                  value: totalTempQty.toString()),
              const SizedBox(height: 5),
              _buildRichTextNote(
                  label: LocaleKeys.storing_last_node.tr(), value: lastNode),
              const SizedBox(height: 5),
              _buildRichTextNote(label: 'Khu vực', value: areaName),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Colors.black.withOpacity(0.5),
            ),
            color: Colors.white.withOpacity(0.5),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 6,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildItemDescription(label: 'Gợi ý'),
              const SizedBox(height: 5),
              _buildItemDescription(
                label: 'Last Node',
                isSuggested: false,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRichTextNote({
    required String label,
    required String value,
  }) {
    return RichText(
      text: TextSpan(
        text: label,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 8,
          color: Colors.red,
        ),
        children: [
          TextSpan(
            text: ' $value',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 8,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemDescription({
    required String label,
    bool isSuggested = true,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 8,
            color: Colors.black,
          ),
        ),
        const SizedBox(width: 5),
        DottedBorder(
          color: isSuggested ? Colors.red : Colors.yellow,
          child: const SizedBox(
            height: 10,
            width: 12,
          ),
        ),
      ],
    );
  }
}
