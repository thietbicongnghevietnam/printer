import 'package:flutter/material.dart';
import 'package:flutter_dash_border_animated/flutter_dash_border_animated.dart';
import 'package:smart_warehouse/entities/e_map/emap_kiting_suggest.dart';
import 'package:smart_warehouse/entities/e_map/emap_rack.dart';
import 'package:smart_warehouse/entities/e_map/emap_widget.dart';
import 'package:smart_warehouse/entities/e_map/emap_zone.dart';
import 'package:smart_warehouse/entities/e_map/order_block.dart';
import 'package:smart_warehouse/enums/emap_navigate_funciton.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:smart_warehouse/views/pages/emap/map_widgets/indoor_map_border.dart';
import 'package:smart_warehouse/views/pages/emap/map_widgets/map_item_transition.dart';
import 'package:smart_warehouse/views/pages/emap/map_widgets/zoom_widget.dart';

import 'draw_kitting_way.dart';
import 'draw_map_item.dart';

typedef LayoutMapCallback = void Function(EMapWidget widget);

class LayoutMap extends StatelessWidget {
  const LayoutMap({
    super.key,
    required this.eMapChildWidget,
    this.eMapNavigateFunction = EMapNavigateFunction.storing,
    required this.reOffsetX,
    required this.reOffsetY,
    this.onTapWidget,
    this.totalStorageQty = 0,
    this.totalTempQty = 0,
    this.areaName = '',
    this.lastNode = '',
    this.fromZoneMap = false,
    this.suggestKittingMap,
  });

  final EMapWidget eMapChildWidget;
  final EMapNavigateFunction eMapNavigateFunction;

  final double reOffsetX;
  final double reOffsetY;

  final bool fromZoneMap;

  final int totalTempQty;
  final int totalStorageQty;

  final String areaName;
  final String lastNode;

  final LayoutMapCallback? onTapWidget;
  final EMapKittingSuggest? suggestKittingMap;

  @override
  Widget build(BuildContext context) {
    final currentWidth = eMapChildWidget.width;
    final currentHeight = eMapChildWidget.height;
    final maxZoomWidth = (fromZoneMap ? 1000 : 3000) + currentWidth;
    final maxZoomHeight = (fromZoneMap ? 2000 : 4000) + currentHeight;

    return ZoomMapWidget(
      maxZoomWidth: maxZoomWidth,
      maxZoomHeight: maxZoomHeight,
      initTotalZoomOut: true,
      initScale: 0,
      initPosition: Offset(maxZoomWidth / 2, maxZoomHeight / 2),
      colorScrollBars: Colors.orangeAccent.withOpacity(0.2),
      child: Stack(
        children: [
          IndoorMapBorder(
            mapHeight: currentHeight,
            mapWidth: currentWidth,
            offsetX: reOffsetX,
            offsetY: reOffsetY,
          ),
          if (eMapChildWidget.widgets.isNotEmpty) ..._buildMapItems(context),
        ],
      ),
    );
  }

