import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/enums/in_out_type.dart';
import 'package:smart_warehouse/repositories/receiving_card_repository.dart';
import 'package:smart_warehouse/repositories/temporary_area_repository.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/constants.dart';
import 'package:smart_warehouse/shared/extensions/iterable_extensions.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';

import 'move_receiving_card_state.dart';

@injectable
class MoveReceivingCardController extends BaseCubit<MoveReceivingCardState> {
  MoveReceivingCardController(
    this._receivingCardRepository,
    this._temporaryAreaRepository,
  ) : super(MoveReceivingCardState());

  final ReceivingCardRepository _receivingCardRepository;
  final TemporaryAreaRepository _temporaryAreaRepository;

  void updateInOutType(InOutType? inOutType) {
    emit(state.copyWith(inOutType: inOutType ?? InOutType.oneByOne));
  }

  Future<void> addReceivingCard(String code) {
    return launch(() async {
      final receivingCardID = ReceivingCard.getReceivingCardID(code);

      if (state.listReceivingCards.any((element) => element.barcode == code)) {
        throw ValidationError(type: ValidationErrorType.receivingCardScanned);
      }

      final rc =
          await _receivingCardRepository.getReceivingCard(receivingCardID);

      if (rc.temporaryAreaCode.isEmpty()) {
        throw ValidationError(
          type: ValidationErrorType.receivingCardNotInputLocation,
        );
      }

      if (state.palletSource != null &&
          rc.temporaryAreaCode != state.palletSource) {
        throw ValidationError(
          type: ValidationErrorType.receivingCardExistInPallet,
        );
      }

      final listRC = state.listReceivingCards.clone()..insert(0, rc);

      emit(
        state.copyWith(
          listReceivingCards: listRC,
          currentReceivingCard: code,
          palletSource: rc.temporaryAreaCode,
        ),
      );
    });
  }

  Future<void> updatePalletSource(String palletSource) {
    return launch(() async {
      if (palletSource.isNotEmpty) {
        validatePallet(palletSource, true);
      }

      emit(state.copyWith(palletSource: palletSource));
    });
  }

  Future<void> updatePalletEnd(String palletEnd) {
    return launch(() async {
      if (palletEnd.isNotEmpty) {
        validatePallet(palletEnd, false);
      }

      emit(state.copyWith(palletEnd: palletEnd));
    });
  }

  void validatePallet(String pallet, bool isPalletSource) {
    if (!pallet.contains(Constants.pl)) {
      throw ValidationError(type: ValidationErrorType.palletInvalid);
    }

    final isSamePallet = isPalletSource
        ? pallet == state.palletEnd
        : pallet == state.palletSource;

    if (isSamePallet) {
      throw ValidationError(type: ValidationErrorType.palletSame);
    }
  }

  Future<bool> removeReceivingCard(int index) async {
    final currentReceivingCard = state.listReceivingCards.clone();
    if (currentReceivingCard.isNotEmpty) {
      currentReceivingCard.removeAt(index);
      emit(state.copyWith(listReceivingCards: currentReceivingCard));
      return true;
    }
    return false;
  }

  Future<void> combinePallet() async {
    return launch(() async {
      switch(state.inOutType) {
        case InOutType.oneByOne:
          final receivingCardList = state.listReceivingCards;
          if (receivingCardList.isEmpty || state.palletEnd.isEmpty()) {
            throw ValidationError(type: ValidationErrorType.canNotEmpty);
          }

          final listRC = state.listReceivingCards.map((e) => e.id ?? 0).toList();
          await _temporaryAreaRepository.combinePallet(
            receivingCardIds: listRC,
            temporaryAreaCodeNew: state.palletEnd.value(),
          );
        case InOutType.all:
          if (state.palletSource.isEmpty() || state.palletEnd.isEmpty()) {
            throw ValidationError(type: ValidationErrorType.canNotEmpty);
          }

          await _temporaryAreaRepository.movePallet(
            palletSource: state.palletSource.value(),
            palletEnd: state.palletEnd.value(),
          );
      }

      clearData();
    });
  }

  void clearData() {
    emit(
      state.copyWith(
        palletSource: null,
        palletEnd: null,
        listReceivingCards: [],
        currentReceivingCard: null,
      ),
    );
  }
}
