import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/entities/ta_re_card_item.dart';
import 'package:smart_warehouse/repositories/receiving_card_repository.dart';
import 'package:smart_warehouse/repositories/storing_repository.dart';
import 'package:smart_warehouse/services/api_service.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';

import 'check_material_in_store_state.dart';

@injectable
class CheckMaterialInStoreController
    extends BaseCubit<CheckMaterialInStoreState> {
  CheckMaterialInStoreController(
    this._storingRepository,
    this._receivingCardRepository,
  ) : super(CheckMaterialInStoreState());

  final StoringRepository _storingRepository;
  final ReceivingCardRepository _receivingCardRepository;

  late String? positionOrRc;

  @override
  Future<void> initData() {
    return launch(() async {
      if(positionOrRc != null) {
        await scanReceivingCard(positionOrRc!);
      }
    });
  }

  Future<void> scanReceivingCard(String value) async {
    return launch(() async {
      if (value.isEmpty) {
        return;
      }
      if (value.isNotEmpty && value.contains(';')) {
        final rcId = ReceivingCard.getReceivingCardID(value);

        final rcData = await _receivingCardRepository.getReceivingCard(rcId);

        emit(state.copyWith(currentReCard: rcData));
      } else {
        final res =
            await _storingRepository.getMaterialByLocation(locationName: value);
        if (res != null && res.isNotEmpty) {
          emit(
            state.copyWith(
              materialList: res,
              position: value,
            ),
          );
        } else {
          throw ValidationError(type: ValidationErrorType.doNotHaveData);
        }
      }
    });
  }
}
