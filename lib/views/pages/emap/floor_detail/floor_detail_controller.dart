import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/entities/ta_re_card_item.dart';
import 'package:smart_warehouse/repositories/emap_repository.dart';
import 'package:smart_warehouse/services/api_service.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';

import 'floor_detail_state.dart';

@injectable
class FloorDetailController extends BaseCubit<FloorDetailState> {
  FloorDetailController(this._eMapService) : super(FloorDetailState());
  final EMapRepository _eMapService;

  Future<void> scanReceivingCard(String value) {
    return launch(() async {
      if (value.isEmpty) {
        return;
      }
      if (value.isNotEmpty && value.contains(';')) {
        final splitPDAValue = value.split(';');
        // Lấy index 12 cho thông tin Material của ReCard
        final receivingMaterial = splitPDAValue[12];
        final receivingCardID = int.parse(splitPDAValue[0]);

        final item = CustomReCardItem(
          id: receivingCardID,
        );

        emit(
          state.copyWith(
            currentReCard: item,
          ),
        );
      } else {
        throw ValidationError(type: ValidationErrorType.receivingCardInvalid);
      }
    });
  }

  void clearData() {
    emit(
      state.copyWith(currentReCard: null),
    );
  }

  void loadFloorData(int receivingCardId) {
    launch(() async {
      await getFloorData(receivingCardId);
    });
  }

  Future<void> getFloorData(int receivingCardId) async {
    emit(state.copyWith(pageStatus: PageStatus.loading));
    try {
      final listZoneOnFloor = await _eMapService.getFloorDetailByReceivingCard(
          receivingId: receivingCardId);
      if (listZoneOnFloor != null && listZoneOnFloor.zoneList != null) {
        emit(
          state.copyWith(
            floorData: listZoneOnFloor,
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
