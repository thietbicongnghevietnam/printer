import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/entities/barcode/barcode.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/entities/receiving_card_item.dart';
import 'package:smart_warehouse/enums/balance_scan_type.dart';
import 'package:smart_warehouse/repositories/inventory_repository.dart';
import 'package:smart_warehouse/repositories/receiving_card_repository.dart';
import 'package:smart_warehouse/services/models/request/create_balance_rc_qty_request_model.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/extensions/iterable_extensions.dart';
import 'package:smart_warehouse/shared/extensions/list_update_extension.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';

import 'balance_rc_state.dart';

@injectable
class BalanceRcController extends BaseCubit<BalanceRcState> {
  BalanceRcController(
    this._inventoryRepository,
    this._receivingCardRepository,
  ) : super(BalanceRcState());
  final InventoryRepository _inventoryRepository;
  final ReceivingCardRepository _receivingCardRepository;

  /// Code màn này rác điên nhưng do bị dí nhiều quá nên chưa sửa chưa tối ưu

  Future<void> onInputRC(String value) async {
    launch(() async {
      final scanType = state.balanceScanType;
      if (scanType == BalanceScanType.scanRc) {
        final rcId = ReceivingCard.getReceivingCardID(value);
        final listRcScanned = state.listReceivingCardScanned.clone();
        final rcData = await _receivingCardRepository.getReceivingCard(rcId);

        final checkScanned = listRcScanned.any((e) => e.id == rcData.id);
        if (checkScanned) {
          throw ValidationError(type: ValidationErrorType.receivingCardScanned);
        }

        final checkLot = listRcScanned.any((e) =>
            e.material != rcData.material ||
            e.plant != rcData.plant ||
            e.sloc != rcData.sloc);
        if (checkLot) {
          throw ValidationError(
              type: ValidationErrorType.pleaseScanRcCardSameLot);
        }

        ReceivingCard rcSort = rcData;
        rcSort.items
            .sort((a, b) => a.unitNo.toInt().compareTo(b.unitNo.toInt()));
        listRcScanned.insert(0, rcSort);

        int? boxTotal;
        int? allRcQuanty;
        for (final e in listRcScanned) {
          if (e.items.isNotEmpty) {
            final boxTotalLocal = e.items.length;
            boxTotal = boxTotalLocal + (boxTotal ?? 0);
          }
          allRcQuanty = e.currentQuantity + (allRcQuanty ?? 0);
        }

        emit(
          state.copyWith(
            receivingCard: rcSort,
            currentQty: allRcQuanty,
            listReceivingCardScanned: listRcScanned,
            boxTotal: boxTotal,
          ),
        );
      } else {
        final currentBarcode = Barcode.fromBarcode(value);
        final rcData = await _receivingCardRepository.searchReceivingCards(
          barcode: currentBarcode.barcode,
          material: currentBarcode.material,
        );
        if (rcData.isNotEmpty) {
          ReceivingCard rcSort = rcData.first;
          List<ReceivingCard> rcDad = [];
          List<ReceivingCardItem> boxBalance = [];
          rcDad.add(rcSort);
          final boxScanned = rcSort.items
              .firstWhere((e) => e.barcode == currentBarcode.barcode);
          boxBalance.add(boxScanned);
          emit(
            state.copyWith(
              listReceivingCardScanned: rcDad,
              boxCardWillBalance: boxBalance,
            ),
          );
        } else {
          throw ValidationError(
              type: ValidationErrorType.receivingCardNotExist);
        }
        // emit(state.copyWith(boxCard: currentBarcode));
      }
    });
  }

  Future<void> scanBoxCardWillBalance(String value) async {
    launch(() async {
      if (value.isEmpty) {
        return;
      }
      final boxCardListBalance = state.boxCardWillBalance.clone();
      final listRcScanned = state.listReceivingCardScanned.clone();
      // final listRcWillBalance = state.listReceivingCardWillBalance.clone();
      List<ReceivingCardItem> boxCardInListRc = [];

      for (final e in listRcScanned) {
        if (e.items.isNotEmpty) {
          boxCardInListRc.addAll(e.items);
        }
      }
      if (boxCardInListRc.isNotEmpty) {
        final addBalanceItem =
            boxCardInListRc.firstWhereOrNull((e) => e.barcode == value);
        if (addBalanceItem != null) {
          final checkVisible =
              boxCardListBalance.any((e) => e.barcode == value);
          if (checkVisible) {
            throw ValidationError(type: ValidationErrorType.barcodeScanned);
          } else {
            boxCardListBalance.insert(0, addBalanceItem);
          }
        } else {
          throw ValidationError(
              type: ValidationErrorType.boxCardNotExistInReceivingCard);
        }
      }
      final boxListShowTotalChange = await handleBalanceAllBoxInRcScanned(
        allBoxScanned: boxCardListBalance,
        listRcScanned: listRcScanned,
        isUpdateAllBox: state.balanceAllBox,
      );
      emit(state.copyWith(
        boxCardWillBalance: boxCardListBalance,
        boxListShowTotalChange: boxListShowTotalChange,
      ));
    });
  }

