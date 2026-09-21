import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/entities/e_map/order_block.dart';
import 'package:smart_warehouse/entities/e_map/suggest_path.dart';
import 'package:smart_warehouse/entities/kitting/kitting_detail.dart';
import 'package:smart_warehouse/repositories/emap_repository.dart';
import 'package:smart_warehouse/repositories/kitting_repository.dart';
import 'package:smart_warehouse/repositories/master_repository.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';

import 'emap_kitting_state.dart';

@injectable
class EmapKittingController extends BaseCubit<EmapKittingState> {
  EmapKittingController(
    this._kittingRepository,
    this._eMapRepository,
    this._masterRepository,
  ) : super(EmapKittingState());

  final KittingRepository _kittingRepository;
  final EMapRepository _eMapRepository;
  final MasterRepository _masterRepository;

  late List<KittingDetail> listKittingDetails;
  late List<OrderBlock> orderBlocks;
  late List<SuggestPath> suggestPaths;

  @override
  Future<void> initData() {
    return launch(() async {
      final floorCode = listKittingDetails.first.locationName?[0] ?? '1';
      final floor = await _masterRepository.loadEmapKitting(floorCode);
      emit(
        state.copyWith(
          floor: floor,
          orderBlock: orderBlocks,
          suggestPath: suggestPaths
              .map((e) => SuggestPath(x: e.x/ 10, y: e.y/ 10))
              .toList(),
        ),
      );
    });
  }
}
