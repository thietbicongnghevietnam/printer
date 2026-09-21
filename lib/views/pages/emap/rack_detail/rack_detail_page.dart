import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_warehouse/enums/emap_navigate_funciton.dart';
import 'package:smart_warehouse/enums/rack_type.dart';
import 'package:smart_warehouse/shared/base/base_page.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';
import 'package:smart_warehouse/views/pages/emap/map_widgets/button_back_emap.dart';
import 'package:smart_warehouse/views/pages/emap/map_widgets/draw_rack_3d.dart';
import 'package:smart_warehouse/views/pages/emap/map_widgets/zoom_widget.dart';
import 'package:smart_warehouse/views/widgets/rectangle_animation.dart';

import 'rack_detail_controller.dart';
import 'rack_detail_state.dart';

@RoutePage()
class RackDetailPage extends BasePage<RackDetailController, RackDetailState> {
  const RackDetailPage({
    super.key,
    required this.rackId,
    required this.receivingCardId,
    required this.eMapNavigateFunction,
    this.lastNodeName = '',
    this.rackType,
  });

  final int rackId;
  final int receivingCardId;

  final String lastNodeName;

  final RackType? rackType;

  final EMapNavigateFunction eMapNavigateFunction;

  @override
  BasePageState createState() {
    return RackDetailPageState(
      rackId: rackId,
      receivingCardId: receivingCardId,
      eMapNavigateFunction: eMapNavigateFunction,
    );
  }
}

class RackDetailPageState
    extends BasePageState<RackDetailController, RackDetailState> {
  RackDetailPageState({
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
    final lastNodeName = widget.as<RackDetailPage>()?.lastNodeName;
    context.read<RackDetailController>().loadRackData(
          rackId: rackId,
          receivingCardId: receivingCardId,
          lastNodeName: lastNodeName ?? '',
        );
  }

  @override
  Widget builder(context, cubit, state) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            BlocBuilder<RackDetailController, RackDetailState>(
              buildWhen: (prev, current) {
                return prev.listOffsetTap != current.listOffsetTap ||
                    prev.rackDataDetail != current.rackDataDetail ||
                    prev.pageStatus != current.pageStatus;
              },
              builder: (context, state) {
                final columnTotal = state.rackDataDetail?.numberOfUnit;
                if (state.rackDataDetail != null && columnTotal != null) {
                  return _buildBody(state, columnTotal);
                }
                return const SizedBox.shrink();
              },
            ),
            const ButtonBackEMap(),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(RackDetailState state, int columnTotal) {
    return ZoomMapWidget(
      maxZoomWidth: 200 + (columnTotal * 450),
      maxZoomHeight: 1500 + (columnTotal * 150),
      initTotalZoomOut: true,
      initScale: 0,
      canvasColor: const Color.fromRGBO(255, 255, 240, 1),
      child: Stack(
        children: [
          RepaintBoundary(
            child: DrawRack3DView(
              rackData: state.rackDataDetail,
              rackType: widget.as<RackDetailPage>()?.rackType,
            ),
          ),
          for (int i = 0; i < state.listOffsetTap.length; i++) ...[
            _buildTransformWidget(
              state.listOffsetTap[i].offset,
              GestureDetector(
                onTap: () {
                  if (eMapNavigateFunction == EMapNavigateFunction.storing) {
                    context.router.maybePop(state.listOffsetTap[i]);
                  }
                },
                child: (state.listOffsetTap[i].lastLotName != null &&
                        state.listOffsetTap[i].lastLotName!.isNotEmpty)
                    ? RepaintBoundary(
                        child: RectangleAnimation(
                          color: Colors.yellowAccent.withOpacity(0.1),
                          repeat: true,
                          delay: const Duration(milliseconds: 300),
                          maxHeight: 110,
                          maxWidth: 225,
                          minHeight: 100,
                          minWidth: 200,
                          child: Container(
                            height: 100,
                            width: 200,
                            color: Colors.greenAccent,
                            child: Center(
                              child: Text(
                                state.listOffsetTap[i].location?.substring(7) ??
                                    '',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 26,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        height: 100,
                        width: 200,
                        color: Colors.transparent,
                      ),
              ),
            ),
            if (eMapNavigateFunction == EMapNavigateFunction.storing &&
                state.listOffsetTap[i].lastLotName != null &&
                state.listOffsetTap[i].lastLotName!.isNotEmpty) ...[
              _buildTransformWidget(
                const Offset(
                  250,
                  1050,
                ),
                Text(
                  'Last node: ${!state.listOffsetTap[i].isStored ? 0 : state.listOffsetTap[i].lastLot}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 60,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              _buildTransformWidget(
                const Offset(
                  250,
                  1150,
                ),
                Text(
                  'Vị trí cuối: ${state.listOffsetTap[i].lastLotName}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 60,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              _buildTransformWidget(
                const Offset(
                  250,
                  1250,
                ),
                GestureDetector(
                  onTap: () async {
                    context.router.push(
                      CheckLastLotRoute(
                        blockId: state.listOffsetTap[i].blockId,
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 60,
                    ),
                    color: Colors.lightBlueAccent,
                    child: const Text(
                      'Kiểm tra vị trí cuối',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 60,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ],
      ),
    );
  }

  void _buildBottomSheetListReCard() {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) {
        return BlocBuilder<RackDetailController, RackDetailState>(
          builder: (BuildContext context, state) {
            return SizedBox(
              child: ListView.separated(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Text(
                        '${state.listReceivingCard[index].receivingCardId}',
                      ),
                      Text(
                        '${state.listReceivingCard[index].currentQuantity}',
                      ),
                      Text('${state.listReceivingCard[index].createdDate}'),
                      Text('${state.listReceivingCard[index].updatedDate}'),
                    ],
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(height: 20);
                },
                itemCount: state.listReceivingCard.length,
              ),
            );
          },
        );
      },
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
