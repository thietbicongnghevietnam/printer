import 'package:smart_warehouse/entities/e_map/emap_widget.dart';

class EMapFloor extends EMapWidget {
  EMapFloor({
    this.floorId,
    this.floorName,
    required super.x,
    required super.y,
    required super.width,
    required super.height,
    super.fill,
    super.widgets = const [],
    super.points = const [],
    super.lastNodeName,
    this.totalStoredQty,
    this.totalTemp,
  });

  final int? floorId;
  int? totalStoredQty;
  int? totalTemp;

  final String? floorName;
}
