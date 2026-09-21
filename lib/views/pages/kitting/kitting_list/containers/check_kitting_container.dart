import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';
import 'package:smart_warehouse/views/widgets/app_text.dart';

import '../components/kitting_item_widget.dart';
import '../components/kitting_list_info_widget.dart';

class CheckKittingContainer extends StatelessWidget {
  const CheckKittingContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),

        Row(
          children: [
            AppText.title('Kitting Card'),
            const SizedBox(width: 4),
            Expanded(child: AppFormField()),
          ],
        ).paddingSymmetric(horizontal: 12),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(12),

            children: const [
              KittingItemWidget(),
              KittingItemWidget(),
              KittingItemWidget(),
              KittingItemWidget(),
              KittingItemWidget(),
              KittingItemWidget(),
              KittingItemWidget(),
              KittingItemWidget(),
              KittingItemWidget(),
              KittingItemWidget(),
              KittingItemWidget(),
            ],
          ),
        ),
      ],
    );
  }
}