  Future<void> changeLocationType(BalanceScanType? value) async {
    return launch(() async {
      emit(state.copyWith(
        balanceScanType: value ?? BalanceScanType.scanRc,
        balanceAllBox: value == BalanceScanType.scanBox,
      ));
      clearData();
    });
  }

  Future<void> updateQty({required int qty, required int index}) async {
    return launch(() async {
      int currentQt = state.currentQty ?? 0;
      final scanType = state.balanceScanType;
      if (scanType == BalanceScanType.scanRc) {
        List<ReceivingCard> listRcScanned =
            state.listReceivingCardScanned.clone();

        listRcScanned[index].balanceQty = qty;

        emit(state.copyWith(listReceivingCardScanned: listRcScanned));
      } else {
        currentQt = state.boxCard?.quantity ?? 0;
      }
      emit(state.copyWith(updateQty: qty, currentQty: currentQt));
    });
  }

  Future<void> updateQtyBoxInRc({
    required int updateQty,
    required ReceivingCardItem rcItem,
    required int index,
  }) async {
    return launch(() async {
      final balanceScanType = state.balanceScanType;
      if (balanceScanType == BalanceScanType.scanBox) {
        List<ReceivingCardItem> balanceList = state.boxCardWillBalance.clone();

        ReceivingCardItem rcItemClone = rcItem.copyWith(quantity: updateQty);

        balanceList.update(index, rcItemClone);
        emit(state.copyWith(boxCardWillBalance: balanceList));
      } else {
        List<BalanceBoxRequestModel> cloneBoxList =
            state.balanceBoxList.clone();
        List<ReceivingCardItem> balanceList = state.boxCardWillBalance.clone();
        List<ReceivingCardItem> originalList = [];
        final listRcScanned = state.listReceivingCardScanned.clone();
        for (var e in listRcScanned) {
          originalList.addAll(e.items);
        }

        int currentQt = state.currentQty ?? 0;
        int updateQtyTotal = state.updateQty ?? 0;
        int oldQtyRc = rcItem.currentQuantity;
        int tradeQty = 0;

        if (updateQty > oldQtyRc) {
          tradeQty = updateQty - oldQtyRc;
        } else {
          tradeQty = -(oldQtyRc - updateQty);
        }

        ReceivingCardItem rcItemClone = rcItem.copyWith(quantity: updateQty);

        final checkAlive =
            cloneBoxList.firstWhereOrNull((e) => e.id == rcItem.id);

        balanceList.update(index, rcItemClone);
        if (checkAlive != null) {
          final _index = cloneBoxList.indexWhere((e) => e.id == rcItemClone.id);
          cloneBoxList.update(_index,
              BalanceBoxRequestModel(id: rcItemClone.id, quantity: updateQty));
          ReceivingCardItem newRcUpdate = rcItemClone.copyWith(
            quantity: rcItemClone.currentQuantity,
          );
          newRcUpdate.currentQuantity = tradeQty;
        } else {
          cloneBoxList.add(
              BalanceBoxRequestModel(id: rcItemClone.id, quantity: updateQty));
        }
        updateQtyTotal =
            calculateTotalChange(originalList, balanceList) + currentQt;

        final boxListShowTotalChange = await handleBalanceAllBoxInRcScanned(
          allBoxScanned: balanceList,
          listRcScanned: listRcScanned,
          isUpdateAllBox: state.balanceAllBox,
        );
        emit(
          state.copyWith(
            currentQty: currentQt,
            updateQty: updateQtyTotal,
            balanceBoxList: cloneBoxList,
            boxCardWillBalance: balanceList,
            boxListShowTotalChange: boxListShowTotalChange,
          ),
        );
      }
    });
  }

  int calculateTotalChange(List<ReceivingCardItem> initialList,
      List<ReceivingCardItem> updatedList) {
    int totalChange = 0;

    for (var updatedItem in updatedList) {
      final originalItem =
          initialList.firstWhereOrNull((item) => item.id == updatedItem.id);

      if (originalItem != null) {
        int quantityChange =
            updatedItem.currentQuantity - originalItem.currentQuantity;
        totalChange += quantityChange;
      }
    }

    return totalChange;
  }

