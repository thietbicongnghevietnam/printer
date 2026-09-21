import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/entities/e_map/offset_block_detail.dart';
import 'package:smart_warehouse/entities/ta_re_card_item.dart';
import 'package:smart_warehouse/repositories/emap_repository.dart';
import 'package:smart_warehouse/services/api_service.dart';
import 'package:smart_warehouse/services/models/response/rack_detail_response_model.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';

import 'pallet_detail_state.dart';

@injectable
class PalletDetailController extends BaseCubit<PalletDetailState> {
  PalletDetailController(this._eMapService) : super(PalletDetailState());
  final EMapRepository _eMapService;

  Future<void> scanReceivingCard(String value) {
    return launch(() async {
      if (value.isEmpty) {
        return;
      }
      if (value.isNotEmpty && value.contains(';')) {
        final splitPDAValue = value.split(';');
        // Lấy index 12 cho thông tin Material của ReCard
        final receivingCardID = int.parse(splitPDAValue[0]);

        final item = CustomReCardItem(
          id: receivingCardID,
        );
      } else {
        throw ValidationError(type: ValidationErrorType.receivingCardInvalid);
      }
    });
  }

  void loadRackData({
    required int rackId,
    required int receivingCardId,
  }) {
    launch(() async {
      // setOffSet();
      await getRackDetail(
        rackId: rackId,
        receivingCardId: receivingCardId,
      );
    });
  }

  Future<void> getRackDetail({
    required int rackId,
    required int receivingCardId,
  }) async {
    try {
      emit(state.copyWith(pageStatus: PageStatus.loading));
      final res = await _eMapService.getRackDetail(
        rackId: rackId,
        receivingId: receivingCardId,
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
    double offSetConX1 = 150;
    double offSetConY1 = 150;
    List<OffsetBlockDetail> currentOffset = [];

    final revertList = rackData.blockList?.reversed ?? [];
    for (var e in revertList) {
      e.listLayers?.forEach((eChild) {
        currentOffset.add(
          OffsetBlockDetail(
            offset: Offset(offSetConX1, offSetConY1),
            blockId: eChild.blockId ?? 0,
            location: eChild.blockName ?? '',
            lastLot: eChild.lastLot ?? 0,
            lastLotName: ((eChild.lastLot != null && eChild.lastLot! >= 1)
                    ? eChild.blockName
                    : '') ??
                '',
            isStored: eChild.isStored ?? false,
          ),
        );

        offSetConY1 = offSetConY1 + 100;
      });

      offSetConX1 = offSetConX1 + 100;
      offSetConY1 = 150;
    }

    emit(state.copyWith(listOffsetTap: currentOffset));
  }

  Future<bool> onLoadReCard(int blockId) async {
    try {
      final res = await _eMapService.getReceivingCardByBlockId(blockId: blockId);

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
