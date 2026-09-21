import 'package:smart_warehouse/entities/e_map/emap_widget.dart';

class EMapLine extends EMapWidget {
  EMapLine({
    required super.x,
    required super.y,
    required super.width,
    required super.height,
    super.fill,
    super.border,
    super.points = const [],
  });
}