  Future<void> onChangeBalanceAllBox(bool value) async {
    final listRcScanned = state.listReceivingCardScanned.clone();
    List<ReceivingCardItem> listOriginal = [];
    for (var e in listRcScanned) {
      listOriginal.addAll(e.items);
    }
    List<ReceivingCardItem> listBoxNeedBalance =
        state.boxCardWillBalance.clone();

    final listShowTotalChange = await handleBalanceAllBoxInRcScanned(
      allBoxScanned: state.boxCardWillBalance,
      listRcScanned: state.listReceivingCardScanned,
      isUpdateAllBox: value,
    );
    if (value) {
      int? backUpTotalBalance = state.updateQty;
      int totalBalance =
          listBoxNeedBalance.fold(0, (sum, e) => sum + e.currentQuantity);

      emit(
        state.copyWith(
          updateQty: totalBalance,
          backUpTotalBalance: backUpTotalBalance,
        ),
      );
    } else {
      int? backUpTotalBalance = state.backUpTotalBalance;

      emit(state.copyWith(updateQty: backUpTotalBalance));
    }
    emit(state.copyWith(
      balanceAllBox: value,
      boxListShowTotalChange: listShowTotalChange,
    ));
  }

  void onChangeBalanceAllLot(bool value) {
    emit(state.copyWith(balanceAllLot: value));
  }

  Future<List<ReceivingCardItem>> handleBalanceAllBoxInRcScanned({
    List<ReceivingCardItem> allBoxScanned = const [],
    List<ReceivingCard> listRcScanned = const [],
    bool isUpdateAllBox = true,
  }) async {
    List<ReceivingCardItem> boxListShowTotalChange = [];
    List<ReceivingCard> listRcScannedGetBoxScanned = [];

    List<ReceivingCardItem> allBoxInRcScanned = [];
    for (var e in listRcScanned) {
      for (var boxBalanced in allBoxScanned) {
        final checkIn = e.items.any((e) => e.id == boxBalanced.id);
        if (checkIn) {
          listRcScannedGetBoxScanned.add(e);
        }
      }
      allBoxInRcScanned.addAll(e.items);
    }

    if (isUpdateAllBox) {
      try {
        List<ReceivingCardItem> listReturn = [];

        for (var boxOriginal in allBoxInRcScanned) {
          bool isInBalance = allBoxScanned.any((e) => e.id == boxOriginal.id);
          if (!isInBalance) {
            List<ReceivingCardItem> itemListWillZero = [];
            for (final inside in listRcScannedGetBoxScanned) {
              itemListWillZero.addAll(inside.items);
            }
            final isInsideRcBalance = itemListWillZero
                .any((inside) => inside.barcode == boxOriginal.barcode);
            if (isInsideRcBalance) {
              ReceivingCardItem newOriginal = boxOriginal.copyWith(quantity: 0);
              listReturn.add(newOriginal);
            }
          } else {
            for (var e in allBoxScanned) {
              if (e.id == boxOriginal.id) {
                listReturn.add(e);
              }
            }
          }
        }
        boxListShowTotalChange.addAll(listReturn);
        for (var boxOrigin in allBoxInRcScanned) {
          if (listReturn.every((e) => e.id != boxOrigin.id)) {
            boxListShowTotalChange.add(boxOrigin);
          }
        }
        return boxListShowTotalChange;
      } catch (e) {
        logger.e(e);
      }
    } else {
      if (allBoxScanned.isNotEmpty) {
        List<ReceivingCardItem> listOnRcHasBoxScanned = [];
        List<ReceivingCardItem> listReturn = [];
        for (var rc in listRcScannedGetBoxScanned) {
          listOnRcHasBoxScanned.addAll(rc.items);
        }
        try {
          for (var box in listOnRcHasBoxScanned) {
            for (var boxAdd in allBoxScanned) {
              if (boxAdd.id == box.id) {
                boxListShowTotalChange.add(boxAdd);
              }
            }
          }

          for (var box in listOnRcHasBoxScanned) {
            final exist = allBoxScanned.any((e) => e.id == box.id);
            if (!exist) {
              boxListShowTotalChange.add(box);
            }
          }

          listReturn.addAll(boxListShowTotalChange);
          for (var ori in allBoxInRcScanned) {
            if (boxListShowTotalChange.every((e) => e.id != ori.id)) {
              listReturn.add(ori);
            }
          }
          return listReturn;
        } catch (e) {
          logger.e(e);
        }
      }
    }
    return [];
  }

