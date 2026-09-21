  import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/entities/ta_re_card_item.dart';
import 'package:smart_warehouse/enums/out_storage_type.dart';
import 'package:smart_warehouse/repositories/storing_repository.dart';
import 'package:smart_warehouse/services/models/request/move_out_all_storage_request_model.dart';
import 'package:smart_warehouse/services/models/request/move_out_store_request_model.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';

import 'out_storage_state.dart';

@injectable
class OutStorageController extends BaseCubit<OutStorageState> {
  OutStorageController(this._storingRepository) : super(OutStorageState());
  final StoringRepository _storingRepository;

  late TextEditingController receivingCardController;
  late TextEditingController locationController;
  late TextEditingController remarkController;

  late FocusNode receivingCardFocusNode;
  late FocusNode locationFocusNode;
  late FocusNode remarkFocusNode;

  void initDataController() {
    receivingCardController = TextEditingController();
    locationController = TextEditingController();
    remarkController = TextEditingController();

    receivingCardFocusNode = FocusNode()..requestFocus();
    locationFocusNode = FocusNode();
    remarkFocusNode = FocusNode();
  }

  Future<void> addReceivingCard(String value) {
    return launch(() async {
      if (value.isEmpty) {
        return;
      }

      if (value.isNotEmpty && value.contains(';')) {
        final splitPDAValue = value.split(';');
        final receivingCardID = int.parse(splitPDAValue[0]);

        final response =
            await _storingRepository.getLocationByReId(rcId: receivingCardID);

        if (response != null &&
            response.location != null &&
            response.location!.isNotEmpty) {
          final item = CustomReCardItem(
            id: receivingCardID,
            barCode: value,
            oldLocation: response.location,
            currentQuantity: response.currentQuantity,
            material: response.material,
          );

          emit(
            state.copyWith(currentReceivingCard: item),
          );
        } else {
          throw ValidationError(type: ValidationErrorType.doNotHaveData);
        }
      } else {
        throw ValidationError(type: ValidationErrorType.receivingCardInvalid);
      }
    });
  }

  Future<void> addOutItem({
    String? reason,
  }) async {
    return launch(() async {
      final currentReCard = state.currentReceivingCard;
      if (currentReCard == null || reason == null || reason.isEmpty) {
        throw ValidationError(type: ValidationErrorType.canNotEmpty);
      }

      final goodsList = List<MoveOutStoreRequestModel>.from(state.outList);
      final itemAdd = MoveOutStoreRequestModel(
        receivingCardId: currentReCard.id,
        reasonOutStorage: reason,
      );
      goodsList.add(itemAdd);
      emit(state.copyWith(outList: goodsList));
    });
  }

  Future<void> moveOutReceivingCard() async {
    return launch(() async {
      final currentReCard = state.currentReceivingCard;
      final location = locationController.text;
      final remark = remarkController.text;
      final outType = state.outType;

      if (outType == OutStorageType.oneByOne) {
        if (currentReCard != null && remark.isNotEmpty) {
          final request = MoveOutStoreRequestModel(
            receivingCardId: currentReCard.id,
            reasonOutStorage: remark,
          );
          await _storingRepository.moveOutStore(body: request);

          logger.i('out location successfully');
          clearData();

          receivingCardFocusNode.requestFocus();
        } else {
          throw ValidationError(type: ValidationErrorType.canNotEmpty);
        }
      } else {
        if (location.isNotEmpty && remark.isNotEmpty) {
          final request = MoveOutAllStoreRequestModel(
            locationName: location,
            reasonOutStorage: remark,
          );
          await _storingRepository.moveOutAllStore(body: request);

          logger.i('out all location successfully');
          clearData();

          locationFocusNode.requestFocus();
        } else {
          throw ValidationError(type: ValidationErrorType.canNotEmpty);
        }
      }
    });
  }

  Future<void> changeOutStorageType(OutStorageType? value) async {
    return launch(() async {
      if (value == OutStorageType.oneByOne) {
        receivingCardFocusNode.requestFocus();
      } else {
        locationFocusNode.requestFocus();
      }
      emit(state.copyWith(outType: value ?? OutStorageType.oneByOne));
    });
  }

  void clearData() {
    locationController.text = '';
    remarkController.text = '';
    receivingCardController.text = '';

    emit(
      state.copyWith(
        currentReceivingCard: null,
        reason: null,
      ),
    );
  }

  void dispose() {
    receivingCardController.dispose();
    locationController.dispose();
    remarkController.dispose();
    receivingCardFocusNode.dispose();
    locationFocusNode.dispose();
    remarkFocusNode.dispose();
  }
}
