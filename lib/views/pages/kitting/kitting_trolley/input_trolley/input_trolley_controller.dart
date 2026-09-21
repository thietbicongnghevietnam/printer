import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/repositories/supply_repository.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/extensions/iterable_extensions.dart';

import 'input_trolley_state.dart';

@injectable
class InputTrolleyController extends BaseCubit<InputTrolleyState> {
  InputTrolleyController(
    this._supplyRepository,
  ) : super(InputTrolleyState());
  final SupplyRepository _supplyRepository;

  Future<void> updateTrolley(String trolley) {
    return launch(() async {
      if (trolley.isEmpty) {
        clearData();
        return;
      }
      if (trolley.contains(';') && trolley.contains('TL')) {
        emit(state.copyWith(trolley: trolley));
      } else {
        throw ValidationError(type: ValidationErrorType.trolleyInvalid);
      }
    });
  }

  Future<void> addKittingList(String barcode) {
    return launch(() async {
      await _validateKittingList(barcode);

      final listClone = state.listKittingCardQr.clone();

      listClone.add(barcode);

      emit(state.copyWith(listKittingCardQr: listClone));
    });
  }

  Future<void> _validateKittingList(String barcode) async {
    if (barcode.isNotEmpty && barcode.contains(';')) {
      if (state.listKittingCardQr.isNotEmpty &&
          state.listKittingCardQr.contains(barcode)) {
        throw ValidationError(type: ValidationErrorType.kittingListScanned);
      }
    } else {
      throw ValidationError(type: ValidationErrorType.kittingCardInvalid);
    }
  }

  Future<void> removeKittingBarcode(int index) {
    return launch(() async {

      final listClone = state.listKittingCardQr.clone();

      listClone.removeAt(index);

      emit(state.copyWith(listKittingCardQr: listClone));
    });
  }

  Future<void> inputLocation() async {
    return launch(() async {
      final currentTrolley = state.trolley;
      final kittingList = state.listKittingCardQr;

      if (currentTrolley.isEmpty || kittingList.isEmpty) {
        throw ValidationError(type: ValidationErrorType.canNotEmpty);
      }

      await _supplyRepository.inputKittingListLocation(
        kittingListQR: kittingList,
        codeTrolley: currentTrolley,
      );
    });
  }

  Future<void> clearData() async {
    emit(state.copyWith(trolley: '', listKittingCardQr: []));
  }
}
