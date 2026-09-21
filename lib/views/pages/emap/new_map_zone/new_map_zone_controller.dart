import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/entities/e_map/emap_widget.dart';
import 'package:smart_warehouse/entities/e_map/emap_zone.dart';
import 'package:smart_warehouse/entities/ta_re_card_item.dart';
import 'package:smart_warehouse/repositories/emap_repository.dart';
import 'package:smart_warehouse/services/api_service.dart';
import 'package:smart_warehouse/services/models/response/new_map_widget_response_model.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';

import 'new_map_zone_state.dart';

@injectable
class NewMapZoneController extends BaseCubit<NewMapZoneState> {
  NewMapZoneController(this._eMapService) : super(NewMapZoneState());
  final EMapRepository _eMapService;

  void loadZoneData({
    required int receivingCardId,
    EMapZone? zoneMapData,
    int? zoneId,
  }) {
    launch(() async {
      await getZoneData(
        zoneId: zoneId,
        receivingCardId: receivingCardId,
        zoneMapData: zoneMapData,
      );
    });
  }

  Future<void> getZoneData({
    int? zoneId,
    required int receivingCardId,
    EMapZone? zoneMapData,
  }) async {
    emit(state.copyWith(pageStatus: PageStatus.loading));
    try {
      emit(
        state.copyWith(
          zoneMapData: zoneMapData,
          pageStatus: PageStatus.loaded,
        ),
      );
    } catch (e) {
      logger.e(e);
      emit(state.copyWith(pageStatus: PageStatus.error));
    }
  }

  void clearData() {
    emit(
      state.copyWith(currentReCard: null),
    );
  }
}
