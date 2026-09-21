import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart' hide TextDirection;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/entities/e_map/offset_block_detail.dart';
import 'package:smart_warehouse/enums/emap_navigate_funciton.dart';
import 'package:smart_warehouse/services/models/response/rack_detail_response_model.dart';
import 'package:smart_warehouse/services/models/response/zone_detail_response_model.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/extensions/duration_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';
import 'package:smart_warehouse/views/pages/emap/map_widgets/zoom_widget.dart';
import 'package:smart_warehouse/views/widgets/app_text.dart';
import 'package:smart_warehouse/views/widgets/rectangle_animation.dart';

import 'zone_detail_controller.dart';
import 'zone_detail_state.dart';

@RoutePage()
class ZoneDetailPage extends BasePage<ZoneDetailController, ZoneDetailState> {
  const ZoneDetailPage({
    super.key,
    required this.receivingCardId,
    this.zoneId,
    this.eMapNavigateFunction = EMapNavigateFunction.storing,
  });

  final int receivingCardId;
  final int? zoneId;

  final EMapNavigateFunction eMapNavigateFunction;

  @override
  BasePageState createState() {
    return ZoneDetailPageState(
      eMapNavigateFunction: eMapNavigateFunction,
      receivingCardId: receivingCardId,
      zoneId: zoneId,
    );
  }
}

