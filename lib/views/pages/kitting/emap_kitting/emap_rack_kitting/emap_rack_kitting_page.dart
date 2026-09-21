import 'dart:ui' as ui;

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/e_map/emap_rack.dart';
import 'package:smart_warehouse/entities/kitting/kitting_detail.dart';
import 'package:smart_warehouse/gen/assets.gen.dart';
import 'package:smart_warehouse/shared/constants.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';
import 'package:smart_warehouse/shared/utils/map_asset_icons.dart';
import 'package:smart_warehouse/views/pages/emap/pallet_detail/pallet_detail_controller.dart';
import 'package:sprintf/sprintf.dart';

class EmapRackKittingPage extends StatelessWidget {
  const EmapRackKittingPage({
    super.key,
    required this.rack,
    required this.listKittingDetails,
  });

  final EMapRack rack;
  final List<KittingDetail> listKittingDetails;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Thông tin Rack ${rack.rackCode}')),
      body: DrawRack3DView(rackData: rack, kittingDetails: listKittingDetails),
    );
  }
}

class DrawRack3DView extends StatelessWidget {
  const DrawRack3DView({
    super.key,
    required this.rackData,
    required this.kittingDetails,
  });

  final EMapRack rackData;
  final List<KittingDetail> kittingDetails;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: Rack3DViewPainter(
        rackData: rackData,
        kittingDetails: kittingDetails,
      ),
    );
  }
}

class Rack3DViewPainter extends CustomPainter {
  Rack3DViewPainter({
    super.repaint,
    required this.rackData,
    required this.kittingDetails,
  });

  final EMapRack rackData;
  final List<KittingDetail> kittingDetails;

