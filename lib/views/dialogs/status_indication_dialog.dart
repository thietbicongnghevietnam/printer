import 'package:flutter/material.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/views/widgets/app_dotted_border.dart';
import 'package:smart_warehouse/views/widgets/app_text.dart';

void showStatusIndicationDialog(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    builder: (context) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          AppText.title('Status indication :'),
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                    width: 2,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              const Text('Empty'),
            ],
          ),
          const Row(
            children: [
              AppDottedBorder(
                child: SizedBox(
                  width: 24,
                  height: 24,
                ),
              ),
              SizedBox(width: 16),
              Text('Urgent'),
            ],
          ),
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.yellowAccent
                      .withOpacity(0.5),
                  border: Border.all(),
                ),
              ),
              const SizedBox(width: 16),
              const Text('Inspection'),
            ],
          ),
          Row(
            children: [
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.orangeAccent
                      .withOpacity(0.5),
                  border: Border.all(),
                ),
              ),
              const SizedBox(width: 16),
              const Text('Non-Inspection'),
            ],
          ),
        ].withWidgetBetween(
          const SizedBox(height: 8),
        ),
      ).paddingAll(16);
    },
  );
}