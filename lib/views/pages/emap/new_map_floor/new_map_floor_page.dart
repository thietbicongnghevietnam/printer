import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/entities/e_map/emap_kiting_suggest.dart';
import 'package:smart_warehouse/entities/e_map/emap_zone.dart';
import 'package:smart_warehouse/enums/emap_navigate_funciton.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/extensions/duration_extensions.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';
import 'package:smart_warehouse/views/pages/emap/map_widgets/button_back_emap.dart';
import 'package:smart_warehouse/views/pages/emap/map_widgets/draw_emap_note.dart';
import 'package:smart_warehouse/views/pages/emap/map_widgets/layout_map.dart';

import 'new_map_floor_controller.dart';
import 'new_map_floor_state.dart';

@RoutePage()
class NewMapFloorPage
    extends BasePage<NewMapFloorController, NewMapFloorState> {
  const NewMapFloorPage({
    super.key,
    this.receivingCardId,
    this.material,
    this.eMapNavigateFunction = EMapNavigateFunction.storing,
    this.plant,
    this.sloc,
    this.category,
    this.startTime,
    this.endTime,
    this.qtyKitting,
    this.blockLocations = const [],
  });

  final int? receivingCardId;
  final int? startTime;
  final int? endTime;

  final String? material;
  final String? plant;
  final String? sloc;
  final String? category;

  final double? qtyKitting;

  final EMapNavigateFunction eMapNavigateFunction;

  final List<String> blockLocations;

  @override
  BasePageState createState() => _FloorDetailPageState(
        eMapNavigateFunction: eMapNavigateFunction,
      );
}

class _FloorDetailPageState
    extends BasePageState<NewMapFloorController, NewMapFloorState> {
  _FloorDetailPageState({
    required this.eMapNavigateFunction,
  });

  final EMapNavigateFunction eMapNavigateFunction;

  @override
  void initState() {
    super.initState();
    final receivingCardId = widget.as<NewMapFloorPage>()?.receivingCardId;
    final material = widget.as<NewMapFloorPage>()?.material;
    final plant = widget.as<NewMapFloorPage>()?.plant;
    final sloc = widget.as<NewMapFloorPage>()?.sloc;
    final category = widget.as<NewMapFloorPage>()?.category;
    final startTime = widget.as<NewMapFloorPage>()?.startTime;
    final endTime = widget.as<NewMapFloorPage>()?.endTime;
    final qtyKitting = widget.as<NewMapFloorPage>()?.qtyKitting;
    context.read<NewMapFloorController>().initialLoadEMap(
          receivingCardId: receivingCardId,
          material: material,
          plant: plant,
          sloc: sloc,
          category: category,
          startTime: startTime,
          endTime: endTime,
          qtyKitting: qtyKitting,
          eMapNavigateFunction: eMapNavigateFunction,
      blockLocations: widget.as<NewMapFloorPage>()?.blockLocations,
        );

    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.landscapeRight,
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.landscapeLeft,
    // ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    super.dispose();
  }

  @override
  Widget builder(context, cubit, state) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: _buildListFloor(cubit),
        body: BlocBuilder<NewMapFloorController, NewMapFloorState>(
          buildWhen: (prev, current) {
            return prev.floorUIData != current.floorUIData ||
                prev.emapKittingSuggest != current.emapKittingSuggest;
          },
          builder: (context, state) {
            final totalQtyStore = state.floorUIData?.totalStoredQty ?? 0;
            final totalTemp = state.floorUIData?.totalTemp ?? 0;
            final suggestKittingMap = state.emapKittingSuggest;
            return Stack(
              children: [
                if (state.floorUIData != null)
                  LayoutMap(
                    eMapChildWidget: state.floorUIData!,
                    reOffsetX: 1500,
                    reOffsetY: 2000,
                    totalStorageQty: totalQtyStore,
                    totalTempQty: totalTemp,
                    areaName: state.floorUIData?.floorName ?? '',
                    lastNode: state.floorUIData?.lastNodeName ?? '',
                    eMapNavigateFunction: eMapNavigateFunction,
                    suggestKittingMap: suggestKittingMap,
                    onTapWidget: (eMapWidget) async {
                      if (eMapWidget is EMapZone) {
                        if (eMapWidget.widgets.isNotEmpty) {
                          if (eMapWidget.isJIT) {
                            await Duration.zero.delay(() async {
                              context.router.maybePop(eMapWidget.zoneName);
                            });
                          } else {
                            await Duration.zero.delay(() async {
                              final res = await context.pushRoute(
                                NewMapZoneRoute(
                                  zoneData: eMapWidget,
                                  totalStoreQty: totalQtyStore,
                                  totalTempQty: totalTemp,
                                  receivingCardId: widget
                                      .as<NewMapFloorPage>()
                                      ?.receivingCardId,
                                  eMapNavigateFunction: eMapNavigateFunction,
                                ),
                              );
                              if (res != null && res is String) {
                                await Duration.zero.delay(() async {
                                  context.router.maybePop(res);
                                });
                              }
                            });
                          }
                        }
                      }
                    },
                  )
                else
                  Center(
                    child: const Text(LocaleKeys.error_do_not_have_data).tr(),
                  ),
                const ButtonBackEMap(),
                if (state.floorUIData != null)
                  Positioned(
                    top: 5,
                    right: 5,
                    child: DrawEMapNote(
                      eMapChildWidget: state.floorUIData!,
                      totalStorageQty: totalQtyStore,
                      totalTempQty: totalTemp,
                      areaName: state.floorUIData?.floorName ?? '',
                      lastNode: state.floorUIData?.lastNodeName ?? '',
                    ),
                  ),
              ],
            );
          },
        ),
        // bottomNavigationBar: _buildMapNote(),
      ),
    );
  }

  Widget _buildListFloor(NewMapFloorController cubit) {
    return BlocBuilder<NewMapFloorController, NewMapFloorState>(
      buildWhen: (prev, current) => prev.floorList != current.floorList,
      builder: (context, state) {
        final floorData = state.floorList;
        if (floorData.isEmpty) {
          return const SizedBox.shrink();
        }
        return SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: 50,
          child: Center(
            child: ListView.separated(
              itemCount: floorData.length,
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(vertical: 5),
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: () {
                    cubit.onChangeFloor(floorChange: floorData[i]);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff0370C8),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 10,
                    ),
                    child: Center(
                      child: Text(
                        '${floorData[i].floorName ?? floorData[i].floorId}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(width: 15),
            ),
          ),
        );
      },
    );
  }
}
