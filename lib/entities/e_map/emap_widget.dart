import 'package:smart_warehouse/enums/map_item_type.dart';
import 'package:smart_warehouse/services/models/response/suggest_path_response_model.dart';

class BoundingBox {

  BoundingBox({
    required this.x,
    required this.y,
    required this.width,
    required this.height,
  });
  final double x;
  final double y;
  final double width;
  final double height;
}

class EMapWidget {
  EMapWidget( {
    required this.x,
    required this.y,
    this.width = 0,
    this.height = 0,
    this.type,
    this.scaleX = 1,
    this.scaleY = 1,
    this.rotation = 0,
    this.border,
    this.fill,
    this.points = const [],
    this.label,
    this.fontSize,
    this.borderWidth,
    this.widgets = const [],
    this.data,
    this.boundingBox,
    this.lastNodeName = '',
  });

  final double x;
  final double y;
  final double width;
  final double height;
  final double scaleX;
  final double scaleY;
  final double rotation;
  final double? fontSize;
  final double? borderWidth;

  final String? fill;
  final String? border;
  final String? label;
  final String? data;
  String lastNodeName;

  final WidgetMapType? type;
  final BoundingBox? boundingBox;
  final List<SuggestPathResponseModel> points;
  final List<EMapWidget> widgets;
}
