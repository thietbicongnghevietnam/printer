import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/entities/receiving_card_item.dart';
import 'package:smart_warehouse/entities/storing/box_qc_return.dart';
import 'package:smart_warehouse/entities/storing/qty_qc_history.dart';
import 'package:smart_warehouse/repositories/receiving_card_repository.dart';
import 'package:smart_warehouse/repositories/storing_repository.dart';
import 'package:smart_warehouse/services/models/request/qc_borrow_rc_request_model.dart';
import 'package:smart_warehouse/services/models/response/plant_type_freqquency_response_model.dart';
import 'package:smart_warehouse/services/models/response/sloc_info_from_plant_response_model.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/extensions/iterable_extensions.dart';

import 'iqc_borrow_receiving_card_state.dart';

enum IQCBorrowType{
  borrowRc,
  returnRc
}

@injectable
class IQCBorrowReceivingCardController
    extends BaseCubit<IQCBorrowReceivingCardState> {
  IQCBorrowReceivingCardController(
    this._receivingCardRepository,
    this._storingRepository,
  ) : super(IQCBorrowReceivingCardState());

  final ReceivingCardRepository _receivingCardRepository;
  final StoringRepository _storingRepository;

  Future<void> scanReceivingCard(String value) async {
    return launch(() async {
      if (value.isEmpty) {
        return;
      }
      if (value.isNotEmpty && value.contains(';')) {
        final rcId = ReceivingCard.getReceivingCardID(value);

        final rcData = await _receivingCardRepository.getReceivingCard(rcId);

        emit(state.copyWith(
          currentReCard: rcData,
          listBoxInScanned: [],
        ));
        final resPlant = await _storingRepository.getAllPlanSlocFromMaterial(
            material: rcData.material);
        if (resPlant != null && resPlant.isNotEmpty) {
          PlantTypeFrequencyResponseModel? currentPlant;
          SlocInfoFromPlantResponseModel? currentSloc;
          List<SlocInfoFromPlantResponseModel> listSloc = [];
          currentPlant =
              resPlant.firstWhereOrNull((e) => e.plant == rcData.plant);
          listSloc = currentPlant?.slocs ?? [];
          currentSloc = listSloc.firstWhereOrNull((e) => e.sloc == rcData.sloc);
          emit(
            state.copyWith(
              currentPlant: currentPlant,
              currentSloc: currentSloc,
              currentListSloc: listSloc,
              listPlant: resPlant,
            ),
          );
          final isBorrow = state.icqBorrowType == IQCBorrowType.borrowRc;
          if (!isBorrow) {
            await getHistoryQCBorrow();
          }
        }
      }
    });
  }

  void onSelectPlant(PlantTypeFrequencyResponseModel plant) {
    emit(state.copyWith(
      currentPlant: plant,
      currentListSloc: plant.slocs ?? [],
    ));
  }

  void onSelectSloc(SlocInfoFromPlantResponseModel sloc) {
    emit(state.copyWith(currentSloc: sloc));
  }

  Future<void> scanBoxCard(String boxCard) {
    return launch(() async {
      if (boxCard.isEmpty) {
        return;
      }
      final listBoxInScanned = state.listBoxInScanned.clone();
      final rcScanned = state.currentReCard;
      final iqcBorrowType = state.icqBorrowType;
      List<ReceivingCardItem> boxCardInRc = [];
      List<QtyQCHistory> listQtHistory = state.listQtHistory.clone();
      boxCardInRc.addAll(rcScanned?.items ?? []);

      if (iqcBorrowType == IQCBorrowType.borrowRc) {
        if (boxCardInRc.isNotEmpty) {
          final boxScanned =
              boxCardInRc.firstWhereOrNull((e) => e.barcode == boxCard);
          if (boxScanned != null) {
            final checkVisible =
                listBoxInScanned.any((e) => e.barcode == boxCard);
            if (checkVisible) {
              throw ValidationError(type: ValidationErrorType.barcodeScanned);
            } else {
              listBoxInScanned.insert(0, boxScanned);
            }
            emit(state.copyWith(listBoxInScanned: listBoxInScanned));
          } else {
            throw ValidationError(
                type: ValidationErrorType.boxCardNotExistInReceivingCard);
          }
        }
      } else {
        if (listQtHistory.isNotEmpty) {
          final boxHasQc = listQtHistory.firstWhereOrNull(
              (e) => e.barcodeBox != null && e.barcodeBox!.isNotEmpty);
          if (boxHasQc != null) {
            List<BoxQCReturn> listBoxQtyReturn = state.listBoxQtyReturn.clone();

            final checkVisible =
                listBoxQtyReturn.any((e) => e.barcode == boxCard);
            if (checkVisible) {
              throw ValidationError(type: ValidationErrorType.barcodeScanned);
            } else {
              // final rcData =
              //     await _receivingCardRepository.searchReceivingCards(
              //   barcode: boxCard,
              // );
              // if (rcData.first.material != rcScanned?.material) {
              //   throw ValidationError(
              //       type: ValidationErrorType.materialNotSame);
              // }
              //
              // final boxListInRcData = rcData.first.items;
              // ReceivingCardItem? boxData =
              //     boxListInRcData.firstWhereOrNull((e) => e.barcode == boxCard);

              final historyData = listQtHistory
                  .firstWhereOrNull((e) => e.barcodeBox == boxCard);

              BoxQCReturn? boxQCReturn;
              if (historyData != null) {
                if (historyData.qtyBox == 0) {
                  throw ValidationError(
                      type: ValidationErrorType.boxWasReturned);
                }
                boxQCReturn = BoxQCReturn(
                    barcode: boxCard, currentQuantity: historyData.qtyBox ?? 0);
                listBoxQtyReturn.insert(0, boxQCReturn);
                emit(state.copyWith(listBoxQtyReturn: listBoxQtyReturn));
              } else {
                throw ValidationError(
                    type: ValidationErrorType.boxcardNotExistInQCHistory);
              }
            }
          } else {
            throw ValidationError(
                type: ValidationErrorType.boxNotHaveHistoryBorrow);
          }
        } else {
          throw ValidationError(type: ValidationErrorType.doNotHaveHistory);
        }
      }
    });
  }

  void removeBoxCard({required int index}) {
    final iqcBorrow = state.icqBorrowType;
    if (iqcBorrow == IQCBorrowType.borrowRc) {
      List<ReceivingCardItem> listBoxInScanned = state.listBoxInScanned.clone();

      listBoxInScanned.removeAt(index);
      emit(state.copyWith(listBoxInScanned: listBoxInScanned));
    } else {
      List<BoxQCReturn> listBoxScan = state.listBoxQtyReturn.clone();

      listBoxScan.removeAt(index);
      emit(state.copyWith(listBoxQtyReturn: listBoxScan));
    }
  }

  Future<void> onChangeBorrowType(IQCBorrowType value) async {
    emit(
      state.copyWith(
        qtyInput: '',
        listBoxInScanned: [],
        listBoxQtyReturn: [],
        icqBorrowType: value,
      ),
    );
    if (value == IQCBorrowType.returnRc) {
      await getHistoryQCBorrow();
    }
  }

  void onInputQty(String value) {
    emit(state.copyWith(qtyInput: value));
  }

  Future<void> getHistoryQCBorrow() {
    return launch(() async {
      final rc = state.currentReCard;
      final iqcBorrowType = state.icqBorrowType;
      if (rc != null && iqcBorrowType == IQCBorrowType.returnRc) {
        final sloc = state.currentSloc?.sloc ?? rc.sloc ?? '';
        final plant = state.currentPlant?.plant ?? rc.plant ?? '';
        final material = rc.material;
        final res = await _receivingCardRepository.getQtyQCHistory(
          material: material,
          plant: plant,
          sloc: sloc,
        );
        if (res.isNotEmpty) {
          emit(state.copyWith(listQtHistory: res));
        } else {
          throw ValidationError(type: ValidationErrorType.doNotHaveHistory);
        }
      }
    });
  }

  Future<void> createQCBorrowRC(int qtyBorrow) {
    return launch(() async {
      final listBoxInScanned = state.listBoxInScanned.clone();
      final listBoxQtyReturn = state.listBoxQtyReturn.clone();
      final rc = state.currentReCard;
      final iqcBorrowType = state.icqBorrowType;
      final listQtHistory = state.listQtHistory;
      List<BoxQCQtyRequestModel> listBoxBorrow = [];
      QCBorrowRcRequestModel body;
      if (listBoxInScanned.isNotEmpty || listBoxQtyReturn.isNotEmpty) {
        if (iqcBorrowType == IQCBorrowType.returnRc) {
          final sumBoxQtyScanned =
              listBoxQtyReturn.fold(0, (sum, e) => sum + e.currentQuantity);
          final sumBorrowHistory =
              listQtHistory.fold(0, (sum, e) => sum + (e.qtyBox ?? 0));
          if (sumBoxQtyScanned > sumBorrowHistory) {
            throw ValidationError(
                type: ValidationErrorType.qtyReturnBiggerThanBorrow);
          }
          for (var box in listBoxQtyReturn) {
            listBoxBorrow.add(BoxQCQtyRequestModel(
              barcodeBox: box.barcode,
              quantity: -box.currentQuantity,
            ));
          }
        } else {
          for (var box in listBoxInScanned) {
            listBoxBorrow.add(BoxQCQtyRequestModel(
              barcodeBox: box.barcode,
              quantity: box.quantity,
            ));
          }
        }

        body = QCBorrowRcRequestModel(listBoxCardRQ: listBoxBorrow);
      } else {
        if (iqcBorrowType == IQCBorrowType.borrowRc) {
          if (qtyBorrow == 0) {
            throw ValidationError(
                type: ValidationErrorType.quantityNeedBiggerThanZero);
          }
          if (qtyBorrow > (rc?.currentQuantity ?? 0)) {
            throw ValidationError(
                type: ValidationErrorType.qtyEnterNeedSmallerCurrentQty);
          }
          body = QCBorrowRcRequestModel(
            rcBarcode: rc?.barcode,
            quantity: qtyBorrow,
          );
        } else {
          final checkVar =
              listQtHistory.firstWhereOrNull((e) => e.barcode == rc?.barcode);
          if (checkVar != null) {
            if (checkVar.qtyRC != null && qtyBorrow > checkVar.qtyRC!) {
              throw ValidationError(
                  type: ValidationErrorType.qtyReturnBiggerThanBorrow);
            }
            body = QCBorrowRcRequestModel(
              rcBarcode: rc?.barcode,
              quantity: -qtyBorrow,
            );
          } else {
            throw ValidationError(type: ValidationErrorType.doNotHaveHistory);
          }
        }
      }
      await _receivingCardRepository.qcBorrowReceivingCard(body);
      clearData();
    });
  }

  void clearData() {
    emit(state.copyWith(
      currentReCard: null,
      icqBorrowType: IQCBorrowType.borrowRc,
      currentSloc: null,
      qtyInput: '',
      listBoxInScanned: [],
      currentListSloc: [],
      listBoxQtyReturn: [],
    ));
  }
}
