import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/repositories/storing_repository.dart';
import 'package:smart_warehouse/services/models/response/history_information_response_model.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';

import 'material_history_transition_state.dart';

@injectable
class MaterialHistoryTransitionController
    extends BaseCubit<MaterialHistoryTransitionState> {
  MaterialHistoryTransitionController(this._storingRepository)
      : super(
          MaterialHistoryTransitionState(
            fromDate: DateTime.now(),
            toDate: DateTime.now(),
          ),
        );
  final StoringRepository _storingRepository;

  Future<void> initDataMaterial(String material, String sloc) async {
    return launch(() async {
      try {
        emit(state.copyWith(currentSloc: sloc));
        final res = await _storingRepository.getHistoryBlockTransition(
          material: material,
          sloc: sloc,
        );
        if (res != null &&
            res.recordDetail != null &&
            res.recordDetail!.isNotEmpty) {
          List<HistoryInformationResponseModel> listSort =
              res.recordDetail ?? [];
          listSort = listSort.reversed.toList();

          emit(
            state.copyWith(
              materialHistoryTransition: res,
              listSlocOnMaterial: res.slocs ?? [],
              historyList: listSort,
              isOpenPage: true,
            ),
          );
        }
      } catch (e) {
        logger.e(e);
        throw ValidationError(type: ValidationErrorType.doNotHaveData);
      }
    });
  }

  void onChangeFromDate(DateTime value) {
    emit(state.copyWith(
      fromDate: value,
      isOpenPage: false,
    ));
  }

  void onChangeToDate(DateTime value) {
    emit(state.copyWith(
      toDate: value,
      isOpenPage: false,
    ));
  }

  Future<void> onSearch({required String material, String? sloc}) async {
    return launch(() async {
      emit(
        state.copyWith(
          onSearchHistory: false,
          historyList: [],
          currentSloc: sloc,
        ),
      );
      try {
        final fromDate = state.fromDate;
        final toDate = state.toDate;
        final res = await _storingRepository.getHistoryBlockTransition(
          material: material,
          fromDate: fromDate,
          toDate: toDate,
          sloc: sloc,
        );
        if (res != null &&
            res.recordDetail != null &&
            res.recordDetail!.isNotEmpty) {
          List<HistoryInformationResponseModel> listSort =
              res.recordDetail ?? [];
          listSort = listSort.reversed.toList();

          emit(state.copyWith(
            materialHistoryTransition: res,
            historyList: listSort,
            onSearchHistory: true,
            isOpenPage: false,
          ));
        } else {
          throw ValidationError(type: ValidationErrorType.doNotHaveData);
        }
      } catch (e) {
        logger.e(e);
        throw ValidationError(type: ValidationErrorType.doNotHaveData);
      }
    });
  }

  void onActiveBack(String positionBack) {
    emit(state.copyWith(
      hasActiveBack: true,
      positionBack: positionBack,
    ));
  }
}
