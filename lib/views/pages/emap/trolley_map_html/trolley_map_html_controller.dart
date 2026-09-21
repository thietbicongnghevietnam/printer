import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/repositories/emap_repository.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';

import 'trolley_map_html_state.dart';

@injectable
class TrolleyMapHTMLController extends BaseCubit<TrolleyMapHTMLState> {
  TrolleyMapHTMLController(this._eMapRepository) : super(TrolleyMapHTMLState());
  final EMapRepository _eMapRepository;

  void loadTrolleyMap({
    required String trolleyCode,
    required int kittingListId,
  }) {
    launch(() async {
      try {
        final res = await _eMapRepository.getMapTrolley();
        if (res != null && res.content != null && res.content != '') {
          emit(state.copyWith(trolleyMapData: res));
        }
      } catch (e) {
        logger.e(e);
      }
    });
  }
}
