import 'dart:math';
import 'dart:ui' as ui;
import 'dart:ui';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:smart_warehouse/entities/e_map/emap_rack.dart';
import 'package:smart_warehouse/entities/e_map/emap_widget.dart';
import 'package:smart_warehouse/entities/e_map/order_block.dart';
import 'package:smart_warehouse/entities/e_map/suggest_path.dart';
import 'package:smart_warehouse/entities/kitting/kitting_detail.dart';
import 'package:smart_warehouse/shared/extensions/double_extensions.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';
import 'package:smart_warehouse/views/pages/emap/map_widgets/zoom_widget.dart';
import 'package:smart_warehouse/views/pages/kitting/emap_kitting/emap_rack_kitting/emap_rack_kitting_page.dart';

import 'e_map_kitting_factory.dart';

bool isSameLocation(String? block1, String? block2) {
  // Tách các block thành các phần tử con bằng dấu '.'
  List<String> parts1 = block1?.split('.') ?? [];
  List<String> parts2 = block2?.split('.') ?? [];

  // Kiểm tra độ dài để tránh lỗi khi phần tử thiếu
  if (parts1.length != 4 || parts2.length != 4) {
    return false;
  }

  // So sánh (1), (2) và (4) từ cả hai block
  return parts1[0] == parts2[0] &&
      parts1[1] == parts2[1] &&
      parts1[3] == parts2[3];
}

class EmapConfig {
  EmapConfig({
    final Offset initPosition = Offset.zero,
    this.initScale = 1,
    this.initTotalZoomOut = true,
  }) {
    this.initPosition =
        ui.Offset(initPosition.dx * initScale, initPosition.dy * initScale);
  }

  late Offset initPosition;
  final double initScale;
  final bool initTotalZoomOut;
}

class EmapKittingWidget extends StatefulWidget {
  const EmapKittingWidget({
    super.key,
    required this.floor,
    required this.orderBlock,
    required this.selectedLocations,
    required this.suggestPath,
    required this.listKittingDetails,
    this.config,
  });

  final EMapWidget floor;
  final List<OrderBlock> orderBlock;
  final List<String> selectedLocations;
  final List<SuggestPath> suggestPath;
  final List<KittingDetail> listKittingDetails;
  final EmapConfig? config;

  @override
  State<EmapKittingWidget> createState() => _EmapKittingWidgetState();
}

class _EmapKittingWidgetState extends State<EmapKittingWidget> {
  late EmapConfig _config;

  @override
  void initState() {
    _config = widget.config ?? EmapConfig();
    super.initState();
  }

  void _handleTapDown(TapDownDetails details) {
    final scale = _config.initScale;

    final tapPosition = ui.Offset(
        details.localPosition.dx / scale, details.localPosition.dy / scale);

    for (final zone in widget.floor.widgets) {
      for (final element in zone.widgets) {
        if (element is EMapRack) {
          final x = (element.boundingBox?.x ?? 0) + (_config.initPosition.dx);
          final y = (element.boundingBox?.y ?? 0) + (_config.initPosition.dx);
          final width = element.boundingBox?.width ?? 0;
          final height = element.boundingBox?.height ?? 0;

          if (tapPosition.dx.isBetween(x, x + width) &&
              tapPosition.dy.isBetween(y, y + height)) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => EmapRackKittingPage(
                  rack: element,
                  listKittingDetails: widget.listKittingDetails,
                ),
              ),
            );
            return;
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentWidth = widget.floor.width;
    final currentHeight = widget.floor.height;

    return ZoomMapWidget(
      maxScale: 10,
      scrollWeight: 4,
      colorScrollBars: Colors.orangeAccent.withOpacity(0.2),
      child: GestureDetector(
        onDoubleTapDown: _handleTapDown,
        child: RepaintBoundary(
          child: CustomPaint(
            isComplex: true,
            size: ui.Size(currentWidth, currentHeight),
            painter: EmapKitting(widget.floor, _config),
            foregroundPainter: SuggestEmapKitting(
              widget.orderBlock,
              widget.suggestPath,
              widget.selectedLocations,
              _config,
              widget.listKittingDetails,
            ),
          ),
        ),
      ),
    );
  }
}

class EmapKitting extends CustomPainter {
  EmapKitting(this.floor, this.config);

  final EMapWidget floor;
  final EmapConfig config;

  // Caching picture để không vẽ lại các phần tĩnh
  Picture? cachedPicture;

  @override
  void paint(Canvas canvas, Size size) {
    // Kiểm tra nếu offset hoặc scale chưa được khởi tạo đúng
    final Offset offset = config.initPosition ?? Offset.zero;
    final double scale = config.initScale ?? 1.0;

    // Chỉ ghi lại hình ảnh nếu chưa có hoặc khi cần vẽ lại
    if (cachedPicture == null) {
      // Sử dụng PictureRecorder để cache phần vẽ tĩnh
      final PictureRecorder recorder = PictureRecorder();
      final Canvas recCanvas = Canvas(recorder);

      recCanvas.translate(offset.dx, offset.dy);
      recCanvas.scale(scale, scale);

      // Vẽ các đối tượng lên recCanvas
      final factory = EmapKittingFactory(canvas: recCanvas);
      factory.build(floor);

      // Kết thúc ghi và lưu trữ hình ảnh
      cachedPicture = recorder.endRecording();
    }

    // Vẽ hình ảnh từ cachedPicture lên canvas chính
    canvas.drawPicture(cachedPicture!);
  }

