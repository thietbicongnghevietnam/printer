import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/repositories/supply_repository.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';

import 'out_trolley_state.dart';

@injectable
class OutTrolleyController extends BaseCubit<OutTrolleyState> {
  OutTrolleyController(this._supplyRepository) : super(OutTrolleyState());

  final SupplyRepository _supplyRepository;

  Future<void> inputBarcode(String barcode) {
    return launch(() async {
      if (barcode.isEmpty) {
        return;
      }

      if (barcode.contains(';')) {
        emit(state.copyWith(trolleyBarcode: barcode));
      } else {
        throw ValidationError(type: ValidationErrorType.dataInvalid);
      }
    });
  }

  Future<void> outTrolley() async {
    return launch(() async {
      final kittingListBarcode = state.trolleyBarcode;
      if (kittingListBarcode == null) {
        throw ValidationError(type: ValidationErrorType.canNotEmpty);
      }
      await _supplyRepository.outKittingListLocation(
        kittingListQR: state.trolleyBarcode.value(),
      );
    });
  }

  void clearData() {
    emit(state.copyWith(trolleyBarcode: null));
  }
}