class ZoneDetailPageState
    extends BasePageState<ZoneDetailController, ZoneDetailState> {
  ZoneDetailPageState({
    required this.eMapNavigateFunction,
    required this.receivingCardId,
    this.zoneId,
  });

  final int receivingCardId;
  final int? zoneId;

  final EMapNavigateFunction eMapNavigateFunction;

  @override
  void initState() {
    super.initState();
    context.read<ZoneDetailController>().loadZoneData(
          receivingCardId: receivingCardId,
          zoneId: zoneId,
        );
  }

  @override
  Widget builder(context, cubit, state) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: _buildMapNote(cubit),
        body: BlocBuilder<ZoneDetailController, ZoneDetailState>(
          buildWhen: (prev, current) {
            return prev.zoneDetailData != current.zoneDetailData ||
                prev.pageStatus != current.pageStatus;
          },
          builder: (context, state) {
            final listRack = state.zoneDetailData?.listRack ?? [];
            if (state.zoneDetailData != null && listRack.isNotEmpty) {
              return ZoomMapWidget(
                maxZoomWidth: state.zoneDetailData?.width ?? 0,
                maxZoomHeight: state.zoneDetailData?.height ?? 0,
                initTotalZoomOut: true,
                backgroundColor: Colors.white,
                child: Stack(
                  children: [
                    IndoorBorder1FMap(
                      height: state.zoneDetailData?.height ?? 0,
                      width: state.zoneDetailData?.width ?? 0,
                    ),
                    for (int i = 0; i < listRack.length; i++) ...[
                      if (listRack[i].isSuggested != null &&
                          listRack[i].isSuggested == true)
                        _buildMapRackSuggest(listRack[i])
                      else
                        _buildMapRack(listRack[i])
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

  Widget _buildMapRackSuggest(RackDetailResponseModel rackData) {
    return _buildTranslateWidget(
      rackData.offsetX ?? 0,
      rackData.offsetY ?? 0,
      GestureDetector(
        onTap: () async {
          final rackType = rackData.rackType ?? 'BIGRACK';
          if (rackType.toUpperCase() != 'PALLET') {
            final res = await context.router.push(
              RackDetailRoute(
                rackId: rackData.rackId ?? 0,
                receivingCardId: receivingCardId,
                eMapNavigateFunction: eMapNavigateFunction,
              ),
            );
            if (res != null && res is OffsetBlockDetail) {
              await Duration.zero.delay(() async {
                context.router.pop(res.location);
              });
            }
          } else {
            final res = await context.router.push(
              PalletDetailRoute(
                rackId: rackData.rackId ?? 0,
                receivingCardId: receivingCardId,
                eMapNavigateFunction: eMapNavigateFunction,
              ),
            );
            if (res != null && res is OffsetBlockDetail) {
              await Duration.zero.delay(() async {
                context.router.pop(res.location);
              });
            }
          }
        },
        child: _buildLastLot(
          width: rackData.width ?? 0,
          height: rackData.height ?? 0,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1.5),
              color: Colors.grey.withOpacity(0.1),
            ),
            width: rackData.width ?? 0,
            height: rackData.height ?? 0,
            child: Center(
              child: Text(
                rackData.rackCode ?? '',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          hasLastLot: rackData.lastLot != null && rackData.lastLot! > 0,
        ),
      ),
    );
  }

  Widget _buildMapRack(RackDetailResponseModel rackData) {
    return _buildTranslateWidget(
      rackData.offsetX ?? 0,
      rackData.offsetY ?? 0,
      GestureDetector(
        onTap: () async {
          final rackType = rackData.rackType ?? 'BIGRACK';
          if (rackType.toUpperCase() != 'PALLET') {
            final res = await context.router.push(
              RackDetailRoute(
                rackId: rackData.rackId ?? 0,
                receivingCardId: receivingCardId,
                eMapNavigateFunction: eMapNavigateFunction,
              ),
            );
            if (res != null && res is OffsetBlockDetail) {
              await Duration.zero.delay(() async {
                context.router.pop(res.location);
              });
            }
          } else {
            final res = await context.router.push(
              PalletDetailRoute(
                rackId: rackData.rackId ?? 0,
                receivingCardId: receivingCardId,
                eMapNavigateFunction: eMapNavigateFunction,
              ),
            );
            if (res != null && res is OffsetBlockDetail) {
              await Duration.zero.delay(() async {
                context.router.pop(res.location);
              });
            }
          }
        },
        child: _buildLastLot(
          width: rackData.width ?? 0,
          height: rackData.height ?? 0,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1.5),
              color: Colors.yellow.withOpacity(0.8),
            ),
            width: rackData.width ?? 0,
            height: rackData.height ?? 0,
            child: Center(
              child: Text(
                rackData.rackCode ?? '',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          hasLastLot: rackData.lastLot != null && rackData.lastLot! > 0,
        ),
      ),
    );
  }

  Widget _buildMapNote(ZoneDetailController cubit) {
    return BlocBuilder<ZoneDetailController, ZoneDetailState>(
      buildWhen: (prev, current) {
        return prev.pageStatus != current.pageStatus ||
            prev.zoneDetailData != current.zoneDetailData;
      },
      builder: (context, state) {
        if (state.zoneDetailData != null) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(width: 25),
              _buildNoteLocation(state),
              const SizedBox(width: 10),
              _buildQtyMaterial(state),
              const Spacer(),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  AppText(
                    'Name: ${state.zoneDetailData?.zoneName}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 5),
                  SizedBox(
                    height: 30,
                    width: 70,
                    child: ElevatedButton(
                      child: const Text(
                        LocaleKeys.storing_show_overview,
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 9,
                        ),
                        textAlign: TextAlign.center,
                      ).tr(),
                      onPressed: () async {
                        final res = await context.router.push(
                          FloorDetailRoute(
                            receivingCardId: receivingCardId,
                            eMapNavigateFunction: eMapNavigateFunction,
                          ),
                        );

                        if (res != null && res is int) {
                          logger.i('Result Data from FloorDetail: $res');

                          cubit.getZoneData(
                            zoneId: res,
                            receivingCardId: receivingCardId,
                          );
                        } else if (res != null && res is String) {
                          logger.i('Result Data from FloorDetail For JIT: $res');

                          await Duration.zero.delay(() async {
                            context.router.pop(res);
                          });
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildNoteLocation(ZoneDetailState state) {
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
              text: LocaleKeys.storing_position.tr(),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 10,
                color: Colors.red,
              ),
              children: [
                TextSpan(
                  text: ' ${state.zoneDetailData?.totalStored ?? 0}',
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
                  text: ' ${state.zoneDetailData?.lastLotName ?? 'Không có'}',
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

  Widget _buildQtyMaterial(ZoneDetailState state) {
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
              text: LocaleKeys.storing_material.tr(),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 10,
                color: Colors.red,
              ),
              children: [
                TextSpan(
                  text: ' ${state.zoneDetailData?.totalStored ?? 0}',
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
              text: LocaleKeys.storing_total_qty.tr(),
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 10,
                color: Colors.red,
              ),
              children: [
                TextSpan(
                  text: ' ${state.zoneDetailData?.totalStored ?? 'Không có'}',
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

  Widget _buildTranslateWidget(
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

  Widget _buildLastLot({
    required Widget child,
    required bool hasLastLot,
    double? height,
    double? width,
  }) {
    return hasLastLot
        ? RectangleAnimation(
            color: Colors.redAccent.withOpacity(0.1),
            repeat: true,
            delay: const Duration(milliseconds: 300),
            maxHeight: (height ?? 0) + 10,
            maxWidth: (width ?? 0) + 25,
            minHeight: height ?? 0,
            minWidth: width ?? 0,
            child: child,
          )
        : child;
  }
}

class IndoorBorder1FMap extends StatelessWidget {
  const IndoorBorder1FMap(
      {super.key, required this.height, required this.width});

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: IndoorMapPainter(
        height: height,
        width: width,
      ),
    );
  }
}

class IndoorMapPainter extends CustomPainter {
  IndoorMapPainter({super.repaint, required this.height, required this.width});

  final double height;
  final double width;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 10.0
      ..style = PaintingStyle.stroke;

    canvas.drawRect(Offset(0, 0) & Size(width, height), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

class ZoneOfStore extends StatelessWidget {
  const ZoneOfStore({
    super.key,
    required this.zoneData,
  });

  final ZoneDetailResponseModel zoneData;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ZoneOfStorePainter(
        zoneData: zoneData,
      ),
    );
  }
}

class ZoneOfStorePainter extends CustomPainter {
  ZoneOfStorePainter({super.repaint, required this.zoneData});

  final ZoneDetailResponseModel zoneData;

  Color rackColor(int status) {
    switch (status) {
      case 0:
        return Colors.green;
      case 1:
        return Colors.blue;
      case 2:
        return Colors.red;
      default:
        return Colors.white;
    }
  }

  double rackCodeLocation(String rackType) {
    switch (rackType.toUpperCase()) {
      case 'BIGRACK':
        return 25.0;
      case 'SMALLRACK':
        return 10.0;
      case 'PALLET':
        return 20.0;
      default:
        return 25.0;
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    TextPainter textPainter;
    Paint paint;

    zoneData.listRack?.forEach((e) {
      paint = Paint()
        ..color = Colors.black
        ..strokeWidth = 2.0
        ..style = PaintingStyle.stroke;

      // Draw rack border
      canvas.drawRect(
        Offset(e.offsetX!, e.offsetY!) & Size(e.width!, e.height!),
        paint,
      );

      paint = Paint()
        ..color = Colors.yellow.withOpacity(0.5)
        ..strokeWidth = 2.0
        ..style = PaintingStyle.fill;
      canvas.drawRect(
        Offset(e.offsetX! + 10, e.offsetY! + 10) &
            Size(e.width! - 20, e.height! - 20),
        paint,
      );

      textPainter = TextPainter(
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      textPainter.text = TextSpan(
        text: e.rackCode,
        style: const TextStyle(
          color: Colors.black,
          fontSize: 30,
          fontWeight: FontWeight.w600,
        ),
      );

      // final position = Offset(
      //   e.offSetX! + rackCodeLocation(e.rackType ?? 'BIGRACK'),
      //   e.offSetY! + rackCodeLocation(e.rackType ?? 'BIGRACK'),
      // );

      // textPainter.layout();
      // textPainter.paint(canvas, position);

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
