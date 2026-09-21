import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:smart_warehouse/entities/kitting/kitting_card.dart';
import 'package:smart_warehouse/entities/kitting/kitting_detail.dart';
import 'package:smart_warehouse/entities/kitting/kitting_list.dart';
import 'package:smart_warehouse/repositories/kitting_repository.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/constants.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';
import 'package:smart_warehouse/views/pages/kitting/check_list_kitting/components/check_list_kitting_detail_state.dart';

@injectable
class CheckListKittingDetailController
    extends BaseCubit<CheckListKittingDetailState> {
  CheckListKittingDetailController(this.kittingRepository)
      : super(CheckListKittingDetailState());

  final KittingRepository kittingRepository;
  final kittingMap = <int, List<KittingCard>>{};
  final listBarcode = List<String>.empty(growable: true);

  Future<List<KittingDetail>> getKittingListDetailFromId({int id = 0}) async {
    return launch(() async {
      final kittingDetails = await kittingRepository
          .getKittingDetailByKittingListId(kittingListId: id);
      kittingDetails.sort(
        (a, b) => a.kittingStatus?.compareTo(b.kittingStatus ?? 0) ?? 0,
      );
      return kittingDetails;
    });
  }

  Future<void> scanKittingList(String code) async {
    return launch(() async {
      final kittingListId = KittingList.getKittingListId(code);
      final kittingList =
          await kittingRepository.getDataKittingList(id: kittingListId);
      if (kittingList != null) {
        final kittingListId = kittingList.id ?? 0;
        final kittingDetails =
            await getKittingListDetailFromId(id: kittingListId);
        emit(
          state.copyWith(
            kittingList: kittingList,
            kittingDetails: kittingDetails,
            barcodeKittingList: code,
          ),
        );
      } else {
        throw ValidationError(type: ValidationErrorType.kittingListNotExist);
      }
    });
  }

  Future<void> createPlutoRow(
    List<KittingDetail> data,
    PlutoGridStateManager stateManager,
  ) async {
    stateManager.removeAllRows();
    final row = List.generate(data.length, (index) {
      final kittingItem = data[index];
      return PlutoRow(
        cells: {
          Constants.kPartFieldKey: PlutoCell(value: kittingItem.material),
          Constants.kQuantityFieldKey:
              PlutoCell(value: kittingItem.quantity.toInt()),
          Constants.kPickedQuantityFieldKey:
              PlutoCell(value: kittingItem.pickedQuantity.toInt()),
          Constants.kModelFieldKey: PlutoCell(value: kittingItem.model),
          Constants.kLocationFieldKey:
              PlutoCell(value: kittingItem.locationName),
          Constants.kTimeFieldKey: PlutoCell(value: kittingItem.time),
          Constants.kKittingStatusFieldKey:
              PlutoCell(value: kittingItem.kittingStatus),
        },
      );
    });
    stateManager.insertRows(0, row);
  }

  Future<void> initDataPluto(PlutoGridStateManager stateManager) {
    return launch(() async {
      final data = state.kittingDetails;
      createPlutoRow(data, stateManager);
    });
  }

  Future<void> scanKittingCard(
    String code,
    PlutoGridStateManager stateManager,
  ) async {
    return launch(() async {
      final kittingCardId = KittingCard.getKittingCardID(code);
      final kittingCard =
          await kittingRepository.getKittingCard(kittingCardId);
      final kittingListDetailId = kittingCard?.kittingListDetailId ?? 0;

      final result = state.kittingDetails
          .where((element) => element.id == kittingListDetailId)
          .firstOrNull;
      if (result == null) {
        throw ValidationError(
          type: ValidationErrorType.kittingCardNoBelongKittingList,
        );
      } else {
        if (kittingCard?.status == 3) {
          throw ValidationError(
            type: ValidationErrorType.kittingCardIsScanned,
          );
        } else {
          final kittingCards = await kittingRepository
              .getKittingCardByKittingListDetailId(id: result.id);

          final kittingCardsMap = kittingCards
              .where((element) => element.status != 3 && element.status != 1)
              .toList();

          if (!kittingMap.containsKey(result.id)) {
            kittingMap[result.id ?? 0] = [];
          }

          final isExits =
              kittingMap[result.id]!.any((card) => card.id == kittingCard?.id);
          if (!isExits) {
            kittingMap[result.id]!.add(kittingCard!);
          }

          final key =
              kittingMap.keys.where((element) => element == result.id).first;

          for (final item in kittingMap[key]!) {
            if (!listBarcode.contains(item.barcode)) {
              listBarcode.add(item.barcode ?? '');
            }
          }
          if (kittingMap[key]?.length == kittingCardsMap.length) {
            int status;
            if ((kittingCard.quantity ?? 0.0) <
                    (kittingCard.qtyTotal ?? 0.0) &&
                (result.quantity != result.pickedQuantity)) {
              status = 2;
            } else {
              status = 1;
            }
            await kittingRepository.checkKittingList(
              id: result.id ?? 0,
              status: status,
              barcodes: listBarcode,
            );
            listBarcode.clear();
          } else {
            throw ValidationError(
                type: ValidationErrorType.materialNotEnoughKittingCard);
          }
        }
      }
      final response =
          await getKittingListDetailFromId(id: result.kittingListID ?? 0);
      await createPlutoRow(response, stateManager);
    });
  }

  Color setColorForPlutoRow(PlutoRowColorContext colorContext) {
    if (colorContext.row.cells.entries.elementAt(6).value.value == 1 &&
        colorContext.row.cells.entries.elementAt(1).value.value ==
            colorContext.row.cells.entries.elementAt(2).value.value) {
      return Colors.green;
    } else if (colorContext.row.cells.entries.elementAt(6).value.value == 2 &&
        colorContext.row.cells.entries.elementAt(1).value.value !=
            colorContext.row.cells.entries.elementAt(2).value.value) {
      return Colors.yellow;
    }
    return Colors.white;
  }

  void clearData() {
    emit(
      state.copyWith(
        kittingDetails: [],
        kittingList: null,
        kittingCard: null,
        kittingListId: 0,
        barcodeKittingList: null,
      ),
    );
  }
}
