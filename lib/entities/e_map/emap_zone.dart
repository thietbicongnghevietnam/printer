import 'package:smart_warehouse/entities/e_map/emap_widget.dart';

class EMapZone extends EMapWidget {
  EMapZone({
    this.zoneId,
    required super.x,
    required super.y,
    required super.width,
    required super.height,
    required super.fill,
    required super.type,
    required super.scaleX,
    required super.scaleY,
    required super.rotation,
    super.border,
    super.borderWidth,
    super.fontSize,
    super.label,
    super.widgets,
    super.points,
    super.data,
    super.lastNodeName,
    this.isSuggested = false,
    this.isJIT = false,
    this.zoneName = '',
    this.isDIP = false,
  });

  final int? zoneId;

  String zoneName;

  bool isSuggested;
  bool isJIT;
  bool isDIP;
}
