import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/ta_re_card_item.dart';
import 'package:smart_warehouse/enums/change_location_type.dart';
import 'package:smart_warehouse/enums/change_store_location_error.dart';
import 'package:smart_warehouse/repositories/storing_repository.dart';
import 'package:smart_warehouse/services/api_service.dart';
import 'package:smart_warehouse/services/models/request/change_location_request_model.dart';
import 'package:smart_warehouse/services/models/request/combine_location_request_model.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/extensions/duration_extensions.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';

import 'change_store_location_state.dart';

@injectable
class ChangeStoreLocationController
    extends BaseCubit<ChangeStoreLocationState> {
  ChangeStoreLocationController(this._storingRepository)
      : super(ChangeStoreLocationState());
  final StoringRepository _storingRepository;

  Future<void> addReceivingCard(String value) {
    final currentReCard = List<CustomReCardItem>.from(state.listReCard ?? []);
    return launch(() async {
      if (value.isEmpty) {
        return;
      }
      if (value.isNotEmpty && value.contains(';')) {
        final splitPDAValue = value.split(';');
        final receivingCardID = int.parse(splitPDAValue[0]);

        for (var i = 0; i < currentReCard.length; i++) {
          final hasReCard = currentReCard[i].id == receivingCardID;
          if (hasReCard) {
            emit(state.copyWith(
                changeStoreLocationError:
                    ChangeStoreLocationError.reCardScanned));
            throw ValidationError(
                type: ValidationErrorType.receivingCardScanned);
          }
        }

        final response = await _storingRepository.getLocationByReId(rcId: receivingCardID);

        var oldLocationAdded = state.oldOBOLocation ?? '';
        if (response == null ||
            response.location == null ||
            response.location!.isEmpty) {
          emit(state.copyWith(
              changeStoreLocationError:
              ChangeStoreLocationError.doNotHaveData));
          throw ValidationError(type: ValidationErrorType.doNotHaveData);
        }

        if (oldLocationAdded.isNotEmpty) {
          oldLocationAdded = '$oldLocationAdded, ${response?.location}';
        } else {
          oldLocationAdded = response?.location ?? '';
        }

        final item = CustomReCardItem(
          id: receivingCardID,
          barCode: value,
          oldLocation: oldLocationAdded,
          currentQuantity: response?.currentQuantity,
          material: response?.material,
        );

        currentReCard.insert(0, item);
        emit(
          state.copyWith(
            listReCard: currentReCard,
            oldOBOLocation: oldLocationAdded,
            currentReCard: value,
          ),
        );
      } else {
        emit(state.copyWith(
            changeStoreLocationError:
                ChangeStoreLocationError.receivingCardInvalid));
        throw ValidationError(type: ValidationErrorType.receivingCardInvalid);
      }
    });
  }

  Future<void> updateOldOBOLocation(String oldLocation) {
    return launch(() async {
      if (oldLocation.isNotEmpty) {
        validateLocation(oldLocation, true);
      }
      emit(state.copyWith(oldOBOLocation: oldLocation));
    });
  }

  Future<void> updateNewOBOLocation(String newLocationValue) {
    return launch(() async {
      validateLocation(newLocationValue, false);
      emit(state.copyWith(newOBOLocation: newLocationValue));
    });
  }

  Future<void> updateOldAllLocation(String oldLocation) {
    return launch(() async {
      validateLocation(oldLocation, true);
      emit(state.copyWith(oldAllLocation: oldLocation));
    });
  }

  Future<void> updateNewAllLocation(String newLocationValue) {
    return launch(() async {
      if (newLocationValue.isNotEmpty) {
        validateLocation(newLocationValue, false);
      }
      emit(state.copyWith(newAllLocation: newLocationValue));
    });
  }

  Future<void> validateLocation(String location, bool isOldLocation) {
    return launch(() async {
      final type = state.changeLocationType;
      bool isSameLocation = false;

      if (type == ChangeLocationType.oneByOne) {
        isSameLocation = isOldLocation
            ? location == state.newOBOLocation
            : location == state.oldOBOLocation;
      } else {
        isSameLocation = isOldLocation
            ? location == state.newAllLocation
            : location == state.oldAllLocation;
      }

      if (isSameLocation) {
        emit(state.copyWith(
            changeStoreLocationError: ChangeStoreLocationError.locationSame));
        throw ValidationError(type: ValidationErrorType.locationSame);
      }
    });
  }

  Future<bool> removeReCard(int index) async {
    return launch(() async {
      final currentReCard = List<CustomReCardItem>.from(state.listReCard ?? []);
      if (currentReCard.isNotEmpty) {
        currentReCard.removeAt(index);
        emit(state.copyWith(listReCard: currentReCard));
        return true;
      }
      return false;
    });
  }

  Future<void> changeLocationType(ChangeLocationType? value) async {
    return launch(() async {
      emit(
        state.copyWith(
          changeLocationType: value ?? ChangeLocationType.oneByOne,
          oldAllLocation: '',
          oldOBOLocation: '',
          newAllLocation: '',
          newOBOLocation: '',
          currentReCard: '',
          listReCard: [],
        ),
      );
    });
  }

  Future<bool> checkDataNewLocation(BuildContext context) async {
    return launch(() async {
      try {
        final currentChange = state.changeLocationType;
        final currentNewLocation = currentChange == ChangeLocationType.oneByOne
            ? state.newOBOLocation
            : state.newAllLocation;
        if (currentNewLocation != null && currentNewLocation.isNotEmpty) {
          final res =
          await _storingRepository.getMaterialByLocation(locationName: currentNewLocation);
          if(res != null && res.isNotEmpty){
            return true;

          } else {
            return false;
          }
        } else {
          return false;
        }
      } catch (e) {
        return false;
      }
    });
  }

  Future<void> changeStoreLocation() async {
    final currentChange = state.changeLocationType;
    switch (currentChange) {
      case ChangeLocationType.oneByOne:
        await combineLocation();
      case ChangeLocationType.all:
        await changeLocation();
    }
  }

  // Combine
  Future<void> combineLocation() async {
    return launch(() async {
      final oldLocation = state.oldOBOLocation ?? '';
      final receivingCardList = state.listReCard ?? [];
      final newLocation = state.newOBOLocation ?? '';
      String reIdList = '';

      if (oldLocation.isEmpty ||
          receivingCardList.isEmpty ||
          newLocation.isEmpty) {
        emit(state.copyWith(
            changeStoreLocationError: ChangeStoreLocationError.canNotEmpty));
        throw ValidationError(type: ValidationErrorType.canNotEmpty);
      }

      for (var e in receivingCardList) {
        reIdList = '${e.id},$reIdList';
      }
      reIdList = reIdList.substring(0, reIdList.length - 1);

      final request = CombineLocationRequestModel(
        locationNameNew: newLocation,
        receivingCardIds: reIdList,
      );
      await _storingRepository.combineLocation(body: request);
      logger.i('combine store location successfully');
      clearData();
    });
  }

  // Change
  Future<void> changeLocation() async {
    return launch(() async {
      final oldLocation = state.oldAllLocation ?? '';
      final newLocation = state.newAllLocation ?? '';

      if (oldLocation.isNotEmpty && newLocation.isNotEmpty) {
        final request = ChangeLocationRequestModel(
          locationNameOld: oldLocation,
          locationNameNew: newLocation,
        );
        await _storingRepository.changeLocation(body: request);
        logger.i('change location successfully');
        clearData();
      } else {
        emit(state.copyWith(
            changeStoreLocationError: ChangeStoreLocationError.canNotEmpty));
        throw ValidationError(type: ValidationErrorType.canNotEmpty);
      }
    });
  }

  void clearData() {
    emit(
      state.copyWith(
        listReCard: null,
        currentReCard: null,
        oldAllLocation: null,
        oldOBOLocation: null,
        newAllLocation: null,
        newOBOLocation: null,
      ),
    );
  }
}
