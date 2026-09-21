import 'dart:ui' as ui;

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/enums/rack_type.dart';
import 'package:smart_warehouse/services/models/response/layer_detail_response.dart';
import 'package:smart_warehouse/services/models/response/rack_detail_response_model.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:smart_warehouse/shared/utils/map_asset_icons.dart';
import 'package:smart_warehouse/views/pages/emap/rack_detail/rack_detail_controller.dart';

class DrawRack3DView extends StatelessWidget {
  const DrawRack3DView({
    super.key,
    this.rackData,
    this.rackType,
  });

  final RackDetailResponseModel? rackData;
  final RackType? rackType;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: Rack3DViewPainter(
        rackData: rackData,
      ),
    );
  }
}

class Rack3DViewPainter extends CustomPainter {
  Rack3DViewPainter({
    super.repaint,
    required this.rackData,
  });

  final RackDetailResponseModel? rackData;

  Color statusColor(bool status) {
    switch (status) {
      case true:
        return Colors.yellow.withOpacity(0.8);
      case false:
        return Colors.white.withOpacity(0.8);
      default:
        return Colors.white.withOpacity(0.8);
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final assetIcons = getIt<MapAssetIcons>();

    TextPainter textPainter = TextPainter();
    Paint paint = Paint();

    textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );

    List<DrawDiagonal> listPointColumn = [];

    // Draw behind column
    double offSetBCX1 = 150;
    double offSetBCX2 = 350;
    double offSetBCY1 = 750;
    double offSetBCY2 = 650;

    paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 5.0
      ..style = PaintingStyle.fill;

    rackData?.blockList?.forEach((e) {
      final blockList = e.listLayers;
      for (int i = 0; i < blockList.length; i++) {
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

        if (i == blockList.length - 1) {
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
    });

    // Draw behind row
    double offSetBRX1 = 150;
    double offSetBRX2 = 350;
    double offSetBRY1 = 650;

    paint = Paint()
      ..color = Colors.deepOrange
      ..strokeWidth = 5.0
      ..style = PaintingStyle.fill;

    rackData?.blockList?.forEach((e) {
      List<LayerDetailResponseModel> blockList = e.listLayers ?? [];
      for (int i = 0; i < blockList.length; i++) {
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
    });

    // Draw Diagonal
    paint = Paint()
      ..color = Colors.purple
      ..strokeWidth = 5.0
      ..style = PaintingStyle.fill;
    for (int i = 0; i < listPointColumn.length; i++) {
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
    double offSetConX1 = 250;
    double offSetConY1 = 750;

    rackData?.blockList?.forEach((e) {
      List<LayerDetailResponseModel> blockList = e.listLayers ?? [];
      for (var eChild in blockList) {
        paint = Paint()
          ..color = statusColor(eChild.isStored ?? false)
          ..style = PaintingStyle.fill;

        canvas.drawRect(
          Offset(offSetConX1, offSetConY1) & const Size(200, 100),
          paint,
        );

        offSetConX1 = offSetConX1 + 200;
      }

      offSetConY1 = offSetConY1 - 100;
      offSetConX1 = 250;
    });

    // Draw Column
    double offSetCX1 = 250;
    double offSetCX2 = 450;
    double offSetCY1 = 750;
    double offSetCY2 = 850;

    paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 5.0
      ..style = PaintingStyle.fill;

    rackData?.blockList?.forEach((e) {
      List<LayerDetailResponseModel> blockList = e.listLayers ?? [];
      for (int i = 0; i < blockList.length; i++) {
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
    });

    // Draw row
    double offSetRX1 = 250;
    double offSetRX2 = 450;
    double offSetRY1 = 750;

    paint = Paint()
      ..color = Colors.deepOrange
      ..strokeWidth = 5.0
      ..style = PaintingStyle.fill;

    rackData?.blockList?.forEach((e) {
      List<LayerDetailResponseModel> blockList = e.listLayers ?? [];
      for (final block in blockList) {
        canvas.drawLine(
          Offset(offSetRX1, offSetRY1),
          Offset(offSetRX2, offSetRY1),
          paint,
        );

        // Draw PL
        final position = Offset(
          offSetRX1 + 25,
          offSetRY1 + 25,
        );

        final isPL = block.pl?.toUpperCase() == 'PL';

        if (isPL) {
          paint = Paint()
            ..color = statusColor(true)
            ..style = PaintingStyle.fill;

          canvas.drawRect(
            Offset(offSetRX1, offSetRY1) & const Size(200, 100),
            paint,
          );
          _drawIcon(canvas, size, position);
        }

        final shortBlockName = block.blockName?.substring(7) ?? '';

        // if (block.lastLot != null && block.lastLot! > 0) {
        textPainter.text = TextSpan(
          text: shortBlockName ?? '',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.w700,
          ),
          // children: [
          //   TextSpan(
          //     text: ' $plKey',
          //     style: const TextStyle(
          //       fontWeight: FontWeight.w700,
          //       fontSize: 30,
          //       color: Colors.red,
          //     ),
          //   ),
          // ],
        );

        textPainter.layout();
        textPainter.paint(canvas, position);
        // }

        offSetRX1 = offSetRX1 + 200;
        offSetRX2 = offSetRX2 + 200;
      }

      offSetRY1 = offSetRY1 - 100;
      offSetRX1 = 250;
      offSetRX2 = 450;
    });

    textPainter.text = TextSpan(
      text: 'Rack name: ${rackData?.rackCode ?? ''}',
      style: const TextStyle(
        color: Colors.black,
        fontSize: 60,
        fontWeight: FontWeight.w700,
      ),
    );

    Offset position = Offset(
      250,
      950,
    );

    textPainter.layout();
    textPainter.paint(canvas, position);
  }

  // Draw Icon
  void _drawIcon(Canvas canvas, Size size, Offset offset) {
    final _assetIcons = getIt<MapAssetIcons>();
    ui.Image? image;
    image = _assetIcons.icPlSign;

    canvas.drawImageRect(
      image,
      Rect.fromLTWH(0, 0, image.width.toDouble(), image.height.toDouble()),
      Rect.fromLTWH(offset.dx + 100, offset.dy, 65, 65),
      Paint(),
    );
  }

  /// Backup Logic with old format Data from response
  // @override
  // void paint(Canvas canvas, Size size) {
  //   TextPainter textPainter = TextPainter();
  //   Paint paint = Paint();
  //
  //   textPainter = TextPainter(
  //     textAlign: TextAlign.center,
  //     textDirection: TextDirection.ltr,
  //   );
  //
  //   List<DrawDiagonal> listPointColumn = [];
  //
  //   // Draw behind column
  //   double offSetBCX1 = 150;
  //   double offSetBCX2 = 350;
  //   double offSetBCY1 = 750;
  //   double offSetBCY2 = 650;
  //
  //   paint = Paint()
  //     ..color = Colors.blue
  //     ..strokeWidth = 5.0
  //     ..style = PaintingStyle.fill;
  //
  //   rackData?.blockList?.forEach((e) {
  //     List<LayerDetailResponseModel> blockList = e.listLayers;
  //     for (int i = 0; i < blockList.length; i++) {
  //       canvas.drawLine(
  //         Offset(offSetBCX1, offSetBCY1),
  //         Offset(offSetBCX1, offSetBCY2),
  //         paint,
  //       );
  //       canvas.drawLine(
  //         Offset(offSetBCX2, offSetBCY1),
  //         Offset(offSetBCX2, offSetBCY2),
  //         paint,
  //       );
  //
  //       // Draw diagonal
  //       listPointColumn.add(
  //         DrawDiagonal(
  //           startX: offSetBCX1,
  //           startY: offSetBCY1,
  //         ),
  //       );
  //       listPointColumn.add(
  //         DrawDiagonal(
  //           startX: offSetBCX1,
  //           startY: offSetBCY2,
  //         ),
  //       );
  //
  //       if (i == blockList.length - 1) {
  //         listPointColumn.add(
  //           DrawDiagonal(
  //             startX: offSetBCX2,
  //             startY: offSetBCY2,
  //           ),
  //         );
  //       }
  //       offSetBCY1 = offSetBCY1 - 100;
  //       offSetBCY2 = offSetBCY2 - 100;
  //     }
  //
  //     offSetBCX1 = offSetBCX1 + 200;
  //     offSetBCX2 = offSetBCX2 + 200;
  //
  //     offSetBCY1 = 750;
  //     offSetBCY2 = 650;
  //   });
  //
  //   // Draw behind row
  //   double offSetBRX1 = 150;
  //   double offSetBRX2 = 350;
  //   double offSetBRY1 = 650;
  //
  //   paint = Paint()
  //     ..color = Colors.deepOrange
  //     ..strokeWidth = 5.0
  //     ..style = PaintingStyle.fill;
  //
  //   rackData?.blockList?.forEach((e) {
  //     List<LayerDetailResponseModel> blockList = e.listLayers ?? [];
  //     for (int i = 0; i < blockList.length; i++) {
  //       canvas.drawLine(
  //         Offset(offSetBRX1, offSetBRY1),
  //         Offset(offSetBRX2, offSetBRY1),
  //         paint,
  //       );
  //
  //       offSetBRY1 = offSetBRY1 - 100;
  //     }
  //
  //     offSetBRX1 = offSetBRX1 + 200;
  //     offSetBRX2 = offSetBRX2 + 200;
  //     offSetBRY1 = 650;
  //   });
  //
  //   // Draw Diagonal
  //   paint = Paint()
  //     ..color = Colors.purple
  //     ..strokeWidth = 5.0
  //     ..style = PaintingStyle.fill;
  //   for (int i = 0; i < listPointColumn.length; i++) {
  //     canvas.drawLine(
  //         Offset(
  //           listPointColumn[i].startX!,
  //           listPointColumn[i].startY!,
  //         ),
  //         Offset(
  //           listPointColumn[i].startX! + 100,
  //           listPointColumn[i].startY! + 100,
  //         ),
  //         paint);
  //   }
  //
  //   // Draw container
  //   double offSetConX1 = 250;
  //   double offSetConX2 = 450;
  //   double offSetConY1 = 750;
  //   double offSetConY2 = 850;
  //
  //   rackData?.blockList?.forEach((e) {
  //     List<LayerDetailResponseModel> blockList = e.listLayers ?? [];
  //     for (var eChild in blockList) {
  //       paint = Paint()
  //         ..color = statusColor(eChild.isStored ?? false)
  //         ..style = PaintingStyle.fill;
  //
  //       canvas.drawRect(
  //         Offset(offSetConX1, offSetConY1) & const Size(200, 100),
  //         paint,
  //       );
  //
  //       offSetConY1 = offSetConY1 - 100;
  //       offSetConY2 = offSetConY2 - 100;
  //     }
  //
  //     offSetConX1 = offSetConX1 + 200;
  //     offSetConX2 = offSetConX2 + 200;
  //     offSetConY1 = 750;
  //     offSetConY2 = 850;
  //   });
  //
  //   // Draw Column
  //   double offSetCX1 = 250;
  //   double offSetCX2 = 450;
  //   double offSetCY1 = 750;
  //   double offSetCY2 = 850;
  //
  //   paint = Paint()
  //     ..color = Colors.blue
  //     ..strokeWidth = 5.0
  //     ..style = PaintingStyle.fill;
  //
  //   rackData?.blockList?.forEach((e) {
  //     List<LayerDetailResponseModel> blockList = e.listLayers ?? [];
  //     for (int i = 0; i < blockList.length; i++) {
  //       canvas.drawLine(
  //         Offset(offSetCX1, offSetCY1),
  //         Offset(offSetCX1, offSetCY2),
  //         paint,
  //       );
  //       canvas.drawLine(
  //         Offset(offSetCX2, offSetCY1),
  //         Offset(offSetCX2, offSetCY2),
  //         paint,
  //       );
  //
  //       offSetCY1 = offSetCY1 - 100;
  //       offSetCY2 = offSetCY2 - 100;
  //     }
  //
  //     offSetCX1 = offSetCX1 + 200;
  //     offSetCX2 = offSetCX2 + 200;
  //     offSetCY1 = 750;
  //     offSetCY2 = 850;
  //   });
  //
  //   // Draw row
  //   double offSetRX1 = 250;
  //   double offSetRX2 = 450;
  //   double offSetRY1 = 750;
  //
  //   paint = Paint()
  //     ..color = Colors.deepOrange
  //     ..strokeWidth = 5.0
  //     ..style = PaintingStyle.fill;
  //
  //   rackData?.blockList?.forEach((e) {
  //     List<LayerDetailResponseModel> blockList = e.listLayers ?? [];
  //     for (final block in blockList) {
  //       canvas.drawLine(
  //         Offset(offSetRX1, offSetRY1),
  //         Offset(offSetRX2, offSetRY1),
  //         paint,
  //       );
  //
  //       final shortBlockName = block.blockName?.substring(7);
  //
  //       // if (block.lastLot != null && block.lastLot! > 0) {
  //       textPainter.text = TextSpan(
  //         text: shortBlockName ?? '',
  //         style: const TextStyle(
  //           color: Colors.black,
  //           fontSize: 26,
  //           fontWeight: FontWeight.w700,
  //         ),
  //       );
  //
  //       final position = Offset(
  //         offSetRX1 + 25,
  //         offSetRY1 + 30,
  //       );
  //
  //       textPainter.layout();
  //       textPainter.paint(canvas, position);
  //       // }
  //
  //       offSetRY1 = offSetRY1 - 100;
  //     }
  //
  //     offSetRX1 = offSetRX1 + 200;
  //     offSetRX2 = offSetRX2 + 200;
  //     offSetRY1 = 750;
  //   });
  //
  //   textPainter.text = TextSpan(
  //     text: 'Rack name: ${rackData?.rackCode ?? ''}',
  //     style: const TextStyle(
  //       color: Colors.black,
  //       fontSize: 60,
  //       fontWeight: FontWeight.w700,
  //     ),
  //   );
  //
  //   Offset position = Offset(
  //     250,
  //     950,
  //   );
  //
  //   textPainter.layout();
  //   textPainter.paint(canvas, position);
  // }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
