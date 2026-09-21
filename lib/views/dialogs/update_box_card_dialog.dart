import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/views/widgets/app_dotted_border.dart';
import 'package:smart_warehouse/views/widgets/app_form_field.dart';
import 'package:smart_warehouse/views/widgets/app_text.dart';

void showUpdateBoxCardDialog(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (context) {
      return Scaffold(
        body: Column(
          children: [
            AppText.header('Danh sách Box Card'),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ...List.generate(3, (index) {
                    return Row(
                      children: [
                        AppText.title('Hộp ${index + 1}'),
                        const SizedBox(width: 8),
                        const Expanded(child: AppFormField()),
                      ],
                    );
                  }),
                ].withWidgetBetween(const SizedBox(height: 8)),
              ).paddingAll(16),
            ),
            ElevatedButton(onPressed: () {}, child: const Text('Lưu thay đổi'))
          ],
        ),
      );
    },
  );
}
