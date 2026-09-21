import 'package:flutter/material.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/views/pages/kitting/kitting_list/components/kitting_item_widget.dart';

import '../components/kitting_list_info_widget.dart';

class KittingListContainer extends StatelessWidget {
  const KittingListContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(12),
      children: const [
        KittingListInfoWidget(),
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
    );
  }
}
