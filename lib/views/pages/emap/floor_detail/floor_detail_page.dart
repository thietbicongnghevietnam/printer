import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glowy_borders/glowy_borders.dart';
import 'package:smart_warehouse/enums/emap_navigate_funciton.dart';
import 'package:smart_warehouse/gen/assets.gen.dart';
import 'package:smart_warehouse/services/models/response/floor_map_response_model.dart';
import 'package:smart_warehouse/services/models/response/zone_floor_response_model.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/extensions/duration_extensions.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';
import 'package:smart_warehouse/views/pages/emap/map_widgets/zoom_widget.dart';
import 'package:smart_warehouse/views/widgets/app_text.dart';
import 'package:smart_warehouse/views/widgets/rectangle_animation.dart';

import 'floor_detail_controller.dart';
import 'floor_detail_state.dart';

@RoutePage()
class FloorDetailPage
    extends BasePage<FloorDetailController, FloorDetailState> {
  const FloorDetailPage({
    super.key,
    required this.receivingCardId,
    this.eMapNavigateFunction = EMapNavigateFunction.storing,
  });

  final int receivingCardId;

  final EMapNavigateFunction eMapNavigateFunction;

  @override
  BasePageState createState() => _FloorDetailPageState(
        receivingCardId: receivingCardId,
        eMapNavigateFunction: eMapNavigateFunction,
      );
}

