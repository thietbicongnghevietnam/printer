import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/entities/e_map/offset_block_detail.dart';
import 'package:smart_warehouse/entities/ta_re_card_item.dart';
import 'package:smart_warehouse/repositories/emap_repository.dart';
import 'package:smart_warehouse/services/models/response/rack_detail_response_model.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';

import 'rack_detail_state.dart';

@injectable
class RackDetailController extends BaseCubit<RackDetailState> {
  RackDetailController(this._eMapRepository) : super(RackDetailState());
  final EMapRepository _eMapRepository;

  void loadRackData({
    required int rackId,
    required int receivingCardId,
    String lastNodeName = '',
  }) {
    launch(() async {
      // setOffSet();
      await getRackDetail(
        rackId: rackId,
        receivingCardId: receivingCardId,
        lastNodeName: lastNodeName,
      );
    });
  }

  Future<void> getRackDetail({
    required int rackId,
    required int receivingCardId,
    String lastNodeName = '',
  }) async {
    try {
      emit(state.copyWith(pageStatus: PageStatus.loading));
      final res = await _eMapRepository.getRackDetail(
        rackId: rackId,
        receivingId: receivingCardId,
        lastNodeName: lastNodeName,
      );
      if (res != null && res.blockList != null && res.blockList!.isNotEmpty) {
        await setOffSet(res);
        emit(
          state.copyWith(
            rackDataDetail: res,
            pageStatus: PageStatus.loaded,
          ),
        );
      } else {
        emit(state.copyWith(pageStatus: PageStatus.error));
      }
    } catch (e) {
      logger.e(e);
      emit(state.copyWith(pageStatus: PageStatus.error));
    }
  }

  Future<void> setOffSet(RackDetailResponseModel rackData) async {
    double offSetConX1 = 250;
    double offSetConY1 = 750;
    List<OffsetBlockDetail> currentOffset = [];

    rackData.blockList?.forEach((element) {
      element.listLayers.forEach((eChild) {
        currentOffset.add(
          OffsetBlockDetail(
            offset: Offset(offSetConX1, offSetConY1),
            blockId: eChild.blockId ?? 0,
            location: eChild.blockName ?? '',
            lastLot: eChild.lastLot ?? 0,
            lastLotName: ((eChild.lastNodeName != null &&
                        eChild.lastNodeName!.isNotEmpty)
                    ? eChild.blockName
                    : '') ??
                '',
            isStored: eChild.isStored ?? false,
          ),
        );
        offSetConX1 = offSetConX1 + 200;
      });

      offSetConY1 = offSetConY1 - 100;
      offSetConX1 = 250;
    });

    /// Backup with Old base logic
    // rackData.blockList?.forEach((element) {
    //   element.listLayers.forEach((eChild) {
    //
    //     currentOffset.add(OffsetBlockDetail(
    //       offset: Offset(offSetConX1, offSetConY1),
    //       blockId: eChild.blockId ?? 0,
    //       location: eChild.blockName ?? '',
    //       lastLot: eChild.lastLot ?? 0,
    //       lastLotName:
    //           ((eChild.lastNodeName != null && eChild.lastNodeName!.isNotEmpty )
    //                   ? eChild.blockName
    //                   : '') ??
    //               '',
    //     ));
    //
    //     offSetConY1 = offSetConY1 - 100;
    //   });
    //
    //   offSetConX1 = offSetConX1 + 200;
    //   offSetConY1 = 750;
    // });

    emit(state.copyWith(listOffsetTap: currentOffset));
  }

  Future<bool> onLoadReCard(int blockId) async {
    try {
      final res =
          await _eMapRepository.getReceivingCardByBlockId(blockId: blockId);

      if (res != null && res.isNotEmpty) {
        emit(
          state.copyWith(
            listReceivingCard: res,
            loadedReceivingCard: true,
          ),
        );
        return true;
      } else {
        emit(state.copyWith(
          loadedReceivingCard: false,
        ));
        return false;
      }
    } catch (e) {
      logger.e(e);
      return false;
    }
  }
}

class DrawDiagonal {
  DrawDiagonal({
    this.startX,
    this.startY,
  });

  final double? startX;
  final double? startY;
}
