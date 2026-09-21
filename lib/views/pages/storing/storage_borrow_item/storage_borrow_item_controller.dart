import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/repositories/storing_repository.dart';
import 'package:smart_warehouse/services/api_service.dart';
import 'package:smart_warehouse/services/models/request/store_goods_request_model.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';

import 'storage_borrow_item_state.dart';

@injectable
class StorageBorrowItemController extends BaseCubit<StorageBorrowItemState> {
  StorageBorrowItemController(this._storingRepository)
      : super(StorageBorrowItemState());
  final StoringRepository _storingRepository;

  Future<void> updateGoodsItem(String value) {
    return launch(() async {
      emit(state.copyWith(goods: value));
    });
  }

  Future<void> updateRemark(String remark) {
    return launch(() async {
      emit(state.copyWith(remark: remark));
    });
  }

  Future<void> updateLocation(String location) {
    return launch(() async {
      emit(state.copyWith(location: location));
    });
  }

  Future<void> addGoodsItem({
    String? goodsItem,
    String? remark,
    String? location,
  }) {
    return launch(() async {
      if (goodsItem == null ||
          goodsItem.isEmpty ||
          location == null ||
          location.isEmpty) {
        throw ValidationError(type: ValidationErrorType.canNotEmpty);
      }

      final goodsList = List<StoreGoodsRequestModel>.from(state.itemList);
      final itemAdd = StoreGoodsRequestModel(
        blockName: location,
        goodsName: goodsItem,
        remark: remark ?? '',
      );
      goodsList.add(itemAdd);
      emit(state.copyWith(itemList: goodsList));
    });
  }

  Future<bool> removeGoodsItem(int index) async {
    final listReceivingCard = List<StoreGoodsRequestModel>.from(state.itemList);
    if (listReceivingCard.isNotEmpty) {
      listReceivingCard.removeAt(index);
      emit(state.copyWith(itemList: listReceivingCard));
      return true;
    }
    return false;
  }

  Future<void> storingBorrowGoods() async {
    return launch(() async {
      final borrowGoodsList = state.itemList;

      if (borrowGoodsList.isNotEmpty) {
        await _storingRepository.storeRequestingGoods(body: borrowGoodsList);
        logger.i('Storing borrow goods successfully');
        emit(state.copyWith(hasStored: true));
        clearData(clearAll: true);
      } else {
        throw ValidationError(type: ValidationErrorType.canNotEmpty);
      }
    });
  }

  void clearData({bool clearAll = false}) {
    final listReceivingCard = List<StoreGoodsRequestModel>.from(state.itemList);

    emit(
      state.copyWith(
        location: '',
        remark: '',
        goods: '',
        itemList: clearAll ? [] : listReceivingCard,
      ),
    );
  }
}
