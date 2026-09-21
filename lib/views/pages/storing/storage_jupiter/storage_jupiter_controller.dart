import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/enums/storage_scan_recard_error.dart';
import 'package:smart_warehouse/repositories/receiving_card_repository.dart';
import 'package:smart_warehouse/repositories/storing_repository.dart';
import 'package:smart_warehouse/services/api_service.dart';
import 'package:smart_warehouse/services/models/response/receiving_card_response_model.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';

import 'storage_jupiter_state.dart';

@injectable
class StorageJupiterController extends BaseCubit<StorageJupiterState> {
  StorageJupiterController(
    this._rcService,
    this._storingRepository,
  ) : super(StorageJupiterState());

  final ReceivingCardRepository _rcService;
  final StoringRepository _storingRepository;

  late FocusNode palletSourceFocusNode;
  late FocusNode palletEndFocusNode;

  Future<void> scanReceivingCard(String value) async {
    var currentReCardList = List<ReceivingCard>.from(state.listReCard);

    if (value.isEmpty) {
      return;
    }

    try {
      launch(() async {
        if (value.isNotEmpty && value.contains(';')) {
          final splitPDAValue = value.split(';');
          final receivingCardID = int.parse(splitPDAValue[0]);

          final hasReCard =
              currentReCardList.any((e) => e.id == receivingCardID);

          if (hasReCard) {
            emit(state.copyWith(
                storageScanReCardError: StorageScanReCardError.reCardScanned));

            throw ValidationError(
                type: ValidationErrorType.receivingCardScanned);
          }

          final response = await _rcService.getReceivingCard(receivingCardID);

          currentReCardList = [];

          currentReCardList.add(response);

          emit(
            state.copyWith(
              listReCard: currentReCardList,
              currentReCard: response,
            ),
          );
        } else {
          emit(state.copyWith(
              storageScanReCardError:
                  StorageScanReCardError.receivingCardInvalid));
          throw ValidationError(type: ValidationErrorType.receivingCardInvalid);
        }
      });
    } catch (e) {
      logger.e(e);
    }
  }

  Future<bool> removeReCard(int index) async {
    final listReceivingCard = List<ReceivingCard>.from(state.listReCard);
    final currentReceivingCard = state.currentReCard;
    if (listReceivingCard.isNotEmpty) {
      if (listReceivingCard[index] == currentReceivingCard) {
        emit(state.copyWith(currentReCard: null));
      }
      listReceivingCard.removeAt(index);
      emit(state.copyWith(listReCard: listReceivingCard));
      return true;
    }
    return false;
  }

  Future<void> storingJupiter() async {
    return launch(() async {
      final receivingCardList = state.listReCard;

      if (receivingCardList.isNotEmpty) {
        final reId = receivingCardList.first.id;

        if (reId != 0) {
          await _storingRepository.storingJupiter(receivingCardId: reId);
          logger.i('storing jupiter successfully');
          clearData();
        }
      } else {
        throw ValidationError(type: ValidationErrorType.canNotEmpty);
      }
    });
  }

  void clearData() {
    emit(
      state.copyWith(
        listReCard: [],
        currentReCard: null,
        location: null,
      ),
    );
  }
}
