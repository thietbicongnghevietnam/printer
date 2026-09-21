import 'package:smart_warehouse/entities/e_map/emap_floor.dart';
import 'package:smart_warehouse/entities/e_map/emap_line.dart';
import 'package:smart_warehouse/entities/e_map/emap_rack.dart';
import 'package:smart_warehouse/entities/e_map/emap_widget.dart';
import 'package:smart_warehouse/entities/e_map/emap_zone.dart';
import 'package:smart_warehouse/enums/map_item_type.dart';
import 'package:smart_warehouse/enums/rack_type.dart';
import 'package:smart_warehouse/services/models/response/new_map_widget_response_model.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';

extension BoundingBoxTranslator on BoundingBoxResponse {
  BoundingBox toEntity() {
    return BoundingBox(
      x: x,
      y: y,
      width: width,
      height: height,
    );
  }
}

extension FloorTranslator on NewMapWidgetResponseModel {
  EMapFloor toFloor() {
    return EMapFloor(
      floorId: floorId.value(),
      floorName: floorName.value(),
      x: x ?? 0,
      y: y ?? 0,
      width: width ?? 0,
      height: height ?? 0,
      fill: fill,
      widgets: widgets
              ?.map(
                (e) => switch (WidgetMapType.fromCode(e.type ?? 0)) {
                  WidgetMapType.zone => e.toZone(),
                  // WidgetMapType.rectangle => e.toZone(),
                  _ => e.toWidget(),
                },
              )
              .toList() ??
          [],
    );
  }

  EMapZone toZone() {
    return EMapZone(
      zoneId: zoneId ?? 0,
      zoneName: zoneName ?? '',
      isJIT: isJIT ?? false,
      x: x ?? 0,
      y: y ?? 0,
      width: width ?? 0,
      height: height ?? 0,
      fill: fill,
      borderWidth: borderWidth,
      border: border,
      scaleX: scaleX ?? 0,
      scaleY: scaleY ?? 0,
      rotation: rotation ?? 0,
      type: WidgetMapType.fromCode(type ?? 0),
      widgets: widgets
              ?.map(
                (e) => switch (WidgetMapType.fromCode(e.type ?? 0)) {
                  WidgetMapType.rack => e.toRack(),
                  // WidgetMapType.rectangle => e.toZone(),
                  _ => e.toWidget(),
                },
              )
              .toList() ??
          [],
      label: label ?? '',
      data: data ?? '',
    );
  }

  EMapRack toRack() {
    return EMapRack(
      x: x ?? 0,
      y: y ?? 0,
      width: width ?? 0,
      height: height ?? 0,
      rackId: rackID,
      rackCode: rackCode ?? '',
      category: category ?? '',
      isJIT: isJIT ?? false,
      rackType: RackType.fromRackType(rackType ?? 'Big part'),
      rackTypeDetail: rackTypeDetail ?? '',
      numberOfUnit: numberOfUnit ?? 0,
      numberOfLayer: numberOfLayer ?? 0,
      scaleX: scaleX ?? 0,
      scaleY: scaleY ?? 0,
      rotation: rotation ?? 0,
      type: WidgetMapType.fromCode(type ?? 0),
      label: label ?? '',
      borderWidth: borderWidth,
      border: border,
      fill: fill,
      data: data,
      pl: pl ?? '',
      boundingBox: boundingBox?.toEntity(),
      widgets: widgets
              ?.map(
                (e) => switch (WidgetMapType.fromCode(e.type ?? 0)) {
                  WidgetMapType.rack => e.toRack(),
                  WidgetMapType.rectangle => e.toZone(),
                  WidgetMapType.zone => e.toZone(),
                  _ => e.toWidget(),
                },
              )
              .toList() ??
          [],
    );
  }

  EMapWidget toWidget() {
    return EMapWidget(
      x: x ?? 0,
      y: y ?? 0,
      width: width ?? 0,
      height: height ?? 0,
      type: WidgetMapType.fromCode(type ?? 0),
      scaleX: scaleX ?? 0,
      scaleY: scaleY ?? 0,
      rotation: rotation ?? 0,
      label: label ?? '',
      data: data ?? '',
      borderWidth: borderWidth,
      border: border,
      fill: fill,
      fontSize: fontSize?.toDouble(),
    );
  }

  EMapWidget toLine() {
    return EMapLine(
      x: x ?? 0,
      y: y ?? 0,
      width: width ?? 0,
      height: height ?? 0,
      fill: fill,
    );
  }
}
