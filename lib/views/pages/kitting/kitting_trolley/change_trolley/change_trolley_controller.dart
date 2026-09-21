import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/repositories/supply_repository.dart';
import 'package:smart_warehouse/services/models/request/trolley_kitting_move_request_model.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/extensions/iterable_extensions.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';

import 'change_trolley_state.dart';

@injectable
class ChangeTrolleyController extends BaseCubit<ChangeTrolleyState> {
  ChangeTrolleyController(
    this._supplyRepository,
  ) : super(ChangeTrolleyState());

  final SupplyRepository _supplyRepository;

  Future<void> updateTrolleySource(String trolleySource) {
    return launch(() async {
      if (trolleySource.isNotEmpty) {
        validateTrolley(trolleySource, true);
      }

      emit(state.copyWith(trolleySource: trolleySource));
    });
  }

  Future<void> updateTrolleyEnd(String trolleyEnd) {
    return launch(() async {
      if (trolleyEnd.isNotEmpty) {
        validateTrolley(trolleyEnd, false);
      }

      emit(state.copyWith(trolleyEnd: trolleyEnd));
    });
  }

  Future<void> scanKittingList(String value) async {
    return launch(() async {
      if (value.isEmpty) {
        return;
      }
      _validateKittingList(value);

      List<String> clone = state.barCodeKittingList.clone();
      final checkVar = clone.any((e) => e == value);
      if(checkVar){
        throw ValidationError(type: ValidationErrorType.kittingListScanned);
      }
      clone.insert(0, value);

      emit(state.copyWith(barCodeKittingList: clone));
    });
  }

  Future<void> _validateKittingList(String barcode) async {
    if (barcode.isNotEmpty && barcode.contains(';')) {
      if (state.barCodeKittingList.isNotEmpty &&
          state.barCodeKittingList.contains(barcode)) {
        throw ValidationError(type: ValidationErrorType.kittingListScanned);
      }
    } else {
      throw ValidationError(type: ValidationErrorType.kittingCardInvalid);
    }
  }

  Future<void> removeKittingBarcode(int index) {
    return launch(() async {
      final listClone = state.barCodeKittingList.clone();

      listClone.removeAt(index);

      emit(state.copyWith(barCodeKittingList: listClone));
    });
  }

  void validateTrolley(String trolley, bool isTrolleySource) {
    if (trolley.contains(';') && trolley.contains('TL')) {
      final isSamePallet = isTrolleySource
          ? trolley == state.trolleyEnd
          : trolley == state.trolleySource;

      if (isSamePallet) {
        throw ValidationError(type: ValidationErrorType.trolleySame);
      }
    } else {
      throw ValidationError(type: ValidationErrorType.trolleyInvalid);
    }
  }

  Future<void> changeTrolley() async {
    return launch(() async {
      if ((state.trolleySource.isEmpty() || state.barCodeKittingList.isEmpty) &&
          state.trolleyEnd.isEmpty()) {
        throw ValidationError(type: ValidationErrorType.canNotEmpty);
      }

      final body = TrolleyKittingMoveRequestModel(
        trolleyOld: state.trolleySource,
        trolleyNew: state.trolleyEnd,
        barCodeKittingList: state.barCodeKittingList,
      );

      await _supplyRepository.moveKittingListLocation(body: body);

      clearData();
    });
  }

  void clearData() {
    emit(
      state.copyWith(
        trolleyEnd: null,
        trolleySource: null,
        barCodeKittingList: [],
      ),
    );
  }
}
