import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/entities/e_map/emap_rack.dart';
import 'package:smart_warehouse/entities/e_map/emap_zone.dart';
import 'package:smart_warehouse/entities/e_map/offset_block_detail.dart';
import 'package:smart_warehouse/enums/emap_navigate_funciton.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/extensions/duration_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';
import 'package:smart_warehouse/views/pages/emap/map_widgets/button_back_emap.dart';
import 'package:smart_warehouse/views/pages/emap/map_widgets/draw_emap_note.dart';
import 'package:smart_warehouse/views/pages/emap/map_widgets/layout_map.dart';

import 'new_map_zone_controller.dart';
import 'new_map_zone_state.dart';

@RoutePage()
class NewMapZonePage extends BasePage<NewMapZoneController, NewMapZoneState> {
  const NewMapZonePage({
    super.key,
    this.receivingCardId,
    this.eMapNavigateFunction = EMapNavigateFunction.storing,
    this.zoneData,
    this.totalTempQty = 0,
    this.totalStoreQty = 0,
    this.lastLotName = '',
  });

  final int? receivingCardId;

  // final NewMapWidgetResponseModel? zoneData;
  final EMapZone? zoneData;
  final EMapNavigateFunction eMapNavigateFunction;

  final int totalStoreQty;
  final int totalTempQty;

  final String lastLotName;

  @override
  BasePageState createState() {
    return NewMapZonePageState(
      eMapNavigateFunction: eMapNavigateFunction,
      receivingCardId: receivingCardId ?? 0,
      zoneData: zoneData,
      totalStoreQty: totalStoreQty,
      totalTempQty: totalTempQty,
      lastLotName: lastLotName,
    );
  }
}

class NewMapZonePageState
    extends BasePageState<NewMapZoneController, NewMapZoneState> {
  NewMapZonePageState({
    required this.eMapNavigateFunction,
    required this.receivingCardId,
    this.zoneData,
    this.totalStoreQty,
    this.totalTempQty,
    this.lastLotName = '',
  });

  final int receivingCardId;
  final int? totalStoreQty;
  final int? totalTempQty;

  final String lastLotName;

  final EMapZone? zoneData;

  final EMapNavigateFunction eMapNavigateFunction;

  @override
  void initState() {
    super.initState();
    context.read<NewMapZoneController>().loadZoneData(
          receivingCardId: receivingCardId,
          zoneMapData: zoneData,
        );
  }

  @override
  Widget builder(context, cubit, state) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<NewMapZoneController, NewMapZoneState>(
          buildWhen: (prev, current) {
            return prev.zoneMapData != current.zoneMapData;
          },
          builder: (context, state) {
            final zoneData = state.zoneMapData;

            return Stack(
              children: [
                if (zoneData != null)
                  LayoutMap(
                    eMapChildWidget: zoneData,
                    reOffsetX: 500,
                    reOffsetY: 1000,
                    totalStorageQty: totalStoreQty ?? 0,
                    totalTempQty: totalTempQty ?? 0,
                    areaName: state.zoneMapData?.zoneName ?? '',
                    lastNode: state.zoneMapData?.lastNodeName ?? '',
                    eMapNavigateFunction: eMapNavigateFunction,
                    fromZoneMap: true,
                    onTapWidget: (eMapWidget) async {
                      if (eMapWidget is EMapRack) {
                        await onTapRack(
                          eMapZone: state.zoneMapData!,
                          eMapRack: eMapWidget,
                        );
                      }
                    },
                  )
                else
                  Center(
                    child: const Text(LocaleKeys.error_do_not_have_data).tr(),
                  ),
                const ButtonBackEMap(),
                if (zoneData != null)
                  Positioned(
                    top: 5,
                    right: 5,
                    child: DrawEMapNote(
                      eMapChildWidget: zoneData,
                      totalStorageQty: totalStoreQty ?? 0,
                      totalTempQty: totalTempQty ?? 0,
                      areaName: state.zoneMapData?.zoneName ?? '',
                      lastNode: state.zoneMapData?.lastNodeName ?? '',
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> onTapRack({
    required EMapZone eMapZone,
    required EMapRack eMapRack,
  }) async {
    final lastNodeName =
        eMapZone.widgets.firstWhereOrNull((e) => e.lastNodeName.isNotEmpty);
    final rackType = eMapRack.rackType;
    if (eMapRack.isJIT) {
      await Duration.zero.delay(() async {
        context.router.pop(eMapRack.rackCode);
      });
    } else {
      await Duration.zero.delay(() async {
        final res = await context.pushRoute(RackDetailRoute(
          rackId: eMapRack.rackId ?? 0,
          receivingCardId: receivingCardId,
          eMapNavigateFunction: eMapNavigateFunction,
          lastNodeName: lastNodeName?.lastNodeName ?? '',
        ));
        if (res != null && res is OffsetBlockDetail) {
          await Duration.zero.delay(() async {
            context.router.pop(res.location);
          });
        }
      });
    }
  }
}
