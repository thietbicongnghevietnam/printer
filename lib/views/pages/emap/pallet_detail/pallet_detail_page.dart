import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/enums/emap_navigate_funciton.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/views/pages/emap/map_widgets/zoom_widget.dart';
import 'package:smart_warehouse/views/widgets/rectangle_animation.dart';

import 'pallet_detail_controller.dart';
import 'pallet_detail_state.dart';

@RoutePage()
class PalletDetailPage
    extends BasePage<PalletDetailController, PalletDetailState> {
  const PalletDetailPage({
    super.key,
    required this.rackId,
    required this.receivingCardId,
    required this.eMapNavigateFunction,
  });

  final int rackId;
  final int receivingCardId;

  final EMapNavigateFunction eMapNavigateFunction;

  @override
  BasePageState createState() {
    return PalletDetailPageState(
      rackId: rackId,
      receivingCardId: receivingCardId,
      eMapNavigateFunction: eMapNavigateFunction,
    );
  }
}

class PalletDetailPageState
    extends BasePageState<PalletDetailController, PalletDetailState> {
  PalletDetailPageState({
    required this.eMapNavigateFunction,
    required this.rackId,
    required this.receivingCardId,
  });

  final int rackId;
  final int receivingCardId;

  final EMapNavigateFunction eMapNavigateFunction;

  @override
  void initState() {
    super.initState();
    context.read<PalletDetailController>().loadRackData(
          rackId: rackId,
          receivingCardId: receivingCardId,
        );
  }

  @override
  Widget builder(context, cubit, state) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocBuilder<PalletDetailController, PalletDetailState>(
        buildWhen: (prev, current) {
          return prev.listOffsetTap != current.listOffsetTap ||
              prev.rackDataDetail != current.rackDataDetail ||
              prev.pageStatus != current.pageStatus;
        },
        builder: (context, state) {
          final columnTotal = state.rackDataDetail?.numberOfUnit;
          final rowTotal = state.rackDataDetail?.numberOfRow;
          if (state.rackDataDetail != null && columnTotal != null) {
            return ZoomMapWidget(
              maxZoomWidth: columnTotal * 180,
              maxZoomHeight: (rowTotal ?? 1).toDouble() * 450,
              initTotalZoomOut: true,
              initScale: 0,
              canvasColor: const Color.fromRGBO(255, 255, 240, 1),
              child: Stack(
                children: [
                  _buildTransformWidget(
                    const Offset(50, 50),
                    Text(
                      state.rackDataDetail?.rackCode ?? '',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  for (int i = 0; i < state.listOffsetTap.length; i++) ...[
                    _buildTransformWidget(
                      state.listOffsetTap[i].offset,
                      GestureDetector(
                        onTap: () {
                          if (eMapNavigateFunction ==
                              EMapNavigateFunction.storing) {
                            context.router.pop(state.listOffsetTap[i]);
                          }
                        },
                        child: (state.listOffsetTap[i].lastLot != null &&
                                state.listOffsetTap[i].lastLot! > 0)
                            ? RectangleAnimation(
                                color: Colors.yellowAccent.withOpacity(0.1),
                                repeat: true,
                                delay: const Duration(milliseconds: 300),
                                maxHeight: 110,
                                maxWidth: 125,
                                minHeight: 100,
                                minWidth: 100,
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.greenAccent,
                                    border: Border.all(
                                      color: Colors.black12,
                                      width: 2,
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      state.listOffsetTap[i].location ?? '',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            : Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  color:
                                      !state.listOffsetTap[i].isStored
                                          ? Colors.yellow
                                          : Colors.white,
                                  border: Border.all(
                                    color: Colors.black12,
                                    width: 2,
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    state.listOffsetTap[i].location ?? '',
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                      ),
                    ),
                    // if (eMapNavigateFunction ==
                    //         EMapNavigateFunction.storingFromDetail &&
                    //     state.listOffsetTap[i].lastLot != null &&
                    //     state.listOffsetTap[i].lastLot! >= 1) ...[
                    //   _buildTransformWidget(
                    //     const Offset(
                    //       150,
                    //       50,
                    //     ),
                    //     Text(
                    //       'Last lot: ${state.listOffsetTap[i].lastLot}',
                    //       style: const TextStyle(
                    //         color: Colors.black,
                    //         fontSize: 60,
                    //         fontWeight: FontWeight.w700,
                    //       ),
                    //     ),
                    //   ),
                    //   _buildTransformWidget(
                    //     const Offset(
                    //       150,
                    //       70,
                    //     ),
                    //     Text(
                    //       'Vị trí cuối: ${state.listOffsetTap[i].lastLotName}',
                    //       style: const TextStyle(
                    //         color: Colors.black,
                    //         fontSize: 60,
                    //         fontWeight: FontWeight.w700,
                    //       ),
                    //     ),
                    //   ),
                    //   _buildTransformWidget(
                    //     const Offset(
                    //       150,
                    //       80,
                    //     ),
                    //     GestureDetector(
                    //       onTap: () async {
                    //         context.router.push(
                    //           CheckLastLotRoute(
                    //               blockId: state.listOffsetTap[i].blockId),
                    //         );
                    //       },
                    //       child: Container(
                    //         padding: const EdgeInsets.symmetric(
                    //             vertical: 20, horizontal: 60),
                    //         color: Colors.lightBlueAccent,
                    //         child: const Text(
                    //           'Kiểm tra vị trí cuối',
                    //           style: TextStyle(
                    //             color: Colors.white,
                    //             fontSize: 60,
                    //             fontWeight: FontWeight.w700,
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ],
                  ],
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildTransformWidget(
    Offset offset,
    Widget child,
  ) {
    return Transform.translate(
      offset: offset,
      child: child,
    );
  }
}

class IndoorBorder1FMap extends StatelessWidget {
  const IndoorBorder1FMap({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: IndoorMapPainter(),
    );
  }
}

class IndoorMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 5.0
      ..style = PaintingStyle.fill;

    canvas.drawLine(const Offset(10, 10), const Offset(10, 1250), paint);
    canvas.drawLine(const Offset(10, 1250), const Offset(1000, 1250), paint);
    canvas.drawLine(const Offset(1000, 10), const Offset(1000, 1250), paint);
    canvas.drawLine(const Offset(1000, 10), const Offset(10, 10), paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
