import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/entities/kitting/kitting_card.dart';
import 'package:smart_warehouse/repositories/kitting_repository.dart';
import 'package:smart_warehouse/services/translators/kitting_translator.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/views/pages/kitting/find_kitting_list/find_kitting_list_state.dart';

@injectable
class FindKittingListController extends BaseCubit<FindKittingListState> {
  FindKittingListController(this._kittingRepository)
      : super(FindKittingListState());
  final KittingRepository _kittingRepository;

  Future<void> scanKittingCard(String code) async {
    return launch(() async {
      final kittingCardId = KittingCard.getKittingCardID(code);
      final kittingData =
          await _kittingRepository.getKittingListWithTrolley(kittingCardId);
      if (kittingData != null) {
        final kittingList = kittingData.kittingList?.toEntity();
        emit(
          state.copyWith(
            kittingList: kittingList,
            codeTrolleys: kittingData.trolleyCodeList,
          ),
        );
      } else {
        throw ValidationError(type: ValidationErrorType.kittingListNotExist);
      }
    });
  }
}
