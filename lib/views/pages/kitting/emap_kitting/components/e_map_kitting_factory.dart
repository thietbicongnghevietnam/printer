import 'package:flutter/material.dart';
import 'package:smart_warehouse/entities/e_map/emap_floor.dart';
import 'package:smart_warehouse/entities/e_map/emap_widget.dart';
import 'package:smart_warehouse/enums/map_item_type.dart';
import 'package:smart_warehouse/services/models/response/new_map_widget_response_model.dart';

import 'e_map_kitting_floor.dart';
import 'e_map_kitting_label.dart';
import 'e_map_kitting_rack.dart';
import 'e_map_kitting_rectangle.dart';
import 'e_map_kitting_zone.dart';

class EmapKittingFactory {
  final Canvas canvas;

  EmapKittingFactory({required this.canvas});

  void build(EMapWidget widget, {Offset? parentPosition}) {
    final param = EmapKittingParam(
        canvas: canvas,
        widget: widget,
        parentPosition: parentPosition,
    );
    switch (widget.type) {
      case WidgetMapType.floor:
        EmapKittingFloor(param).build();
      case WidgetMapType.zone:
        EmapKittingZone(param).build();
      case WidgetMapType.rack:
        EmapKittingRack(param).build();
      case WidgetMapType.rectangle:
        EmapKittingRectangle(param).build();
      case WidgetMapType.text:
        EmapKittingLabel(param).build();
      default:
    }

    for (final element in widget.widgets) {
      build(element, parentPosition: Offset(widget.x, widget.y));
    }
  }
}

class EmapKittingParam {
  final Canvas canvas;
  final EMapWidget widget;
  final Offset? parentPosition;

  EmapKittingParam({
    required this.canvas,
    required this.widget,
    required this.parentPosition,
  });
}

abstract class IEmapKitting {
  final EmapKittingParam param;

  IEmapKitting(this.param);

  void build();
}