  List<Widget> _buildMapItems(BuildContext context) {
    final zoneWidgets = eMapChildWidget;
    var mapWidgets = <Widget>[];

    if (zoneWidgets is EMapZone) {
      for (final rack in zoneWidgets.widgets) {
        if (rack is EMapRack) {
          final newItemX = rack.x + reOffsetX;
          final newItemY = rack.y + reOffsetY;

          var widthTap = rack.width;
          var heightTap = rack.height;
          var offsetXTap = newItemX;
          var offsetYTap = newItemY;
          if (rack.rotation != null) {
            if (rack.rotation! >= 89 && rack.rotation! <= 91) {
              widthTap = rack.height;
              heightTap = rack.width;
              offsetXTap = newItemX - (rack.height);
            } else if (rack.rotation! <= -89 && rack.rotation! >= -91) {
              widthTap = rack.height;
              heightTap = rack.width;
              offsetYTap = newItemY - (rack.width);
            } else if ((rack.rotation! <= 181 && rack.rotation! >= 179) ||
                (rack.rotation! >= -181 && rack.rotation! <= -179)) {
              offsetXTap = newItemX - (rack.width );
              offsetYTap = newItemY - (rack.height);
            }
          }

          if (rack.isSuggested &&
              !(eMapNavigateFunction == EMapNavigateFunction.kitting)) {
            mapWidgets.add(
              _buildDashAnimatedWidget(
                offsetX: offsetXTap,
                offsetY: offsetYTap,
                newWidth: widthTap,
                newHeight: heightTap,
                context: context,
              ),
            );
          }

          mapWidgets.add(
            RepaintBoundary(
              child: DrawMapItem(
                newX: newItemX,
                newY: newItemY,
                widgetMap: rack,
                label: rack.rackCode ?? '',
                rackUnit: rack.numberOfUnit,
              ),
            ),
          );

          _buildSuggestColumnWidgets(
            context,
            mapWidgets,
            rack,
            offsetXTap,
            offsetYTap,
            widthTap,
            heightTap,
          );

          mapWidgets.add(
            _onTapZone(
              offsetX: offsetXTap,
              offsetY: offsetYTap,
              mapData: rack,
              widthTap: widthTap,
              heightTap: heightTap,
            ),
          );
        } else {
          final newItemX = rack.x + reOffsetX;
          final newItemY = rack.y + reOffsetY;

          mapWidgets.add(
            DrawMapItem(
              newX: newItemX,
              newY: newItemY,
              widgetMap: rack,
              label: rack.label ?? '',
            ),
          );
        }
      }
    } else {
      for (final zone in zoneWidgets.widgets) {
        final newItemX = zone.x + reOffsetX;
        final newItemY = zone.y + reOffsetY;

        mapWidgets.add(
          RepaintBoundary(
            child: DrawMapItem(
              newX: newItemX,
              newY: newItemY,
              widgetMap: zone,
            ),
          ),
        );

        if (zone is EMapZone) {
          if (zone.isSuggested) {
            mapWidgets.add(
              _buildDashAnimatedWidget(
                offsetX: newItemX,
                offsetY: newItemY,
                newWidth: zone.width,
                newHeight: zone.height,
                context: context,
              ),
            );
          }

          if (zone.lastNodeName.isNotEmpty && zone.lastNodeName != '') {
            mapWidgets.add(
              _buildDashAnimatedWidget(
                offsetX: newItemX,
                offsetY: newItemY,
                newWidth: zone.width,
                newHeight: zone.height,
                context: context,
                isLastNode: true,
              ),
            );
          }

          mapWidgets.add(
            RepaintBoundary(
              child: DrawMapItem(
                newX: newItemX,
                newY: newItemY,
                widgetMap: zone,
                label: zone.zoneName,
              ),
            ),
          );

          for (final itemInZone in zone.widgets) {
            final newItemX = (itemInZone.x + reOffsetX) + zone.x;
            final newItemY = (itemInZone.y + reOffsetY) + zone.y;

            mapWidgets.add(
              RepaintBoundary(
                child: DrawMapItem(
                  newX: newItemX,
                  newY: newItemY,
                  widgetMap: itemInZone,
                ),
              ),
            );

            if (itemInZone is EMapRack) {
              mapWidgets.add(
                RepaintBoundary(
                  child: DrawMapItem(
                    newX: newItemX,
                    newY: newItemY,
                    widgetMap: itemInZone,
                    label: itemInZone.rackCode ?? '',
                    rackUnit: itemInZone.numberOfUnit,
                  ),
                ),
              );

              if (eMapNavigateFunction == EMapNavigateFunction.kitting) {
                _buildSuggestColumnWidgets(
                  context,
                  mapWidgets,
                  itemInZone,
                  newItemX,
                  newItemY,
                  itemInZone.width,
                  itemInZone.height,
                );
              }
            }
          }
        }

        /// Suggest Kitting's way
        final pathLocation = suggestKittingMap?.suggestPath;
        if (pathLocation != null && pathLocation.isNotEmpty) {
          mapWidgets.add(
            RepaintBoundary(
              child: DrawKittingWay(
                lineData: pathLocation,
                lineColor: Colors.yellow.withOpacity(0.6),
                lineWidth: 8,
                reOffsetX: reOffsetX,
                reOffsetY: reOffsetY,
              ),
            ),
          );
        }

        /// Draw block suggest
        final blockLocation = suggestKittingMap?.orderBlock;

        if (blockLocation != null && blockLocation.isNotEmpty) {
          drawBlockSuggestForKiting(
            reOffsetX: reOffsetX,
            reOffsetY: reOffsetY,
            mapWidgets: mapWidgets,
            context: context,
            blockList: blockLocation,
          );
        }

        if (zone.width > 0 && zone.height > 0) {
          mapWidgets.add(
            _onTapZone(
              offsetX: newItemX,
              offsetY: newItemY,
              mapData: zone,
              widthTap: zone.width,
              heightTap: zone.height,
            ),
          );
        }
      }
    }
    return mapWidgets;
  }

