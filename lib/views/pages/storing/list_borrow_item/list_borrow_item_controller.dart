import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/repositories/storing_repository.dart';
import 'package:smart_warehouse/services/models/response/borrow_goods_response_model.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';

import 'list_borrow_item_state.dart';

@injectable
class ListBorrowItemController extends BaseCubit<ListBorrowItemState> {
  ListBorrowItemController(this._storingRepository) : super(ListBorrowItemState());
  final StoringRepository _storingRepository;

  late FocusNode palletSourceFocusNode;
  late FocusNode palletEndFocusNode;

  Future<void> initDataBorrowList({
    String? searchName,
    bool isSearched = false,
  }) {
    return launch(() async {
      emit(
        state.copyWith(
          pageSize: 10,
          pageNumber: 1,
          borrowGoodsList: [],
          searchName: searchName ?? '',
        ),
      );

      try {
        final pageSize = state.pageSize;
        final pageNumber = state.pageNumber;
        final res = await _storingRepository.searchBorrowGoodsList(
          pageNumber: pageNumber,
          pageSize: pageSize,
          goodsName: searchName ?? '',
        );

        if (res != null && res.isNotEmpty) {
          emit(
            state.copyWith(
              borrowGoodsList: res,
              isSearched: isSearched,
            ),
          );
        }
      } catch (e) {
        logger.e(e);
      }
    });
  }

  Future<(bool, List<BorrowGoodsResponseModel>)> onLoadMore({
    int? pageNumber,
  }) async {
    try {
      final res = await _storingRepository.searchBorrowGoodsList(
        pageSize: 10,
        pageNumber: pageNumber ?? 1,
        goodsName: state.searchName,
      );

      if (res != null && res.isNotEmpty) {
        final goodsList =
            List<BorrowGoodsResponseModel>.from(state.borrowGoodsList);
        goodsList.addAll(res);
        emit(
          state.copyWith(
            borrowGoodsList: goodsList,
            pageNumber: pageNumber ?? 1,
            isSearched: false,
            pageStatus: PageStatus.loaded,
          ),
        );
        final isLastPage = res.length < 10;

        return (isLastPage, res);
      } else {
        final List<BorrowGoodsResponseModel> emptyData = [];
        return (false, emptyData);
      }
    } catch (e) {
      logger.e(e);
      final List<BorrowGoodsResponseModel> emptyData = [];
      return (false, emptyData);
    }
  }

  Future<void> outBorrowItem(int id) async {
    return launch(() async {
      emit(state.copyWith(pageStatus: PageStatus.loading));

      try {
        await _storingRepository.takeOutBorrowGoods(ids: id.toString());
        final goodsList =
            List<BorrowGoodsResponseModel>.from(state.borrowGoodsList);
        goodsList.removeWhere((e) => e.id == id);
        emit(
          state.copyWith(
            borrowGoodsList: goodsList,
            pageStatus: PageStatus.loaded,
          ),
        );
      } catch (e) {
        logger.e(e);
        emit(state.copyWith(pageStatus: PageStatus.error));
      }
    });
  }
}
