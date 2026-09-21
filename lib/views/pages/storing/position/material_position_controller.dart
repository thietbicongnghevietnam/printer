import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/repositories/storing_repository.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';

import 'material_position_state.dart';

@injectable
class MaterialPositionController extends BaseCubit<MaterialPositionState> {
  MaterialPositionController(this._storingRepository)
      : super(MaterialPositionState());
  final StoringRepository _storingRepository;

  Future<void> initDataMaterial(
    String material,
    String currentSloc,
  ) async {
    return launch(() async {
      try {
        final res = await _storingRepository.getPositionByMaterial(
          material: material,
          sloc: currentSloc,
        );

        if (res != null) {
          emit(state.copyWith(materialList: res));
        } else {
          throw ValidationError(type: ValidationErrorType.doNotHaveData);
        }
      } catch (e) {
        logger.e(e);
        throw ValidationError(type: ValidationErrorType.doNotHaveData);
      }
    });
  }
}
