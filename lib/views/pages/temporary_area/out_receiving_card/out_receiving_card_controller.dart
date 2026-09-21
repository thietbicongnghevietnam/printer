import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/enums/in_out_type.dart';
import 'package:smart_warehouse/repositories/receiving_card_repository.dart';
import 'package:smart_warehouse/repositories/temporary_area_repository.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/constants.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';

import 'out_receiving_card_state.dart';

@injectable
class OutReceivingCardController extends BaseCubit<OutReceivingCardState> {
  OutReceivingCardController(
    this._temporaryAreaRepository,
    this._receivingCardRepository,
  ) : super(OutReceivingCardState());

  final TemporaryAreaRepository _temporaryAreaRepository;
  final ReceivingCardRepository _receivingCardRepository;

  void updateInOutType(InOutType? inOutType) {
    emit(state.copyWith(inOutType: inOutType ?? InOutType.oneByOne ));
    clearData();
  }

  Future<void> updateReceivingCard(String barcode) {
    return launch(() async {
      if (barcode.isEmpty) {
        return;
      }

      final rcID = ReceivingCard.getReceivingCardID(barcode);

      final receivingCards =
          await _receivingCardRepository.getReceivingCard(rcID);

      emit(
        state
            .copyWith(receivingCard: barcode, receivingCards: [receivingCards]),
      );
    });
  }

  Future<void> updatePallet(String pallet) {
    return launch(() async {
      if (pallet.isEmpty) {
        return;
      }

      if (!pallet.contains(Constants.pl)) {
        throw ValidationError(type: ValidationErrorType.palletInvalid);
      }

      final receivingCards =
          await _receivingCardRepository.searchReceivingCards(pallet: pallet);

      emit(
        state.copyWith(
          pallet: pallet,
          receivingCards: receivingCards
            ..sort((a, b) {
              if (a.isNG == b.isNG) {
                return 0;
              } else if (a.isNG) {
                return -1;
              } else {
                return 1;
              }
            }),
        ),
      );
    });
  }

  Future<void> outTemporary() async {
    return launch(() async {
      switch (state.inOutType) {
        case InOutType.oneByOne:
          final receivingCard = state.receivingCard;
          if (receivingCard == null) {
            throw ValidationError(type: ValidationErrorType.canNotEmpty);
          }

          await _temporaryAreaRepository.outReceivingCard(
            barcode: receivingCard.value(),
          );
        case InOutType.all:
          if (state.pallet.isEmpty()) {
            throw ValidationError(type: ValidationErrorType.canNotEmpty);
          }

          await _temporaryAreaRepository.outPallet(
            pallet: state.pallet.value(),
          );
      }
    });
  }

  void clearData() {
    emit(state.copyWith(receivingCard: null, pallet: null, receivingCards: []));
  }
}
