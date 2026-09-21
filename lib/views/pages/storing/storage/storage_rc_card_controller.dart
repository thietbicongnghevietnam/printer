import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/entities/e_map/offset_block_detail.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/enums/storage_scan_recard_error.dart';
import 'package:smart_warehouse/repositories/receiving_card_repository.dart';
import 'package:smart_warehouse/repositories/storing_repository.dart';
import 'package:smart_warehouse/services/api_service.dart';
import 'package:smart_warehouse/services/models/request/store_recard_request_model.dart';
import 'package:smart_warehouse/services/models/response/receiving_card_response_model.dart';
import 'package:smart_warehouse/services/translators/receiving_card_translator.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/extensions/duration_extensions.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';

import 'storage_rc_card_state.dart';

@injectable
class StorageRCCardController extends BaseCubit<StorageRCCardState> {
  StorageRCCardController(
    this._storingRepository,
    this._receivingCardRepository,
  ) : super(StorageRCCardState());

  final StoringRepository _storingRepository;
  final ReceivingCardRepository _receivingCardRepository;

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
          final receivingCardID = ReceivingCard.getReceivingCardID(value);

          final hasReCard =
              currentReCardList.any((e) => e.id == receivingCardID);

          if (hasReCard) {
            emit(
              state.copyWith(
                storageScanReCardError: StorageScanReCardError.reCardScanned,
              ),
            );

            throw ValidationError(
              type: ValidationErrorType.receivingCardScanned,
            );
          }

          // final resStored =
          //     await _storingRepository.getLocationByReId(rcId: receivingCardID);
          //
          // if (resStored != null && resStored.location != null) {
          //   emit(state.copyWith(
          //       storageScanReCardError:
          //           StorageScanReCardError.receivingCardExistStorage));
          //
          //   throw ValidationError(
          //       type: ValidationErrorType.receivingCardExistStorage);
          // }

          final resQC = await _receivingCardRepository.receivingCardRcCheck(
            receivingCardId: receivingCardID,
          );

          if (resQC != null && resQC.result != 1) {
            emit(
              state.copyWith(
                storageScanReCardError: StorageScanReCardError.rcNotFinishedQC,
              ),
            );

            throw ValidationError(type: ValidationErrorType.rcNotFinishedQC);
          }

          final response =
              await _receivingCardRepository.getReceivingCard(receivingCardID);

          if (response.category == null || response.category == '') {
            emit(
              state.copyWith(
                storageScanReCardError: StorageScanReCardError.reCardNullCate,
              ),
            );

            throw ValidationError(
              type: ValidationErrorType.reCardNullCate,
            );
          }

          final tempCode = response.temporaryAreaCode?.toLowerCase() ?? '';
          if ((response.rohsCheck || response.samplingCheck) &&
              response.receivingType != 3 &&
              !tempCode.contains('pl') &&
              tempCode.contains('outOK') &&
              response.receivingType != 4) {
            emit(
              state.copyWith(
                storageScanReCardError: StorageScanReCardError.inTempRequired,
              ),
            );

            throw ValidationError(
              type: ValidationErrorType.inTempRequired,
            );
          }

          if (tempCode.contains('pl')) {
            emit(
              state.copyWith(
                storageScanReCardError: StorageScanReCardError.outTempRequired,
              ),
            );

            throw ValidationError(
              type: ValidationErrorType.outTempRequired,
            );
          }

          currentReCardList = [];

          currentReCardList.add(response);

          emit(
            state.copyWith(
              listReCard: currentReCardList,
              currentReCard: response,
            ),
          );
        } else {
          emit(
            state.copyWith(
              storageScanReCardError:
                  StorageScanReCardError.receivingCardInvalid,
            ),
          );
          throw ValidationError(type: ValidationErrorType.receivingCardInvalid);
        }
      });
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> checkNavigate(BuildContext context) async {
    return launch(() async {
      if (state.listReCard.isNotEmpty) {
        final currentReCard = state.listReCard.first;

        if (currentReCard.materialType == null ||
            currentReCard.materialFrequency == null) {
          throw ValidationError(
            type: ValidationErrorType.reCardNullTypeFrequency,
          );
        }
        // if ((currentReCard.materialFrequency != null &&
        //         currentReCard.materialFrequency != '') &&
        //     currentReCard.materialFrequency!.toUpperCase() == 'JIT') {
        //   await Duration.zero.delay(() async {
        //     final res = await context.pushRoute(FloorDetailRoute(
        //       receivingCardId: currentReCard.receivingCardID ?? 0,
        //       eMapNavigateFunction: EMapNavigateFunction.storingFromStorage,
        //     ));
        //     if (res != null && res is String) {
        //       handleDataFromRackDetailPage(
        //         location: res,
        //       );
        //     }
        //   });
        //   return;
        // }

        await Duration.zero.delay(() async {
          final res = await context.pushRoute(
            NewMapFloorRoute(
              receivingCardId: currentReCard.id ?? 0,
            ),
          );
          if (res != null && res is String) {
            handleDataFromRackDetailPage(location: res);
          }
          return;
        });
        // await Duration.zero.delay(() async {
        //   final res = await context.pushRoute(ZoneDetailRoute(
        //     receivingCardId: currentReCard.receivingCardID ?? 0,
        //   ));
        //   if (res != null && res is String) {
        //     handleDataFromRackDetailPage(location: res);
        //   }
        //   return;
        // });
      } else {
        throw ValidationError(type: ValidationErrorType.importReCardOpenMap);
      }
    });
  }

  Future<void> updateLocation(String location) {
    return launch(() async {
      await _validateStoreLocation(location);
      emit(state.copyWith(location: location));
    });
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

  Future<void> storingReceivingCard() async {
    return launch(() async {
      final receivingCardList = state.listReCard;
      final location = state.location ?? '';

      if (location.isEmpty && receivingCardList.isEmpty) {
        throw ValidationError(type: ValidationErrorType.canNotEmpty);
      }

      final reId = receivingCardList.first.id;
      final re = receivingCardList.first;

      if (re.temporaryAreaCode != null &&
          re.temporaryAreaCode!.contains('pl')) {
        emit(
          state.copyWith(
            storageScanReCardError: StorageScanReCardError.outTempRequired,
          ),
        );

        throw ValidationError(
          type: ValidationErrorType.outTempRequired,
        );
      }

      // if (re.currentQuantity < 0 || re.totalQuantity < 0) {
      //   emit(state.copyWith(
      //       storageScanReCardError:
      //           StorageScanReCardError.quantityNeedBiggerThanZero));
      //
      //   throw ValidationError(
      //     type: ValidationErrorType.quantityNeedBiggerThanZero,
      //   );
      // }

      if (reId != 0) {
        final request = StoreReCardRequestModel(
          receivingCardId: reId,
          location: location,
        );
        await _storingRepository.storingReceivingCard(body: request);

        logger.i('storing receiving card successfully');
        clearData();
      }
    });
  }

  void handleDataFromRackDetailPage({
    OffsetBlockDetail? blockDetail,
    String? location,
  }) {
    emit(state.copyWith(location: location));
  }

  Future<void> _validateStoreLocation(String value) async {
    if (value.isEmpty || value == '') {
      return;
    }
    if (value.toUpperCase().contains('JIT') ||
        (value.split('.').length - 1) == 3 ||
        value.toUpperCase().contains('P')) {
      return;
    } else {
      throw ValidationError(
        type: ValidationErrorType.locationStoreIsNotValid,
      );
    }
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