  @override
  bool shouldRepaint(covariant EmapKitting oldDelegate) {
    // Chỉ vẽ lại nếu scale hoặc vị trí thay đổi
    if (oldDelegate.config.initScale != config.initScale ||
        oldDelegate.config.initPosition != config.initPosition) {
      // Xóa cache để vẽ lại nếu cần
      cachedPicture = null;
      return true;
    }
    return false;
  }
}

class SuggestEmapKitting extends CustomPainter {
  SuggestEmapKitting(
    this.orderBlock,
    this.suggestPath,
    this.selectedLocations,
    this.config,
    this.kittingDetails,
  );

  final List<OrderBlock> orderBlock;
  final List<SuggestPath> suggestPath;
  final List<KittingDetail> kittingDetails;
  final List<String> selectedLocations;
  final EmapConfig config;

  @override
  void paint(Canvas canvas, Size size) {
    final offset = config.initPosition;
    canvas.translate(offset.dx, offset.dy);
    canvas.scale(config.initScale, config.initScale);

    drawSuggestPath(canvas);
    drawKittingPoint(canvas);
    final selectedKittingPoints =
        orderBlock.where((element) => selectedLocations.contains(element.name));
    for (final element in selectedKittingPoints) {
      drawArrow(canvas, ui.Offset(element.x, element.y - element.height / 2));
    }
  }

  void drawSuggestPath(Canvas canvas) {
    final path = Path();

    // Start the path at the first point
    if (suggestPath.isNotEmpty) {
      path.moveTo((suggestPath[0].x) * 10, (suggestPath[0].y) * 10);
    }

    // Draw lines to subsequent points
    for (var i = 1; i < suggestPath.length; i++) {
      path.lineTo((suggestPath[i].x) * 10, (suggestPath[i].y) * 10);
    }

    final paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke;

    canvas.drawPath(path, paint);
  }

  void drawKittingPoint(Canvas canvas) {
    final backgroundPaint = Paint()..color = Colors.black;
    final selectedPaint = Paint()..color = Colors.orange;
    final kittingPaint = Paint()..color = Colors.green;
    orderBlock.forEachIndexed((index, element) {
      // logger.d(kittingDetails.where((e) => e.locationName == element.name).map((e) => '${e.pickedQuantity} ${e.quantity} ${e.pickedQuantity == e.quantity}').join(' -> '));

      // logger.d('${element.name}: ${kittingDetails
      //     .where((e) => isSameLocation(e.locationName, element.name))
      // .map((e) => '${e.pickedQuantity} == ${e.quantity}').join(' -> ')}');
      final paint = selectedLocations.contains(element.name)
          ? selectedPaint
          : kittingDetails
                  .where((e) => isSameLocation(e.locationName, element.name))
                  .every((e) => e.pickedQuantity.toInt() == e.quantity.toInt())
              ? kittingPaint
              : backgroundPaint;
      canvas.drawCircle(Offset(element.x, element.y),
          min(element.width, element.height) / 2 - 5, paint);
      TextPainter textPainter;
      textPainter = TextPainter(
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      
      final fontSize = element.width > 40 ? 30.0 : 16.0;

      textPainter.text = TextSpan(
        text: (index + 1).toString(),
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
        ),
      );

      textPainter.layout();
      textPainter.paint(canvas,
          ui.Offset(element.x - fontSize / 2, element.y - fontSize / 2));
    });
  }

  void drawArrow(Canvas canvas, ui.Offset pos) {
    final startPoint = ui.Offset(pos.dx, pos.dy - 40);
    final endPoint = ui.Offset(pos.dx, pos.dy);
    const arrowHeadSize = 20;
    const color = Colors.yellow;

    final paint = Paint()
      ..color = color
      ..strokeWidth = 4
      ..style = PaintingStyle.stroke;

    // Vẽ đường thẳng của mũi tên
    final path = Path();
    path.moveTo(startPoint.dx, startPoint.dy); // Điểm bắt đầu của mũi tên
    path.lineTo(endPoint.dx, endPoint.dy); // Điểm kết thúc của mũi tên

    // Tính toán góc và hướng của mũi tên
    const double arrowAngle = pi / 6; // Góc của tam giác đầu mũi tên (30 độ)
    final double arrowDirection = atan2(
      endPoint.dy - startPoint.dy,
      endPoint.dx - startPoint.dx,
    ); // Hướng của mũi tên

    final Offset arrowTip = endPoint.translate(0, 10); // Điểm đầu của mũi tên
    final Offset arrowLeft = Offset(
      arrowTip.dx - arrowHeadSize * cos(arrowDirection - arrowAngle),
      arrowTip.dy - arrowHeadSize * sin(arrowDirection - arrowAngle),
    );
    final Offset arrowRight = Offset(
      arrowTip.dx - arrowHeadSize * cos(arrowDirection + arrowAngle),
      arrowTip.dy - arrowHeadSize * sin(arrowDirection + arrowAngle),
    );

    // Vẽ đường thẳng của mũi tên
    canvas.drawPath(path, paint);

    // Vẽ đầu mũi tên (tam giác)
    final arrowPath = Path()
      ..moveTo(arrowTip.dx, arrowTip.dy)
      ..lineTo(arrowLeft.dx, arrowLeft.dy)
      ..lineTo(arrowRight.dx, arrowRight.dy)
      ..close();

    // Vẽ đầu mũi tên bằng `fill`
    canvas.drawPath(
      arrowPath,
      Paint()
        ..color = color
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(covariant SuggestEmapKitting oldDelegate) =>
      oldDelegate.config.initScale != config.initScale;
}