  @override
  void paint(Canvas canvas, Size size) {
    final numberOfLayer = rackData.numberOfLayer.value<int>();
    final numberOfUnit = rackData.numberOfUnit.value<int>();

    if (numberOfUnit > 9) {
      canvas.scale(0.14);
    } else if (numberOfUnit > 7) {
      canvas.scale(0.18);
    } else {
      canvas.scale(0.20 + (7 - numberOfUnit) * 0.03);
    }

    var textPainter = TextPainter();
    var paint = Paint();

    textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    final listPointColumn = <DrawDiagonal>[];

    // Draw behind column
    var offSetBCX1 = 150.0;
    var offSetBCX2 = 350.0;
    var offSetBCY1 = 750.0;
    var offSetBCY2 = 650.0;

    paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 5.0
      ..style = PaintingStyle.fill;



    for (var row = 0; row < numberOfLayer; row++) {
      for (var i = 0; i < numberOfUnit; i++) {
        canvas.drawLine(
          Offset(offSetBCX1, offSetBCY1),
          Offset(offSetBCX1, offSetBCY2),
          paint,
        );
        canvas.drawLine(
          Offset(offSetBCX2, offSetBCY1),
          Offset(offSetBCX2, offSetBCY2),
          paint,
        );

        // Draw diagonal
        listPointColumn.add(
          DrawDiagonal(
            startX: offSetBCX1,
            startY: offSetBCY1,
          ),
        );
        listPointColumn.add(
          DrawDiagonal(
            startX: offSetBCX1,
            startY: offSetBCY2,
          ),
        );

        if (i == numberOfUnit - 1) {
          listPointColumn.add(
            DrawDiagonal(
              startX: offSetBCX2,
              startY: offSetBCY2,
            ),
          );
        }
        offSetBCX1 = offSetBCX1 + 200;
        offSetBCX2 = offSetBCX2 + 200;
      }

      offSetBCY1 = offSetBCY1 - 100;
      offSetBCY2 = offSetBCY2 - 100;
      offSetBCX1 = 150;
      offSetBCX2 = 350;
    }

    // Draw behind row
    var offSetBRX1 = 150.0;
    var offSetBRX2 = 350.0;
    var offSetBRY1 = 650.0;

    paint = Paint()
      ..color = Colors.deepOrange
      ..strokeWidth = 5.0
      ..style = PaintingStyle.fill;

    for (var row = 0; row < numberOfLayer.value(); row++) {
      for (var i = 0; i < numberOfUnit.value(); i++) {
        canvas.drawLine(
          Offset(offSetBRX1, offSetBRY1),
          Offset(offSetBRX2, offSetBRY1),
          paint,
        );

        offSetBRX1 = offSetBRX1 + 200;
        offSetBRX2 = offSetBRX2 + 200;
      }
      offSetBRY1 = offSetBRY1 - 100;
      offSetBRX1 = 150;
      offSetBRX2 = 350;
    }

    // Draw Diagonal
    paint = Paint()
      ..color = Colors.purple
      ..strokeWidth = 5.0
      ..style = PaintingStyle.fill;
    for (var i = 0; i < listPointColumn.length; i++) {
      canvas.drawLine(
        Offset(
          listPointColumn[i].startX!,
          listPointColumn[i].startY!,
        ),
        Offset(
          listPointColumn[i].startX! + 100,
          listPointColumn[i].startY! + 100,
        ),
        paint,
      );
    }

    // Draw container
    var offSetConX1 = 250.0;
    var offSetConY1 = 750.0;

    for (var row = 0; row < numberOfLayer.value(); row++) {
      for (var i = 0; i < numberOfUnit.value(); i++) {
        paint = Paint()
          ..color = Colors.white.withOpacity(0.8)
          ..style = PaintingStyle.fill;

        canvas.drawRect(
          Offset(offSetConX1, offSetConY1) & const Size(200, 100),
          paint,
        );

        offSetConX1 = offSetConX1 + 200;
      }

      offSetConY1 = offSetConY1 - 100;
      offSetConX1 = 250;
    }

    // Draw Column
    var offSetCX1 = 250.0;
    var offSetCX2 = 450.0;
    var offSetCY1 = 750.0;
    var offSetCY2 = 850.0;

    paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 5.0
      ..style = PaintingStyle.fill;

    for (var row = 0; row < numberOfLayer.value(); row++) {
      for (var i = 0; i < numberOfUnit.value(); i++) {
        canvas.drawLine(
          Offset(offSetCX1, offSetCY1),
          Offset(offSetCX1, offSetCY2),
          paint,
        );
        canvas.drawLine(
          Offset(offSetCX2, offSetCY1),
          Offset(offSetCX2, offSetCY2),
          paint,
        );

        offSetCX1 = offSetCX1 + 200;
        offSetCX2 = offSetCX2 + 200;
      }

      offSetCY1 = offSetCY1 - 100;
      offSetCY2 = offSetCY2 - 100;
      offSetCX1 = 250;
      offSetCX2 = 450;
    }

    // Draw row
    var offSetRX1 = 250.0;
    var offSetRX2 = 450.0;
    var offSetRY1 = 750.0;

    paint = Paint()
      ..color = Colors.deepOrange
      ..strokeWidth = 5.0
      ..style = PaintingStyle.fill;

    for (var row = 0; row < numberOfLayer.value(); row++) {
      for (var i = 0; i < numberOfUnit.value(); i++) {
        canvas.drawLine(
          Offset(offSetRX1, offSetRY1),
          Offset(offSetRX2, offSetRY1),
          paint,
        );

        final shortBlockName = sprintf('%d.%02d', [row + 1, i + 1]);

        // Draw PL
        final position = Offset(
          offSetRX1 + 25,
          offSetRY1 + 25,
        );

        final kittingDetailsInPos = kittingDetails.where((element) => (element.locationName?.contains('${rackData.rackCode}.$shortBlockName') ?? false) && element.pickedQuantity < element.quantity);

        if (kittingDetailsInPos.isNotEmpty) {
          paint = Paint()
            ..color = kittingDetailsInPos.every((element) => element.pickedQuantity == element.quantity) ? Colors.green.withOpacity(0.8) :  Colors.yellow.withOpacity(0.8)
            ..style = PaintingStyle.fill;

          canvas.drawRect(
            Offset(offSetRX1, offSetRY1) & const Size(200, 100),
            paint,
          );
        }

        if (kittingDetailsInPos.any((element) => element.pl == 'PL')) {
          _drawIcon(canvas, size, position);
        }

        textPainter.text = TextSpan(
          text: shortBlockName,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
        );

        textPainter.layout();
        textPainter.paint(canvas, position);

        offSetRX1 = offSetRX1 + 200;
        offSetRX2 = offSetRX2 + 200;
      }

      offSetRY1 = offSetRY1 - 100;
      offSetRX1 = 250;
      offSetRX2 = 450;
    }

    textPainter.text = TextSpan(
      text: 'Rack name: ${rackData.rackCode ?? ''}',
      style: const TextStyle(
        color: Colors.black,
        fontSize: 60,
        fontWeight: FontWeight.w700,
      ),
    );

    const position = Offset(360, 950);

    textPainter.layout();
    textPainter.paint(canvas, position);
  }

  // Draw Icon
  void _drawIcon(Canvas canvas, Size size, Offset offset) {
    final assetIcons = getIt<MapAssetIcons>();
    ui.Image? image;
    image = assetIcons.icPL;

    canvas.drawImageRect(
      image,
      Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      Rect.fromLTWH(offset.dx + 100, offset.dy, 65, 65),
      Paint(),
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
