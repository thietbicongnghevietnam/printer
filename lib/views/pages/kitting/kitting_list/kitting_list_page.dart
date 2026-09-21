import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:smart_warehouse/gen/assets.gen.dart';
import 'package:smart_warehouse/shared/extensions/table_extensions.dart';
import 'package:smart_warehouse/shared/extensions/widget_extensions.dart';
import 'package:smart_warehouse/views/pages/kitting/kitting_list/containers/check_kitting_container.dart';
import 'package:smart_warehouse/views/pages/kitting/kitting_list/containers/supplied_container.dart';
import 'package:smart_warehouse/views/pages/kitting/kitting_list/containers/supply_container.dart';
import 'package:smart_warehouse/views/widgets/app_text.dart';

import 'components/kitting_list_info_widget.dart';
import 'components/kitting_status_widget.dart';
import 'containers/kitting_list_container.dart';

class KittingListPage extends StatefulWidget {
  const KittingListPage({super.key});

  @override
  State<KittingListPage> createState() => _KittingListPageState();
}

class _KittingListPageState extends State<KittingListPage> with SingleTickerProviderStateMixin {
  int activeStep = 0;
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kitting List'),
        bottom: const PreferredSize(
          preferredSize: Size(double.infinity, 28),
          child: KittingStatusWidget(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          KittingListContainer(),
          CheckKittingContainer(),
          SupplyContainer(),
          SuppliedContainer(),
        ],
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: () {},
        child: const Text('Kiểm tra'),
      ).paddingSymmetric(horizontal: 16, vertical: 2),
    );
  }


}