  Future<void> createBalanceRcQty() async {
    return launch(() async {
      List<BalanceParentsRequestModel> listBalanceParents = [];

      final balanceAllLot = state.balanceAllLot;
      final isUpdateAllBox = state.balanceAllBox;
      final listRcScanned = state.listReceivingCardScanned.clone();
      List<BalanceBoxRequestModel> balanceBoxList =
          state.balanceBoxList.clone();
      List<ReceivingCardItem> originalBoxList = [];
      List<ReceivingCardItem> boxListRequest = [];
      List<ReceivingCard> listRcScannedGetBoxScanned = [];
      final boxCardListBalance = state.boxCardWillBalance.clone();

      for (var e in listRcScanned) {
        for (var boxBalanced in boxCardListBalance) {
          final checkIn = e.items.any((e) => e.id == boxBalanced.id);
          if (checkIn) {
            listRcScannedGetBoxScanned.add(e);
          }
        }
        originalBoxList.addAll(e.items);
      }

      if (isUpdateAllBox) {
        balanceBoxList = [];
        try {
          for (var boxOriginal in originalBoxList) {
            bool isInBalance =
                boxCardListBalance.any((e) => e.id == boxOriginal.id);
            if (!isInBalance) {
              List<ReceivingCardItem> itemListWillZero = [];
              for (final inside in listRcScannedGetBoxScanned) {
                itemListWillZero.addAll(inside.items);
              }
              final isInsideRcBalance = itemListWillZero
                  .any((inside) => inside.barcode == boxOriginal.barcode);
              if (isInsideRcBalance) {
                ReceivingCardItem newOriginal =
                    boxOriginal.copyWith(quantity: 0);
                boxListRequest.add(newOriginal);
              }
            } else {
              for (var e in boxCardListBalance) {
                if (e.id == boxOriginal.id) {
                  boxListRequest.add(e);
                }
              }
            }
          }
        } catch (e) {
          logger.e(e);
        }
        for (var e in boxListRequest) {
          balanceBoxList.add(
            BalanceBoxRequestModel(
              id: e.id,
              quantity: e.currentQuantity,
            ),
          );
        }
      } else {
        if (boxCardListBalance.isNotEmpty) {
          List<ReceivingCardItem> listUpdateByRcUpdateAll = boxCardListBalance;
          List<ReceivingCardItem> listOnRcHasBoxScanned = [];
          List<ReceivingCardItem> listWillBalance = [];
          for (var rc in listRcScannedGetBoxScanned) {
            listOnRcHasBoxScanned.addAll(rc.items);
          }
          try {
            for (var box in listOnRcHasBoxScanned) {
              for (var boxAdd in listUpdateByRcUpdateAll) {
                if (boxAdd.id == box.id) {
                  listWillBalance.add(boxAdd);
                }
              }
            }

            for (var box in listOnRcHasBoxScanned) {
              final exist = listUpdateByRcUpdateAll.any((e) => e.id == box.id);
              if (!exist) {
                listWillBalance.add(box);
              }
            }
          } catch (e) {
            logger.e(e);
          }

          balanceBoxList = [];
          for (var e in listWillBalance) {
            balanceBoxList.add(
              BalanceBoxRequestModel(
                id: e.id,
                quantity: e.currentQuantity,
              ),
            );
          }
        }
      }

      for (var e in listRcScanned) {
        listBalanceParents.add(BalanceParentsRequestModel(
          barcode: e.barcode,
          quantity: e.balanceQty != 0 ? e.balanceQty : e.currentQuantity,
        ));
      }
      listBalanceParents
          .addAll([BalanceParentsRequestModel(balanceBoxs: balanceBoxList)]);
      for (var rc in listRcScannedGetBoxScanned) {
        for (int i = 0; i < listBalanceParents.length; i++) {
          if (listBalanceParents[i].barcode == rc.barcode) {
            listBalanceParents.removeAt(i);
          }
        }
      }

      final body = BalanceRcDataRequestModel(
        isAll: balanceAllLot,
        balanceParents: listBalanceParents,
      );
      await _inventoryRepository.createBalanceRcQty(body);

      clearData();
    });
  }

  void clearData() {
    emit(state.copyWith(
      updateQty: null,
      currentQty: null,
      boxCard: null,
      receivingCard: null,
      boxTotal: null,
      backUpTotalBalance: null,
      balanceAllBox: false,
      balanceBoxList: [],
      boxCardWillBalance: [],
      listReceivingCardScanned: [],
      boxListShowTotalChange: [],
    ));
  }
}
