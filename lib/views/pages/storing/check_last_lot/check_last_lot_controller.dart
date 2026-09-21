import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/services/api_service.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';

import 'check_last_lot_state.dart';

@injectable
class CheckLastLotController extends BaseCubit<CheckLastLotState> {
  CheckLastLotController(this._apiService) : super(CheckLastLotState());
  final ApiService _apiService;

  void onLoadData(int blockId) {
    launch(() async {
      await loadReCard(blockId);
    });
  }

  Future<void> loadReCard(int blockId) async {
    try {
      emit(state.copyWith(pageStatus: PageStatus.loading));
      final res = await _apiService.getReceivingCardByBlockId(blockId);

      if (res != null && res.isNotEmpty) {
        emit(
          state.copyWith(
            listReceivingCard: res,
            pageStatus: PageStatus.loaded,
          ),
        );
      } else {
        emit(state.copyWith(pageStatus: PageStatus.error));
      }
    } catch (e) {
      emit(state.copyWith(pageStatus: PageStatus.error));
      logger.e(e);
    }
  }
}