  void drawBlockSuggestForKiting({
    required double reOffsetX,
    required double reOffsetY,
    required List<OrderBlock> blockList,
    required List<Widget> mapWidgets,
    required BuildContext context,
  }) {
    for (var i = 0; i < blockList.length; i++) {
      final newX = (blockList[i].x ?? 0) + reOffsetX;
      final newY = (blockList[i].y ?? 0) + reOffsetY;

      mapWidgets.add(
        RepaintBoundary(
          child: MapItemTransition(
              offsetX: newX,
              offsetY: newY,
              child: Text(
                '${i + 1}',
                style: const TextStyle(
                  color: Colors.yellow,
                  fontWeight: FontWeight.w600,
                  backgroundColor: Colors.red,
                  fontSize: 80,
                ),
              )),
        ),
      );
    }
  }

  void _buildSuggestColumnWidgets(
    BuildContext context,
    List<Widget> mapWidgets,
    EMapRack rack,
    double offsetXTap,
    double offsetYTap,
    double widthTap,
    double heightTap,
  ) {
    if (rack.lastNodeName.isNotEmpty && rack.lastNodeName != '') {
      double xColumn = offsetXTap;
      double yColumn = offsetYTap;
      double blockWidth = (rack.width) / (rack.numberOfUnit ?? 1);
      double blockHeight = rack.height;
      int columnTotal = rack.numberOfUnit ?? 1;

      List<String> lastNodeList = rack.lastNodeName.contains(';')
          ? rack.lastNodeName.split(';')
          : [rack.lastNodeName];

      for (final block in lastNodeList) {
        int columnOfBlock = block.substring(block.length - 1).toInt();

        xColumn = offsetXTap + (blockWidth * columnOfBlock) - blockWidth;
        if (rack.rotation != null) {
          if (rack.rotation! >= 89 && rack.rotation! <= 91) {
            yColumn = offsetYTap + (blockWidth * columnOfBlock) - blockWidth;
            xColumn = offsetXTap;
          } else if (rack.rotation! <= -89 && rack.rotation! >= -91) {
            xColumn = offsetXTap - blockWidth;
          } else if ((rack.rotation! <= 181 && rack.rotation! >= 179) ||
              (rack.rotation! >= -181 && rack.rotation! <= -179)) {
            xColumn = offsetXTap + (blockWidth * (columnTotal - columnOfBlock));
            yColumn = offsetYTap;
          } else if (rack.rotation! >= -181 && rack.rotation! <= -179) {
            xColumn = offsetXTap - (blockWidth * columnOfBlock);
            yColumn = offsetYTap - blockHeight;
          }
        }

        mapWidgets.add(
          _buildDashAnimatedWidget(
            offsetX: xColumn,
            offsetY: yColumn,
            newWidth: blockWidth,
            newHeight: blockHeight,
            context: context,
            isLastNode: true,
          ),
        );
      }
    }
  }

  Widget _onTapZone({
    required double offsetX,
    required double offsetY,
    required double widthTap,
    required double heightTap,
    required EMapWidget mapData,
  }) {
    return MapItemTransition(
      offsetX: offsetX,
      offsetY: offsetY,
      child: Container(
        color: Colors.transparent,
        width: widthTap,
        height: heightTap,
      ),
      onTap: () {
        onTapWidget?.call(mapData);
      },
    );
  }

  Widget _buildDashAnimatedWidget({
    required double offsetX,
    required double offsetY,
    required double newWidth,
    required double newHeight,
    double? dashSpace,
    double? dashWidth,
    double? strokeWidth,
    required BuildContext context,
    bool isLastNode = false,
  }) {
    return MapItemTransition(
      offsetX: offsetX,
      offsetY: offsetY,
      child: SizedBox(
        height: newHeight,
        width: newWidth,
        child: DashBorderAnimated(
          animatedSpeed: Duration(milliseconds: fromZoneMap ? 1000 : 500),
          dashWidth: dashWidth ?? (fromZoneMap ? 75 : 200.0),
          dashSpace: dashSpace ?? (fromZoneMap ? 30 : 100.0),
          strokeWidth: strokeWidth ?? (fromZoneMap ? 15 : 50),
          dashColor: isLastNode ? Colors.yellow : Colors.red,
        ),
      ),
    );
  }
}
