import 'package:smart_warehouse/entities/e_map/emap_widget.dart';
import 'package:smart_warehouse/enums/rack_type.dart';

class EMapRack extends EMapWidget {
  EMapRack({
    required super.x,
    required super.y,
    required super.width,
    required super.height,
    super.fill,
    super.type,
    super.scaleX,
    super.scaleY,
    super.rotation,
    super.fontSize,
    super.label,
    super.border,
    super.borderWidth,
    super.data,
    super.lastNodeName,
    super.widgets,
    super.boundingBox,
    this.rackId,
    this.rackCode,
    this.category,
    this.rackType,
    this.rackTypeDetail,
    this.numberOfUnit,
    this.numberOfLayer,
    this.isSuggested = false,
    this.isJIT = false,
    this.pic = '',
    this.pl = '',
  });

  final int? rackId;
  final int? numberOfUnit;
  final int? numberOfLayer;

  final String? rackCode;
  final String? category;
  final String? rackTypeDetail;
  final String pic;
  final String pl;

  bool isSuggested;
  bool isJIT;

  final RackType? rackType;
}
