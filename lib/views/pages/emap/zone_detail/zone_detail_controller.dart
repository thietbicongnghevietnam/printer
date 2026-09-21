import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/entities/ta_re_card_item.dart';
import 'package:smart_warehouse/repositories/emap_repository.dart';
import 'package:smart_warehouse/services/api_service.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';

import 'zone_detail_state.dart';

@injectable
class ZoneDetailController extends BaseCubit<ZoneDetailState> {
  ZoneDetailController(this._eMapService) : super(ZoneDetailState());
  final EMapRepository _eMapService;

  // List<ZoneDetailResponseModel> listZoneData = [
  //   ZoneDetailResponseModel(
  //     offSetX: 50,
  //     offSetY: 100,
  //     rackStatus: 0,
  //     unitTotal: 4,
  //     rackType: 'BigRack',
  //     rackID: '1011',
  //     rackCode: 'B.1011',
  //     rackRotation: 'hori',
  //   ),
  //   ZoneDetailResponseModel(
  //     offSetX: 50,
  //     offSetY: 200,
  //     rackType: 'BigRack',
  //     rackStatus: 1,
  //     unitTotal: 4,
  //     rackID: '1011',
  //     rackRotation: 'hori',
  //     rackCode: 'B.1011',
  //   ),
  //   ZoneDetailResponseModel(
  //     offSetX: 550,
  //     offSetY: 100,
  //     rackType: 'SmallRack',
  //     rackStatus: 2,
  //     unitTotal: 8,
  //     rackID: '1011',
  //     rackRotation: 'Hori',
  //     rackCode: 'S.1011',
  //   ),
  //   ZoneDetailResponseModel(
  //     offSetX: 550,
  //     offSetY: 150,
  //     rackType: 'SmallRack',
  //     rackStatus: 2,
  //     unitTotal: 8,
  //     rackID: '1011',
  //     rackRotation: 'hori',
  //     rackCode: 'S.1011',
  //   ),
  //   ZoneDetailResponseModel(
  //     offSetX: 50,
  //     offSetY: 400,
  //     rackType: 'Pallet',
  //     rackStatus: 2,
  //     // unitTotal: 8,
  //     rackID: '1011',
  //     rackRotation: 'hori',
  //     rackCode: 'P.1012',
  //   ),
  //   ZoneDetailResponseModel(
  //     offSetX: 50,
  //     offSetY: 525,
  //     rackType: 'Pallet',
  //     // rackStatus: 2,
  //     // unitTotal: 8,
  //     rackID: '1011',
  //     rackRotation: 'hori',
  //     rackCode: 'P.1011',
  //   ),
  //   ZoneDetailResponseModel(
  //     offSetX: 175,
  //     offSetY: 400,
  //     rackType: 'Pallet',
  //     // rackStatus: 2,
  //     // unitTotal: 8,
  //     rackID: '1011',
  //     rackRotation: 'verti',
  //     rackCode: 'P.1011',
  //   ),
  //   ZoneDetailResponseModel(
  //     offSetX: 175,
  //     offSetY: 525,
  //     rackType: 'Pallet',
  //     // rackStatus: 2,
  //     // unitTotal: 8,
  //     rackID: '1011',
  //     rackRotation: 'verti',
  //     rackCode: 'P.1011',
  //   ),
  //   ZoneDetailResponseModel(
  //     offSetX: 300,
  //     offSetY: 400,
  //     rackType: 'Pallet',
  //     // rackStatus: 2,
  //     // unitTotal: 8,
  //     rackID: '1011',
  //     rackRotation: 'verti',
  //     rackCode: 'P.1011',
  //   ),
  //   ZoneDetailResponseModel(
  //     offSetX: 300,
  //     offSetY: 525,
  //     rackType: 'Pallet',
  //     // rackStatus: 2,
  //     // unitTotal: 8,
  //     rackID: '1011',
  //     rackRotation: 'verti',
  //     rackCode: 'P.1011',
  //   ),
  // ];

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
          barCode: value,
        );
      } else {
        throw ValidationError(type: ValidationErrorType.receivingCardInvalid);
      }
    });
  }

  void loadZoneData({
    required int receivingCardId,
    int? zoneId,
  }) {
    launch(() async {
      // handleRackSize();
      await getZoneData(
        zoneId: zoneId,
        receivingCardId: receivingCardId,
      );
    });
  }

  void handleRackSize() {
    // List<ZoneDetailResponseModel> listRackConverted = listZoneData;
    // for (var i = 0; i < listRackConverted.length; i++) {
    //   listRackConverted[i] = ZoneDetailResponseModel(
    //     offSetX: listRackConverted[i].offSetX,
    //     offSetY: listRackConverted[i].offSetY,
    //     width: listRackConverted[i].rackRotation?.toLowerCase() == 'hori'
    //         ? rackCurrentSize(listRackConverted[i].rackType ?? 'Bigrack',
    //             listRackConverted[i].unitTotal ?? 1, true)
    //         : rackCurrentSize(listRackConverted[i].rackType ?? 'Bigrack',
    //             listRackConverted[i].unitTotal ?? 1, false),
    //     height: listRackConverted[i].rackRotation?.toLowerCase() == 'hori'
    //         ? rackCurrentSize(listRackConverted[i].rackType ?? 'Bigrack',
    //             listRackConverted[i].unitTotal ?? 1, false)
    //         : rackCurrentSize(listRackConverted[i].rackType ?? 'Bigrack',
    //             listRackConverted[i].unitTotal ?? 1, true),
    //     rackType: listRackConverted[i].rackType,
    //     rackStatus: listRackConverted[i].rackStatus,
    //     unitTotal: listRackConverted[i].unitTotal,
    //     rackID: listRackConverted[i].rackID,
    //     rackRotation: listRackConverted[i].rackRotation,
    //     rackCode: listRackConverted[i].rackCode,
    //   );
    // }
    // emit(state.copyWith(listRack: listRackConverted));
  }

  double rackSize(String rackType) {
    switch (rackType.toUpperCase()) {
      case 'BIGRACK':
        return 100.0;
      case 'SMALLRACK':
        return 50.0;
      case 'PALLET':
        return 125.0;
      default:
        return 100.0;
    }
  }

  double rackCurrentSize(
    String rackType,
    int unitTotal,
    bool hasMultiUnit,
  ) {
    return hasMultiUnit ? unitTotal * rackSize(rackType) : rackSize(rackType);
  }

  void clearData() {
    emit(
      state.copyWith(currentReCard: null),
    );
  }

  Future<void> getZoneData({
    int? zoneId,
    required int receivingCardId,
  }) async {
    emit(state.copyWith(pageStatus: PageStatus.loading));
    try {
      final zoneData = await _eMapService.getZoneDetailByReIdAndZoneId(
        zoneId: zoneId,
        receivingId: receivingCardId,
      );
      if (zoneData != null &&
          zoneData.listRack != null &&
          zoneData.listRack!.isNotEmpty) {
        emit(
          state.copyWith(
            zoneDetailData: zoneData,
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
}
