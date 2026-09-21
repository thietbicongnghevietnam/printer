import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/repositories/receiving_card_repository.dart';
import 'package:smart_warehouse/repositories/temporary_area_repository.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/constants.dart';
import 'package:smart_warehouse/shared/extensions/iterable_extensions.dart';

import 'input_location_state.dart';

@injectable
class InputLocationController extends BaseCubit<InputLocationState> {
  InputLocationController(
    this._receivingCardRepository,
    this._temporaryAreaRepository,
  ) : super(InputLocationState());
  final ReceivingCardRepository _receivingCardRepository;
  final TemporaryAreaRepository _temporaryAreaRepository;

  Future<void> updatePallet(String pallet) {
    return launch(() async {
      if (pallet.isEmpty) {
        clearData();
        return;
      }
      validatePallet(pallet);

      final receivingCardsInPallet =
          await _receivingCardRepository.searchReceivingCards(pallet: pallet);

      emit(
        state.copyWith(
          palletData: pallet,
          listReceivingCardInPallet: receivingCardsInPallet,
        ),
      );
    });
  }

  void validatePallet(String pallet) {
    if (!pallet.contains(Constants.pl)) {
      throw ValidationError(type: ValidationErrorType.palletInvalid);
    }
  }

  Future<void> addReceivingCard(String barcode) {
    return launch(() async {
      await _validateReceivingCard(barcode);
      final currentReCard = state.listReceivingCard.clone()..insert(0, barcode);

      emit(
        state.copyWith(
          listReceivingCard: currentReCard,
          receivingCardData: barcode,
        ),
      );
    });
  }

  Future<void> _validateReceivingCard(String barcode) async {
    final receivingCardID = ReceivingCard.getReceivingCardID(barcode);
    if (state.listReceivingCard.any((element) => element == barcode)) {
      throw ValidationError(type: ValidationErrorType.receivingCardScanned);
    }
    if (state.listReceivingCardInPallet.any((e) => e.barcode == barcode)) {
      throw ValidationError(
        type: ValidationErrorType.receivingCardExistInPallet,
      );
    }

    final receivingCard =
        await _receivingCardRepository.getReceivingCard(receivingCardID);

    if (receivingCard.temporaryAreaCode?.toLowerCase() != 'outok' &&
        receivingCard.temporaryAreaCode?.toLowerCase() != 'notyet') {
      throw ValidationError(
        type: ValidationErrorType.receivingCardExistInPallet,
      );
    }
  }

  bool removeBarcode(int index) {
    if (state.listReceivingCard.isEmpty) {
      return false;
    }

    final currentReCard = state.listReceivingCard.clone()..removeAt(index);
    emit(
      state.copyWith(
        listReceivingCard: currentReCard,
        receivingCardData: null,
      ),
    );
    return true;
  }

  Future<void> inputLocation() async {
    return launch(() async {
      final currentPallet = state.palletData ?? '';
      final receivingCardList = state.listReceivingCard;

      if (currentPallet.isEmpty || receivingCardList.isEmpty) {
        throw ValidationError(type: ValidationErrorType.canNotEmpty);
      }

      final receivingCardIds = receivingCardList
          .map((e) => ReceivingCard.getReceivingCardID(e))
          .toList();

      await _temporaryAreaRepository.inputLocation(
        currentPallet,
        receivingCardIds,
      );
    });
  }

  Future<void> clearData() async {
    emit(
      state.copyWith(
        palletData: null,
        receivingCardData: null,
        listReceivingCard: [],
        listReceivingCardInPallet: [],
      ),
    );
  }
}