class _FloorDetailPageState
    extends BasePageState<FloorDetailController, FloorDetailState> {
  _FloorDetailPageState({
    required this.receivingCardId,
    required this.eMapNavigateFunction,
  });

  final int receivingCardId;

  final EMapNavigateFunction eMapNavigateFunction;

  @override
  void initState() {
    super.initState();
    context.read<FloorDetailController>().loadFloorData(receivingCardId);
  }

  Widget arrowDirection(ZoneFloorResponseModel zoneData) {
    final imageName = zoneData.imageName ?? 'up';
    switch (imageName) {
      case 'ic_arrow_up.png':
        return Assets.images.icArrowUp.image(
          height: zoneData.height,
          width: zoneData.width,
          fit: BoxFit.cover,
          color: Colors.blue,
        );
      case 'ic_arrow_down.png':
        return Assets.images.icArrowDown.image(
          height: zoneData.height,
          width: zoneData.width,
          fit: BoxFit.cover,
          color: Colors.blue,
        );
      case 'ic_arrow_left.png':
        return Assets.images.icArrowLeft.image(
          height: zoneData.height,
          width: zoneData.width,
          color: Colors.blue,
          fit: BoxFit.cover,
        );
      case 'ic_arrow_right.png':
        return Assets.images.icArrowRight.image(
          height: zoneData.height,
          width: zoneData.width,
          fit: BoxFit.cover,
          color: Colors.blue,
        );
      default:
        return const SizedBox();
    }
  }

  String zoneColor(String backgroundColor) {
    String zoneColor = backgroundColor;
    return '0xff$zoneColor';
  }

  @override
  Widget builder(context, cubit, state) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: _buildMapNote(),
        body: BlocBuilder<FloorDetailController, FloorDetailState>(
          buildWhen: (prev, current) {
            return prev.floorData != current.floorData ||
                prev.pageStatus != current.pageStatus;
          },
          builder: (context, state) {
            final zoneList = state.floorData?.zoneList ?? [];
            if (state.floorData != null && zoneList.isNotEmpty) {
              return ZoomMapWidget(
                maxZoomWidth: state.floorData?.width ?? 0,
                maxZoomHeight: state.floorData?.height ?? 0,
                initTotalZoomOut: true,
                colorScrollBars: Colors.white,
                child: Stack(
                  children: [
                    IndoorBorder1FMap(
                      mapHeight: state.floorData?.height ?? 0,
                      mapWidth: state.floorData?.width ?? 0,
                    ),
                    // const BorderInsideMapZone(),
                    // Not Using Area
                    // const NotUsingArea(),

                    // Zone 1,2,3,4,5,6,7,8,9
                    // ZoneOfStore(
                    //   floorData: state.floorData,
                    // ),
                    if (zoneList.isNotEmpty)
                      for (int i = 0; i < zoneList.length; i++) ...[
                        if (zoneList[i].imageName != null &&
                            zoneList[i].zoneType == 'direction')
                          _buildTransformWidget(
                            zoneList[i].offsetX ?? 0,
                            zoneList[i].offsetY ?? 0,
                            arrowDirection(zoneList[i]),
                          )
                        else if (zoneList[i].isSuggested != null &&
                            zoneList[i].isSuggested == true &&
                            zoneList[i].zoneType == 'zone')
                          _buildMapZoneSuggest(zoneList[i])
                        else if (zoneList[i].zoneType == 'zone')
                          _buildMapZone(zoneList[i])
                        else if (zoneList[i].zoneType == 'wall')
                          _buildMapWall(zoneList[i])
                        else if (zoneList[i].zoneType == 'robot-line')
                          _buildRobotLine(zoneList[i])
                      ],
                  ],
                ),
              );
            }
            return Center(
              child: const Text(LocaleKeys.error_do_not_have_data).tr(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildTransformWidget(
    double offsetX,
    double offsetY,
    Widget child,
  ) {
    return Transform.translate(
      offset: Offset(
        offsetX,
        offsetY,
      ),
      child: child,
    );
  }

  Widget _buildMapZoneSuggest(ZoneFloorResponseModel zoneData) {
    return _buildTransformWidget(
      zoneData.offsetX ?? 0,
      zoneData.offsetY ?? 0,
      GestureDetector(
        onTap: () async {
          if (zoneData.isActive == true) {
            if (eMapNavigateFunction ==
                    EMapNavigateFunction.storing &&
                zoneData.isJIT == false) {
              final res = await context.pushRoute(ZoneDetailRoute(
                receivingCardId: receivingCardId,
                zoneId: zoneData.zoneId,
              ));
              if (res != null && res is String) {
                await Duration.zero.delay(() async {
                  context.router.pop(res);
                });
              }
            } else if (zoneData.isJIT == true) {
              logger.i('Result Data JIT: $zoneData');
              context.router.pop(zoneData.zoneName);
            } else {
              context.router.pop(zoneData.zoneId);
            }
          }
        },
        child: _buildLastLot(
          child: RectangleAnimation(
            color: Colors.redAccent.withOpacity(0.1),
            repeat: true,
            delay: const Duration(milliseconds: 300),
            maxHeight: (zoneData.height ?? 0) + 10,
            maxWidth: (zoneData.width ?? 0) + 25,
            minHeight: zoneData.height ?? 0,
            minWidth: zoneData.width ?? 0,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(width: 1.5),
                color: Color(zoneColor(
                  zoneData.backgroundColor ?? 'FFFFFF',
                ).toInt()),
              ),
              width: zoneData.width ?? 0,
              height: zoneData.height ?? 0,
              child: Center(
                child: Text(
                  zoneData.zoneName ?? '',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          hasLastLot: zoneData.isLastLot == true,
        ),
      ),
    );
  }

  Widget _buildMapZone(ZoneFloorResponseModel zoneData) {
    return _buildTransformWidget(
      zoneData.offsetX ?? 0,
      zoneData.offsetY ?? 0,
      GestureDetector(
        onTap: () async {
          if (zoneData.isActive == true) {
            if (eMapNavigateFunction ==
                    EMapNavigateFunction.storing &&
                zoneData.isJIT == false) {
              final res = await context.pushRoute(ZoneDetailRoute(
                receivingCardId: receivingCardId,
                zoneId: zoneData.zoneId,
              ));
              if (res != null && res is String) {
                await Duration.zero.delay(() async {
                  context.router.pop(res);
                });
              }
            } else if (zoneData.isJIT == true) {
              logger.i('Result Data JIT: $zoneData');
              context.router.pop(zoneData.zoneName);
            } else {
              context.router.pop(zoneData.zoneId);
            }
          }
        },
        child: _buildLastLot(
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1.5),
              color: Color(zoneColor(
                zoneData.backgroundColor ?? 'FFFFFF',
              ).toInt()),
            ),
            width: zoneData.width ?? 0,
            height: zoneData.height ?? 0,
            child: Center(
              child: Text(
                zoneData.zoneName ?? '',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          hasLastLot: zoneData.isLastLot == true,
        ),
      ),
    );
  }

  Widget _buildRobotLine(ZoneFloorResponseModel zoneData) {
    return _buildTransformWidget(
      zoneData.offsetX ?? 0,
      zoneData.offsetY ?? 0,
      SizedBox(
        width: zoneData.width ?? 0,
        height: zoneData.height ?? 0,
        child: renderRobotLine(
          height: zoneData.height ?? 0,
          width: zoneData.width ?? 0,
          lineColor: zoneData.backgroundColor ?? 'FFFFFF',
          isVertical: zoneData.height != null &&
              zoneData.height! > (zoneData.width ?? 0),
        ),
      ),
    );
  }

  Widget renderRobotLine({
    required double height,
    required double width,
    required String lineColor,
    required bool isVertical,
  }) {
    double sizeGrowUp = 10;
    return Stack(
      children: [
        for (int i = 0; i < width / 10; i++)
          Positioned(
            left: isVertical ? 0 : i * sizeGrowUp,
            top: isVertical ? i * sizeGrowUp : 0,
            child: Container(
              height: height,
              width: sizeGrowUp,
              decoration: BoxDecoration(
                color: Color(
                  zoneColor(lineColor).toInt(),
                ),
                border: Border.all(color: Colors.black54),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildMapWall(ZoneFloorResponseModel zoneData) {
    return _buildTransformWidget(
      zoneData.offsetX ?? 0,
      zoneData.offsetY ?? 0,
      Container(
        decoration: BoxDecoration(
          border: Border.all(width: 1.5),
          color: Color(
            zoneColor(
              zoneData.backgroundColor ?? 'FFFFFF',
            ).toInt(),
          ),
        ),
        width: zoneData.width ?? 0,
        height: zoneData.height ?? 0,
      ),
    );
  }

  // Map Note
  Widget _buildMapNote() {
    return BlocBuilder<FloorDetailController, FloorDetailState>(
      buildWhen: (prev, current) {
        return prev.floorData != current.floorData ||
            prev.pageStatus != current.pageStatus;
      },
      builder: (context, state) {
        if (state.floorData != null) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(width: 25),
              _buildNoteLocation(state),
              // const SizedBox(width: 10),
              // _buildNoteSuggest(),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildNoteLocation(FloorDetailState state) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Colors.black.withOpacity(0.5),
        ),
        color: Colors.white.withOpacity(0.5),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          RichText(
            text: TextSpan(
              text: LocaleKeys.storing_storage.tr(),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 10,
                color: Colors.red,
              ),
              children: [
                TextSpan(
                  text: ' ${state.floorData?.totalStored ?? 0}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              text: LocaleKeys.storing_temporary.tr(),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 10,
                color: Colors.red,
              ),
              children: [
                TextSpan(
                  text: ' ${state.floorData?.totalTemporary ?? 0}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              text: LocaleKeys.storing_last_node.tr(),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 10,
                color: Colors.red,
              ),
              children: [
                TextSpan(
                  text: ' ${state.floorData?.lastLotName ?? 'Chưa có'}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              text: 'Floor',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 10,
                color: Colors.red,
              ),
              children: [
                TextSpan(
                  text: ' ${state.floorData?.floorName ?? 0}',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 10,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoteSuggest() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Colors.black.withOpacity(0.5),
        ),
        color: Colors.white.withOpacity(0.5),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 3,
        horizontal: 8,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildNoteItem(Colors.green, LocaleKeys.storing_can_input),
          const SizedBox(height: 4),
          _buildNoteItem(Colors.red, LocaleKeys.storing_have_item),
          const SizedBox(height: 4),
          _buildNoteItem(Colors.blue, LocaleKeys.storing_other_item),
        ],
      ),
    );
  }

  Widget _buildNoteItem(
    Color color,
    String label,
  ) {
    return Row(
      children: [
        Container(
          width: 22,
          height: 12,
          color: color.withOpacity(0.5),
        ),
        const SizedBox(width: 6),
        AppText(
          label,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 11,
            fontWeight: FontWeight.w500,
          ),
        ).tr(),
      ],
    );
  }

  Widget _buildLastLot({
    required Widget child,
    required bool hasLastLot,
  }) {
    return hasLastLot
        ? AnimatedGradientBorder(
            borderSize: 2,
            glowSize: 2,
            gradientColors: [
              Colors.orangeAccent.withOpacity(0.5),
              Colors.blue.withOpacity(0.5),
              Colors.yellow.withOpacity(0.5),
              Colors.purple.shade50,
            ],
            borderRadius: BorderRadius.zero,
            child: child,
          )
        : child;
  }
}

// 1F: 12.1/10: height/width
class IndoorBorder1FMap extends StatelessWidget {
  const IndoorBorder1FMap({
    super.key,
    this.mapWidth,
    this.mapHeight,
  });

  final double? mapWidth;
  final double? mapHeight;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: IndoorMapPainter(
        mapWidth: mapWidth ?? 0,
        mapHeight: mapHeight ?? 0,
      ),
    );
  }
}

class IndoorMapPainter extends CustomPainter {
  IndoorMapPainter({
    super.repaint,
    required this.mapWidth,
    required this.mapHeight,
  });

  final double mapWidth;
  final double mapHeight;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 10.0
      ..style = PaintingStyle.stroke;

    canvas.drawRect(Offset(0, 0) & Size(mapWidth, mapHeight), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class BorderInsideMapZone extends StatelessWidget {
  const BorderInsideMapZone({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: BorderInsideMapZonePainter(),
    );
  }
}

class BorderInsideMapZonePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2.0
      ..style = PaintingStyle.fill
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;

    drawDashedLineVertical(
      canvas,
      const Offset(450, 10),
      const Offset(450, 880),
      paint,
    );
    drawDashedLineHorizon(
      canvas,
      const Offset(450, 250),
      const Offset(550, 250),
      paint,
    );
    drawDashedLineVertical(
      canvas,
      const Offset(550, 250),
      const Offset(550, 450),
      paint,
    );
    drawDashedLineHorizon(
      canvas,
      const Offset(550, 450),
      const Offset(790, 450),
      paint,
    );
    drawDashedLineHorizon(
      canvas,
      const Offset(860, 450),
      const Offset(1000, 450),
      paint,
    );
    drawDashedLineVertical(
      canvas,
      const Offset(860, 450),
      const Offset(860, 700),
      paint,
    );
    drawDashedLineVertical(
      canvas,
      const Offset(790, 450),
      const Offset(790, 700),
      paint,
    );

    //
    paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0
      ..style = PaintingStyle.fill
      ..style = PaintingStyle.stroke
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;
    drawDashedLineHorizon(
      canvas,
      const Offset(450, 700),
      const Offset(1000, 700),
      paint,
    );
    drawDashedLineVertical(
      canvas,
      const Offset(750, 250),
      const Offset(750, 450),
      paint,
    );
    drawDashedLineVertical(
      canvas,
      const Offset(790, 130),
      const Offset(790, 450),
      paint,
    );
    drawDashedLineVertical(
      canvas,
      const Offset(790, 700),
      const Offset(790, 580),
      paint,
    );
    drawDashedLineVertical(
      canvas,
      const Offset(750, 700),
      const Offset(750, 580),
      paint,
    );

    //
    paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 4.0
      ..style = PaintingStyle.fill
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(const Offset(450, 810), const Offset(550, 810), paint);
    canvas.drawLine(const Offset(590, 810), const Offset(750, 810), paint);
    canvas.drawLine(const Offset(770, 810), const Offset(1000, 810), paint);

    canvas.drawLine(const Offset(500, 810), const Offset(500, 880), paint);
    canvas.drawLine(const Offset(500, 880), const Offset(530, 880), paint);
    canvas.drawLine(const Offset(530, 810), const Offset(530, 880), paint);

    canvas.drawLine(const Offset(550, 910), const Offset(750, 910), paint);
    canvas.drawLine(const Offset(770, 910), const Offset(790, 910), paint);
    canvas.drawLine(const Offset(790, 810), const Offset(790, 910), paint);

    //
    paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2.0
      ..style = PaintingStyle.fill
      ..strokeJoin = StrokeJoin.round
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(const Offset(20, 920), const Offset(420, 920), paint);
    canvas.drawLine(const Offset(20, 920), const Offset(20, 1000), paint);
    canvas.drawLine(const Offset(280, 920), const Offset(280, 1000), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

/// The area not using for MCS
class NotUsingArea extends StatelessWidget {
  const NotUsingArea({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: FaAreaPainter(),
    );
  }
}

class FaAreaPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    TextPainter painter;
    Paint paint;
    painter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    painter.text = const TextSpan(
      text: 'FA',
      style: TextStyle(
        color: Colors.black,
        fontSize: 35,
      ),
    );

    const position = Offset(
      180,
      160,
    );

    painter.layout();
    painter.paint(canvas, position);

    paint = Paint()
      ..color = Colors.grey.withOpacity(0.1)
      ..strokeWidth = 4.0
      ..style = PaintingStyle.fill;

    canvas.drawRect(const Offset(10, 10) & const Size(400, 350), paint);

    // MKKittingArea
    painter.text = const TextSpan(
      text: 'MW Kitting\nArea',
      style: TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
    );

    const positionMwKitting = Offset(
      640,
      160,
    );

    painter.layout();
    painter.paint(canvas, positionMwKitting);

    paint = Paint()
      ..color = Colors.grey.withOpacity(0.1)
      ..strokeWidth = 4.0
      ..style = PaintingStyle.fill;

    canvas.drawRect(const Offset(630, 110) & const Size(120, 130), paint);

    // PMD Printing
    painter.text = const TextSpan(
      text: 'PMD\nPrinting',
      style: TextStyle(
        color: Colors.black,
        fontSize: 25,
      ),
    );

    const positionPmd = Offset(
      460,
      320,
    );

    painter.layout();
    painter.paint(canvas, positionPmd);

    paint = Paint()
      ..color = Colors.grey.withOpacity(0.1)
      ..strokeWidth = 4.0
      ..style = PaintingStyle.fill;

    canvas.drawRect(const Offset(450, 250) & const Size(100, 200), paint);

    // PMD Injection
    painter.text = const TextSpan(
      text: 'PMD Injection',
      style: TextStyle(
        color: Colors.black,
        fontSize: 30,
      ),
    );

    const positionPmdInjection = Offset(
      500,
      550,
    );

    painter.layout();
    painter.paint(canvas, positionPmdInjection);

    paint = Paint()
      ..color = Colors.grey.withOpacity(0.1)
      ..strokeWidth = 4.0
      ..style = PaintingStyle.fill;

    canvas.drawRect(const Offset(450, 450) & const Size(300, 250), paint);

    // TED Molding
    painter.text = const TextSpan(
      text: 'TED\n&\nMolding',
      style: TextStyle(
        color: Colors.black,
        fontSize: 25,
      ),
    );

    const positionTed = Offset(
      890,
      530,
    );

    painter.layout();
    painter.paint(canvas, positionTed);

    paint = Paint()
      ..color = Colors.grey.withOpacity(0.1)
      ..strokeWidth = 4.0
      ..style = PaintingStyle.fill;

    canvas.drawRect(const Offset(860, 450) & const Size(140, 250), paint);

    // GR Free Location
    painter.text = const TextSpan(
      text: 'GR free\nlocation',
      style: TextStyle(
        color: Colors.black,
        fontSize: 25,
      ),
    );

    const positionGRFreeLocation = Offset(
      800,
      980,
    );

    painter.layout();
    painter.paint(canvas, positionGRFreeLocation);

    paint = Paint()
      ..color = Colors.grey.withOpacity(0.1)
      ..strokeWidth = 4.0
      ..style = PaintingStyle.fill;

    canvas.drawRect(const Offset(680, 920) & const Size(320, 170), paint);

    // IQC
    painter.text = const TextSpan(
      text: 'IQC',
      style: TextStyle(
        color: Colors.black,
        fontSize: 30,
      ),
    );

    const positionIQC = Offset(
      550,
      1150,
    );

    painter.layout();
    painter.paint(canvas, positionIQC);

    paint = Paint()
      ..color = Colors.orangeAccent.withOpacity(0.2)
      ..strokeWidth = 4.0
      ..style = PaintingStyle.fill;

    canvas.drawRect(const Offset(280, 1100) & const Size(580, 140), paint);

    // DIP Prepare
    painter.text = const TextSpan(
      text: 'DIP Prepare Area',
      style: TextStyle(
        color: Colors.black,
        fontSize: 25,
      ),
    );

    const positionDIP = Offset(
      50,
      950,
    );

    painter.layout();
    painter.paint(canvas, positionDIP);

    paint = Paint()
      ..color = Colors.grey.withOpacity(0.1)
      ..strokeWidth = 4.0
      ..style = PaintingStyle.fill;

    canvas.drawRect(const Offset(20, 920) & const Size(260, 80), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

/// Zone for MCS

class ZoneOfStore extends StatelessWidget {
  const ZoneOfStore({
    super.key,
    this.floorData,
  });

  final FloorMapResponseModel? floorData;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ZoneOfStorePainter(
        floorData: floorData,
      ),
    );
  }
}

class ZoneOfStorePainter extends CustomPainter {
  ZoneOfStorePainter({super.repaint, this.floorData});

  final FloorMapResponseModel? floorData;

  @override
  void paint(Canvas canvas, Size size) {
    TextPainter textPainter;
    Paint paint;
    List<ZoneFloorResponseModel> zoneList = floorData?.zoneList ?? [];
    zoneList.forEach((e) {
      if (e.imageName == null) {
        paint = Paint()
          ..color = Colors.black
          ..strokeWidth = 2.0
          ..style = PaintingStyle.stroke;

        // Draw rack border
        canvas.drawRect(
          Offset(e.offsetX ?? 0, e.offsetY ?? 0) &
              Size(e.width ?? 0, e.height ?? 0),
          paint,
        );
        String zoneColor = e.backgroundColor ?? 'ffffff';
        String hexColor = '0xff$zoneColor';
        paint = Paint()
          ..color = Color(hexColor.toInt()).withOpacity(0.5)
          ..strokeWidth = 2.0
          ..style = PaintingStyle.fill;
        canvas.drawRect(
          Offset(e.offsetX ?? 0, e.offsetY ?? 0) &
              Size(e.width ?? 0, e.height ?? 0),
          paint,
        );

        if (e.zoneName != null && e.zoneName!.isNotEmpty) {
          textPainter = TextPainter(
            textAlign: TextAlign.center,
            textDirection: TextDirection.ltr,
          );
          textPainter.text = TextSpan(
            text: e.zoneName,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          );

          final position = Offset(
            (e.offsetX ?? 0) + (e.width ?? 0) / 4,
            (e.offsetY ?? 0) + (e.height ?? 0) / 2.5,
          );

          textPainter.layout();
          textPainter.paint(canvas, position);
        }
      }

      // Draw rack
      // e.listRack?.forEach((eRack) {
      //   // Draw rack
      //   paintRack = Paint()
      //     ..color = Colors.lightGreen
      //     ..style = PaintingStyle.fill;
      //
      //   canvas.drawRect(
      //     Offset(eRack.offSetX!, eRack.offSetY!) &
      //         Size(eRack.width!, eRack.height!),
      //     paintRack,
      //   );
      //
      //   // Draw rack border
      //   paintRack = Paint()
      //     ..color = Colors.grey.withOpacity(0.7)
      //     ..strokeWidth = 2
      //     ..style = PaintingStyle.stroke;
      //
      //   canvas.drawRect(
      //     Offset(eRack.offSetX!, eRack.offSetY!) &
      //         Size(eRack.width!, eRack.height!),
      //     paintRack,
      //   );
      //
      //   textPainter = TextPainter(
      //     textAlign: TextAlign.center,
      //     textDirection: TextDirection.ltr,
      //   );
      //   textPainter.text = TextSpan(
      //     text: eRack.rackName,
      //     style: const TextStyle(
      //       color: Colors.black,
      //       fontSize: 12,
      //     ),
      //   );
      //
      //   final position = Offset(
      //     eRack.offSetX! + (eRack.width! / 4),
      //     eRack.offSetY! + (eRack.height! / 2.5),
      //   );
      //
      //   textPainter.layout();
      //   textPainter.paint(canvas, position);
      // });
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

// class ZoneOfStore extends StatelessWidget {
//   const ZoneOfStore({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       painter: Zone1MapPainter(),
//     );
//   }
// }
//
// class Zone1MapPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     TextPainter painter;
//     Paint paint;
//     painter = TextPainter(
//       textAlign: TextAlign.center,
//       textDirection: TextDirection.ltr,
//     );
//     painter.text = const TextSpan(
//       text: 'Zone 1',
//       style: TextStyle(
//         color: Colors.black,
//         fontSize: 30,
//       ),
//     );
//
//     const position = Offset(
//       510,
//       980,
//     );
//
//     painter.layout();
//     painter.paint(canvas, position);
//
//     paint = Paint()
//       ..color = Colors.blueAccent.withOpacity(0.5)
//       ..strokeWidth = 2.0
//       ..style = PaintingStyle.fill;
//
//     canvas.drawRect(const Offset(450, 920) & const Size(200, 170), paint);
//
//     // Zone2
//     painter.text = const TextSpan(
//       text: 'Zone 2',
//       style: TextStyle(
//         color: Colors.black,
//         fontSize: 30,
//       ),
//     );
//
//     const position2 = Offset(
//       550,
//       740,
//     );
//
//     painter.layout();
//     painter.paint(canvas, position2);
//
//     paint = Paint()
//       ..color = Colors.green.withOpacity(0.2)
//       ..strokeWidth = 2.0
//       ..style = PaintingStyle.fill;
//
//     canvas.drawRect(const Offset(450, 700) & const Size(300, 110), paint);
//
//     // Zone3
//     painter.text = const TextSpan(
//       text: 'Zone 3',
//       style: TextStyle(
//         color: Colors.black,
//         fontSize: 30,
//       ),
//     );
//
//     const position3 = Offset(
//       840,
//       740,
//     );
//
//     painter.layout();
//     painter.paint(canvas, position3);
//
//     List<Paint> listPaint = [paint, paint, paint];
//
//     paint = Paint()
//       ..color = Colors.greenAccent.withOpacity(0.2)
//       ..strokeWidth = 2.0
//       ..style = PaintingStyle.fill;
//
//     canvas.drawRect(const Offset(790, 700) & const Size(210, 110), paint);
//
//     // Zone4
//     painter.text = const TextSpan(
//       text: 'Zone\n4',
//       style: TextStyle(
//         color: Colors.black,
//         fontSize: 25,
//       ),
//     );
//
//     const position4 = Offset(
//       800,
//       580,
//     );
//
//     painter.layout();
//     painter.paint(canvas, position4);
//
//     paint = Paint()
//       ..color = Colors.orange.withOpacity(0.2)
//       ..strokeWidth = 2.0
//       ..style = PaintingStyle.fill;
//
//     canvas.drawRect(const Offset(790, 490) & const Size(70, 210), paint);
//
//     // Zone5
//     painter.text = const TextSpan(
//       text: 'Zone 5',
//       style: TextStyle(
//         color: Colors.black,
//         fontSize: 35,
//       ),
//     );
//
//     const position5 = Offset(
//       840,
//       270,
//     );
//
//     painter.layout();
//     painter.paint(canvas, position5);
//
//     paint = Paint()
//       ..color = Colors.orange.withOpacity(0.2)
//       ..strokeWidth = 2.0
//       ..style = PaintingStyle.fill;
//
//     canvas.drawRect(const Offset(790, 130) & const Size(210, 320), paint);
//
//     // Zone6
//     painter.text = const TextSpan(
//       text: 'Zone 6',
//       style: TextStyle(
//         color: Colors.black,
//         fontSize: 35,
//       ),
//     );
//
//     const position6 = Offset(
//       590,
//       320,
//     );
//
//     painter.layout();
//     painter.paint(canvas, position6);
//
//     paint = Paint()
//       ..color = Colors.yellow.withOpacity(0.2)
//       ..strokeWidth = 2.0
//       ..style = PaintingStyle.fill;
//
//     canvas.drawRect(const Offset(550, 250) & const Size(200, 200), paint);
//
//     // Zone7
//     painter.text = const TextSpan(
//       text: 'Zone 7',
//       style: TextStyle(
//         color: Colors.black,
//         fontSize: 35,
//       ),
//     );
//
//     const position7 = Offset(
//       470,
//       105,
//     );
//
//     painter.layout();
//     painter.paint(canvas, position7);
//
//     paint = Paint()
//       ..color = Colors.red.withOpacity(0.5)
//       ..strokeWidth = 2.0
//       ..style = PaintingStyle.fill;
//
//     canvas.drawRect(const Offset(450, 10) & const Size(160, 240), paint);
//
//     final paintMinSize = Paint()
//       ..color = Colors.red.withOpacity(0.5)
//       ..strokeWidth = 2.0
//       ..style = PaintingStyle.fill;
//
//     canvas.drawRect(const Offset(610, 10) & const Size(140, 40), paintMinSize);
//
//     // Zone8
//     painter.text = const TextSpan(
//       text: 'Zone 8',
//       style: TextStyle(
//         color: Colors.black,
//         fontSize: 30,
//       ),
//     );
//
//     const position8 = Offset(
//       300,
//       980,
//     );
//
//     painter.layout();
//     painter.paint(canvas, position8);
//
//     paint = Paint()
//       ..color = Colors.purple.withOpacity(0.2)
//       ..strokeWidth = 2.0
//       ..style = PaintingStyle.fill;
//
//     canvas.drawRect(const Offset(280, 920) & const Size(140, 170), paint);
//
//     // Zone9
//     painter.text = const TextSpan(
//       text: 'Zone 9',
//       style: TextStyle(
//         color: Colors.black,
//         fontSize: 30,
//       ),
//     );
//
//     const position9 = Offset(
//       80,
//       1120,
//     );
//
//     painter.layout();
//     painter.paint(canvas, position9);
//
//     paint = Paint()
//       ..color = Colors.red.withOpacity(0.4)
//       ..strokeWidth = 2.0
//       ..style = PaintingStyle.fill;
//
//     canvas.drawRect(const Offset(20, 1020) & const Size(260, 220), paint);
//   }
//
//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return false;
//   }
// }

void drawDashedLineHorizon(
  Canvas canvas,
  Offset start,
  Offset end,
  Paint paint,
) {
  const dashWidth = 10.0;
  const dashSpace = 10.0;

  final distance = (end - start).distance;
  final segments = (distance / (dashWidth + dashSpace)).floor();

  var currentX = start.dx;
  final currentY = start.dy;

  for (var i = 0; i < segments; i++) {
    canvas.drawLine(
      Offset(currentX, currentY),
      Offset(currentX + dashWidth, currentY),
      paint,
    );
    currentX += dashWidth + dashSpace;
  }
}

void drawDashedLineVertical(
  Canvas canvas,
  Offset start,
  Offset end,
  Paint paint,
) {
  const dashWidth = 10.0;
  const dashSpace = 10.0;

  final distanceX = (end.dx - start.dx).abs();
  final distanceY = (end.dy - start.dy).abs();

  final segmentsX = (distanceX / (dashWidth + dashSpace)).floor();
  final segmentsY = (distanceY / (dashWidth + dashSpace)).floor();

  var currentX = start.dx;
  var currentY = start.dy;

  for (var i = 0; i < segmentsX; i++) {
    canvas.drawLine(
      Offset(currentX, currentY),
      Offset(currentX + dashWidth, currentY),
      paint,
    );
    currentX += dashWidth + dashSpace;
  }

  currentX = start.dx;

  for (var i = 0; i < segmentsY; i++) {
    canvas.drawLine(
      Offset(currentX, currentY),
      Offset(currentX, currentY + dashWidth),
      paint,
    );
    currentY += dashWidth + dashSpace;
  }
}
