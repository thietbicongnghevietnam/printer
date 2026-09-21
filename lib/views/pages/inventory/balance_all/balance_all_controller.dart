import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/entities/inventory/balance_detail.dart';
import 'package:smart_warehouse/entities/inventory/plant_sloc_category.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/repositories/inventory_repository.dart';
import 'package:smart_warehouse/repositories/receiving_card_repository.dart';
import 'package:smart_warehouse/services/models/request/create_balance_qty_request_model.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/base/base_state.dart';
import 'package:smart_warehouse/shared/constants.dart';
import 'package:smart_warehouse/shared/extensions/iterable_extensions.dart';
import 'package:smart_warehouse/shared/extensions/list_update_extension.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';

import 'balance_all_state.dart';

@injectable
class BalanceAllController extends BaseCubit<BalanceAllState> {
  BalanceAllController(
    this._inventoryRepository,
    this._receivingCardRepository,
  ) : super(BalanceAllState());
  final InventoryRepository _inventoryRepository;
  final ReceivingCardRepository _receivingCardRepository;

  static const pageSize = Constants.pageLimit;

  @override
  Future<void> initData() async {
    launch(() async {
      await getCate();
      await searchBalance();
    });
  }

  Future<void> searchBalance({
    int? currentPageNumber,
    bool isSearched = false,
  }) async {
    launch(() async {
      emit(state.copyWith(listBalanceDetail: []));

      final pageNumber = currentPageNumber ?? 1;
      final currentPlant = state.currentPlant;
      final currentCate = state.currentCate;
      final currentSloc = state.currentSloc;
      final material = state.receivingCard?.material ?? '';

      final resBalance = await _inventoryRepository.searchListBalance(
        plant: currentPlant?.plant,
        sloc: currentSloc,
        category: currentCate?.category,
        pageNumber: pageNumber,
        material: material,
        pageSize: pageSize,
      );
      if (resBalance.isNotEmpty) {
        emit(state.copyWith(
          pageNumber: pageNumber,
          listBalanceDetail: resBalance,
          isSearched: isSearched,
        ));
      }
    });
  }

  Future<void> getCate() async {
    launch(() async {
      final resPlant = await _inventoryRepository.getAllPlantCate();
      if (resPlant.isNotEmpty) {
        emit(
          state.copyWith(listPlant: resPlant),
        );
      }
    });
  }

  Future<void> onInputMaterial(String value) async {
    launch(() async {
      if (value.isEmpty) {
        emit(state.copyWith(receivingCard: null));
        return;
      }
      final rcId = ReceivingCard.getReceivingCardID(value);

      final rcData = await _receivingCardRepository.getReceivingCard(rcId);
      emit(state.copyWith(receivingCard: rcData));
      await searchBalance(isSearched: true);
    });
  }

  Future<(bool, List<BalanceDetail>)> onLoadMore({
    int? pageNumber,
  }) async {
    try {
      final currentPlant = state.currentPlant;
      final category = state.currentCate?.category ?? '';
      final sloc = state.currentSloc;
      final plant = currentPlant?.plant;

      final res = await _inventoryRepository.searchListBalance(
        plant: plant,
        sloc: sloc,
        category: category,
        pageSize: pageSize,
        pageNumber: pageNumber ?? 1,
      );

      if (res.isNotEmpty) {
        final balanceList = state.listBalanceDetail.clone();
        balanceList.addAll(res);
        emit(
          state.copyWith(
            listBalanceDetail: balanceList,
            pageNumber: pageNumber ?? 1,
            pageStatus: PageStatus.loaded,
          ),
        );
        final isLastPage = res.length < 10;

        return (isLastPage, res);
      } else {
        final emptyData = <BalanceDetail>[];
        return (false, emptyData);
      }
    } catch (e) {
      logger.e(e);
      final emptyData = <BalanceDetail>[];
      return (false, emptyData);
    }
  }

  void onSelectPlant(PlantCategory newPlant) {
    emit(state.copyWith(
      currentPlant: newPlant,
      listCate: newPlant.categoryList,
    ));
  }

  void onSelectCate(CategorySloc newCategory) {
    emit(state.copyWith(
      currentCate: newCategory,
      listSloc: newCategory.sloc,
    ));
  }

  void onSelectSloc(String newSloc) {
    emit(state.copyWith(currentSloc: newSloc));
  }

  void updateBalanceQty({
    required BalanceDetail detail,
    required int balanceQty,
    required int sysQty,
    required int index,
    String? note,
  }) {
    final listBalanceUpdated = state.listUpdateBalance.clone();
    final currentList = state.listBalanceDetail.clone();
    final reqBody = CreateBalanceQtyRequestModel(
      plant: detail.plant,
      sloc: detail.sloc,
      material: detail.material,
      qtyBalance: balanceQty,
      qtySystem: sysQty,
      note: note,
    );
    listBalanceUpdated.add(reqBody);
    detail.isUpdate = true;
    detail.currentQuantity = balanceQty;
    currentList.update(index, detail);
    emit(
      state.copyWith(
        listUpdateBalance: listBalanceUpdated,
        listBalanceDetail: currentList,
      ),
    );
  }

  Future<void> createBalanceQty() async {
    launch(() async {
      final listBalance = state.listUpdateBalance;

      await _inventoryRepository.createBalanceQty(listBalance);

      clearData();
    });
  }

  void clearData() {
    emit(
      state.copyWith(
        currentPlant: null,
        currentSloc: null,
        currentCate: null,
        listUpdateBalance: [],
      ),
    );
    // searchBalance();
  }
}
