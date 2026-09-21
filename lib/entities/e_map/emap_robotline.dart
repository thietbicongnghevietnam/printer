import 'package:smart_warehouse/entities/e_map/emap_widget.dart';

class EMapRobotLine extends EMapWidget {
  EMapRobotLine({
    required super.x,
    required super.y,
    required super.width,
    required super.height,
    super.fill,
    super.widgets = const [],
    super.points = const [],
    super.lastNodeName,
  });

}
