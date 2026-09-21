import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/repositories/storing_repository.dart';
import 'package:smart_warehouse/services/api_service.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';

import 'material_sample_state.dart';

@injectable
class MaterialSampleController extends BaseCubit<MaterialSampleState> {
  MaterialSampleController(this._storingRepository) : super(MaterialSampleState());
  final StoringRepository _storingRepository;

  Future<void> initDataMaterial(String material) async {
    return launch(() async {
      try {
        final res = await _storingRepository.getSampleMaterial(material: material);
        if (res != null) {
          emit(state.copyWith(materialSample: res));
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
