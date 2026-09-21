import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/e_map/order_block.dart';
import 'package:smart_warehouse/entities/e_map/suggest_path.dart';
import 'package:smart_warehouse/entities/kitting/kitting_detail.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/extensions/context_extensions.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';

import 'components/e_map_kitting.dart';
import 'emap_kitting_controller.dart';
import 'emap_kitting_state.dart';

@RoutePage()
class EmapKittingPage
    extends BasePage<EmapKittingController, EmapKittingState> {
  const EmapKittingPage(
    this.listKittingDetails,
    this.selectedLocations, {
    this.orderBlocks = const [],
    this.suggestPaths = const [],
    super.key,
  });

  final List<String> selectedLocations;
  final List<KittingDetail> listKittingDetails;
  final List<OrderBlock> orderBlocks;
  final List<SuggestPath> suggestPaths;

  @override
  EmapKittingController buildCubit(BuildContext context) {
    return getIt<EmapKittingController>()
      ..listKittingDetails = listKittingDetails
      ..orderBlocks = orderBlocks
      ..suggestPaths = suggestPaths;
  }

  @override
  Widget builder(context, cubit, state) {
    final initScale = context.width / state.floor!.width;
    return Scaffold(
      appBar: AppBar(title: const Text('Danh sách Block cần Kitting')),
      body: EmapKittingWidget(
        config: EmapConfig(initScale: initScale),
        selectedLocations: selectedLocations,
        floor: state.floor!,
        listKittingDetails: listKittingDetails,
        orderBlock: state.orderBlock,
        suggestPath: state.suggestPath,
      ),
    );
  }
}
