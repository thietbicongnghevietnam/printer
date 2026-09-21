import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/e_map/emap_kiting_suggest.dart';
import 'package:smart_warehouse/entities/kitting/kitting_card.dart';
import 'package:smart_warehouse/entities/kitting/kitting_detail.dart';
import 'package:smart_warehouse/entities/kitting_request.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/entities/receiving_card_item.dart';
import 'package:smart_warehouse/enums/emap_navigate_funciton.dart';
import 'package:smart_warehouse/repositories/inventory_repository.dart';
import 'package:smart_warehouse/repositories/kitting_repository.dart';
import 'package:smart_warehouse/repositories/master_repository.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/constants.dart';
import 'package:smart_warehouse/shared/extensions/datetime_extensions.dart';
import 'package:smart_warehouse/shared/extensions/iterable_extensions.dart';
import 'package:smart_warehouse/shared/router/router.gr.dart';
import 'package:smart_warehouse/shared/utils/storage_manager.dart';
import 'package:smart_warehouse/subsystem/printer/printer.dart';
import 'package:smart_warehouse/views/pages/kitting/emap_kitting/emap_kitting_page.dart';
import 'package:smart_warehouse/views/pages/kitting/kitting_model/kitting_model_state.dart';
import 'package:smart_warehouse/views/widgets/app_table.dart';

@injectable
class KittingModelController extends BaseCubit<KittingModelState> {
  KittingModelController(
      this.kittingRepository, this.masterRepository, this.inventoryRepository)
      : super(KittingModelState());

  final KittingRepository kittingRepository;
  final MasterRepository masterRepository;
  final InventoryRepository inventoryRepository;
  PrinterDevice? savePrinterDevice;
  List<PrinterDevice>? printerDevices;
  List<int>? receivingCardIds = List.empty(growable: true);
  List<int>? receivingCardItemIds = List.empty(growable: true);
  List<KittingRequest> kittingRequests = List.empty(growable: true);
  List<String> commands = List.empty(growable: true);
  var qtyBarcodeOnLocationScanned = 0.0;

  @override
  Future<void> initData() async {
    final response = await masterRepository.getPrinterDevices();
    printerDevices = response.$2;
    savePrinterDevice = masterRepository.getPreviousPrinterDevice();
  }

  Future<void> updatePage() async {
    return launch(() async {
      if (state.receivingCards!.isEmpty && state.receivingCardItems!.isEmpty) {
        emit(state.copyWith(page: 0, kittingModels: [], material: ''));
      } else {
        emit(state.copyWith(page: 0, kittingModels: []));
      }
    });
  }

  Color setRowColor(PlutoRowColorContext colorContext) {
    if (colorContext.row.cells.entries.elementAt(5).value.value == 0) {
      return Colors.white;
    } else if (colorContext.row.cells.entries.elementAt(2).value.value ==
        colorContext.row.cells.entries.elementAt(5).value.value) {
      return Colors.green;
    } else {
      return Colors.yellow;
    }
  }

  Future<void> updateDeliveryDate(String? deliveryDate) async {
    return launch(() async {
      emit(state.copyWith(deliveryDate: deliveryDate, isDay: true));
    });
  }

  Future<void> updateTime({
    int? startTime,
    int? endTime,
    bool? isOnTheHour,
  }) async {
    return launch(() async {
      emit(
        state.copyWith(
          startTime: startTime,
          endTime: endTime,
          isOnTheHour: isOnTheHour,
        ),
      );
    });
  }

  Future<void> updateKittingEnough({
    bool isKittingEnough = false,
  }) async {
    return launch(() async {
      emit(
        state.copyWith(
          isKittingEnough: !isKittingEnough,
        ),
      );
    });
  }

  Future<void> resetData() {
    return launch(() async {
      emit(state.copyWith(
        deliveryDate: null,
        model: '',
        material: '',
        receivingCards: [],
        receivingCardItems: [],
        totalQuantityBarcode: 0,
        isOnTheHour: null,
        startTime: null,
        endTime: null,
        isDay: false,
        locationOfBarcode: null,
        isScanEnough: false,
        isKittingEnough: false,
      ));
    });
  }

  Future<void> scanCard(String code) {
    return launch(() async {
      final arr = code.split(Constants.barcodeSplitCharacter);
      final isReceivingCard = arr.length == 7;
      if (isReceivingCard) {
        final id = ReceivingCard.getReceivingCardID(code);
        final listReceivingCard =
        await kittingRepository.getReceivingCard(id: id);
        if (listReceivingCard.isNotEmpty) {
          final receivingCard = listReceivingCard.first;
          if (!state.kittingModels.any((element) => element.material == receivingCard.material)){
            throw ValidationError(type: ValidationErrorType.materialNotInKittingList);
          }
          if (receivingCard.isOverdue) {
            throw ValidationError(type: ValidationErrorType.overDue);
          } else {
            if (receivingCard.currentQuantity != 0) {
              final listRcItem =
              await kittingRepository.getReceivingCardItemByRcId(rcId: id);
              if (listRcItem.isNotEmpty) {
                final listBarcodeNotSame =
                listRcItem.map((e) => e.barcode).toSet();
                if (listBarcodeNotSame.length != listRcItem.length) {
                  if (state.receivingCards!.isEmpty &&
                      state.receivingCardItems!.isEmpty) {
                    emit(
                      state.copyWith(
                        receivingCard: receivingCard,
                        material: receivingCard.material,
                        receivingCards: [
                          ...?state.receivingCards,
                          ...[receivingCard],
                        ],
                        totalQuantityBarcode: state.totalQuantityBarcode +
                            receivingCard.currentQuantity,
                        locationOfBarcode: receivingCard.location,
                      ),
                    );
                  } else {
                    if (state.material != receivingCard.material) {
                      emit(
                        state.copyWith(
                          receivingCards: [receivingCard],
                          receivingCardItems: [],
                          qtyBarcodeOnLocationScanned: 0.0,
                          qtyOnLocation: 0.0,
                          isScanEnough: false,
                        ),
                      );
                      throw ValidationError(
                        type: ValidationErrorType.barcodeNotSame,
                      );
                    } else {
                      final result = state.receivingCards?.any(
                            (element) => element.id == receivingCard.id,
                      ) ??
                          false;
                      if (result) {
                        throw ValidationError(
                          type: ValidationErrorType.receivingCardScanned,
                        );
                      } else {
                        emit(
                          state.copyWith(
                            receivingCard: receivingCard,
                            material: receivingCard.material,
                            receivingCards: [
                              ...?state.receivingCards,
                              ...[receivingCard],
                            ],
                            totalQuantityBarcode: state.totalQuantityBarcode +
                                receivingCard.currentQuantity,
                            locationOfBarcode: receivingCard.location,
                          ),
                        );
                      }
                    }
                  }
                } else {
                  throw ValidationError(
                      type: ValidationErrorType.plsScanPartCard);
                }
              } else {
                if (state.receivingCards!.isEmpty &&
                    state.receivingCardItems!.isEmpty) {
                  emit(
                    state.copyWith(
                      receivingCard: receivingCard,
                      material: receivingCard.material,
                      receivingCards: [
                        ...?state.receivingCards,
                        ...[receivingCard],
                      ],
                      totalQuantityBarcode: state.totalQuantityBarcode +
                          receivingCard.currentQuantity,
                      locationOfBarcode: receivingCard.location,
                    ),
                  );
                } else {
                  if (state.material != receivingCard.material) {
                    emit(
                      state.copyWith(
                        receivingCards: [receivingCard],
                        receivingCardItems: [],
                        qtyBarcodeOnLocationScanned: 0.0,
                        qtyOnLocation: 0.0,
                        isScanEnough: false,
                        locationOfBarcode: null,
                      ),
                    );
                    throw ValidationError(
                        type: ValidationErrorType.barcodeNotSame);
                  } else {
                    final result = state.receivingCards?.any(
                          (element) => element.id == receivingCard.id,
                    ) ??
                        false;
                    if (result) {
                      throw ValidationError(
                        type: ValidationErrorType.receivingCardScanned,
                      );
                    } else {
                      emit(
                        state.copyWith(
                          receivingCard: receivingCard,
                          material: receivingCard.material,
                          receivingCards: [
                            ...?state.receivingCards,
                            ...[receivingCard],
                          ],
                          totalQuantityBarcode: state.totalQuantityBarcode +
                              receivingCard.currentQuantity,
                          locationOfBarcode: receivingCard.location,
                        ),
                      );
                    }
                  }
                }
              }
              final infoInLocation = await kittingRepository.getQtyByLocation(
                receivingCardId: state.receivingCard?.id,
              );
              if (state.qtyOnLocation == 0.0) {
                emit(
                  state.copyWith(
                    qtyOnLocation: infoInLocation.totalQty ?? 0.0,
                  ),
                );
              }
              if (state.locationOfBarcode == null) {
                emit(
                  state.copyWith(
                    locationOfBarcode: infoInLocation.name ?? '',
                  ),
                );
              }
              if (state.receivingCard?.location?.trim() ==
                  infoInLocation.name?.trim()) {
                qtyBarcodeOnLocationScanned +=
                    state.receivingCard!.currentQuantity.toDouble();
                emit(
                  state.copyWith(
                    qtyBarcodeOnLocationScanned: qtyBarcodeOnLocationScanned,
                  ),
                );
              }
            } else {
              throw ValidationError(type: ValidationErrorType.cardNotStoraged);
            }
          }
        } else {
          throw ValidationError(type: ValidationErrorType.cardNotStoraged);
        }
      } else {
        final partCards =
        await kittingRepository.getReceivingCardItem(barcode: code);
        if (partCards.isNotEmpty) {
          final partCard = partCards.first;
          if (!state.kittingModels.any((element) => element.material == partCard.material)){
            throw ValidationError(type: ValidationErrorType.materialNotInKittingList);
          }
          if (partCard.isOverdue) {
            throw ValidationError(type: ValidationErrorType.overDue);
          } else {
            if (partCard.currentQuantity != 0) {
              if (partCards.length > 1) {
                throw ValidationError(type: ValidationErrorType.soMuchPartCard);
              } else if (state.receivingCardItems!.isEmpty &&
                  state.receivingCards!.isEmpty) {
                emit(
                  state.copyWith(
                    receivingCardItem: partCard,
                    material: partCard.material,
                    receivingCardItems: [
                      ...?state.receivingCardItems,
                      ...partCards,
                    ],
                    totalQuantityBarcode:
                    state.totalQuantityBarcode + partCard.currentQuantity,
                    locationOfBarcode: partCard.location,
                  ),
                );
              } else {
                if (state.material != partCard.material) {
                  emit(
                    state.copyWith(
                      receivingCardItems: [partCard],
                      receivingCards: [],
                      qtyBarcodeOnLocationScanned: 0.0,
                      qtyOnLocation: 0.0,
                      isScanEnough: false,
                      locationOfBarcode: null,
                    ),
                  );
                  throw ValidationError(
                    type: ValidationErrorType.barcodeNotSame,
                  );
                } else {
                  final result = state.receivingCardItems?.any(
                        (element) => element.id == partCard.id,
                  ) ??
                      false;
                  if (result) {
                    throw ValidationError(
                      type: ValidationErrorType.receivingCardScanned,
                    );
                  } else {
                    emit(
                      state.copyWith(
                        receivingCardItem: partCard,
                        material: partCard.material,
                        receivingCardItems: [
                          ...?state.receivingCardItems,
                          ...partCards,
                        ],
                        totalQuantityBarcode: state.totalQuantityBarcode +
                            partCard.currentQuantity,
                        locationOfBarcode: partCard.location,
                      ),
                    );
                  }
                }
              }
              final receivingCard =
              await kittingRepository.getReceivingCardByPartCardId(
                partCardId: state.receivingCardItem?.id,
              );
              final infoInLocation = await kittingRepository.getQtyByLocation(
                receivingCardId: receivingCard.id,
              );
              if (state.qtyOnLocation == 0.0) {
                emit(
                  state.copyWith(
                    qtyOnLocation: infoInLocation.totalQty ?? 0.0,
                  ),
                );
              }
              if (state.locationOfBarcode == null) {
                emit(
                  state.copyWith(
                    locationOfBarcode: infoInLocation.name ?? '',
                  ),
                );
              }
              if (state.receivingCardItem?.location?.trim() ==
                  state.locationOfBarcode) {
                qtyBarcodeOnLocationScanned +=
                    state.receivingCardItem!.currentQuantity.toDouble();
                emit(
                  state.copyWith(
                    qtyBarcodeOnLocationScanned: qtyBarcodeOnLocationScanned,
                  ),
                );
              }
            } else {
              throw ValidationError(type: ValidationErrorType.cardNotStoraged);
            }
          }
        } else {
          throw ValidationError(type: ValidationErrorType.cardNotStoraged);
        }
      }

      if (state.qtyBarcodeOnLocationScanned == state.qtyOnLocation) {
        emit(state.copyWith(isScanEnough: true));
      }

      final fifo =
      await kittingRepository.getFifo(material: state.material ?? '');
      if (isReceivingCard) {
        final listReceivingCard = await kittingRepository.getReceivingCard(
          id: state.receivingCard?.id,
        );
        if (listReceivingCard.firstOrNull?.barcode != fifo.barcode) {
          throw ValidationError(type: ValidationErrorType.isNotFirstLot);
        }
      } else {
        final listReceivingCard = await kittingRepository.getReceivingCard(
          id: state.receivingCardItem?.receivingCardID,
        );
        if (listReceivingCard.firstOrNull?.barcode != fifo.barcode) {
          throw ValidationError(type: ValidationErrorType.isNotFirstLot);
        }
      }
    });
  }

  Future<List<KittingCard>> createKittingCard({
    PrinterDevice? printer,
    bool isPreview = true,
    required List<KittingDetail> kittingModels,
  }) async {
    return launch(() async {
      if (!isPreview) {
        if (printer == null) {
          throw ValidationError(type: ValidationErrorType.connectPrinterError);
        }
        await checkConnectPrint(printerDevice: printer);
      }
      var qtyStop = 0.0;

      kittingModels.removeWhere(
            (element) => element.quantity == element.pickedQuantity,
      );

      if (kittingModels.isEmpty) {
        throw ValidationError(type: ValidationErrorType.noDataForKitting);
      } else {
        var totalPickQuantity = 0.0;
        var quantityOnBarcode = 0.0;

        state.receivingCards?.forEach((element) {
          quantityOnBarcode += element.currentQuantity;
          receivingCardIds?.add(element.id);
        });

        state.receivingCardItems?.forEach((element) {
          quantityOnBarcode += element.currentQuantity;
          receivingCardItemIds?.add(element.id ?? 0);
        });
        for (final value in kittingModels) {
          totalPickQuantity += value.quantity;
        }
        for (final value in kittingModels) {
          if (totalPickQuantity > quantityOnBarcode && !state.isScanEnough) {
            cleatData();
            throw ValidationError(
              type: ValidationErrorType.qtyOnBarcodeNotEnough,
            );
          } else {
            final double realQty;
            final qtyPick = value.quantity - value.pickedQuantity;
            if (state.qtyOnLocation < qtyPick && qtyPick > quantityOnBarcode) {
              realQty = quantityOnBarcode;
            } else {
              realQty = qtyPick;
            }
            if (qtyStop + qtyPick > quantityOnBarcode ) {
              final request = KittingRequest(
                rciDs: receivingCardIds?.mapIndexed((e, i) => (e, i)).toList(),
                rcDetailIDs: receivingCardItemIds?.mapIndexed((e, i) => (e, i)).toList(),
                kittingListDetailId: value.id,
                quantity: quantityOnBarcode - qtyStop,
              );
              kittingRequests.add(request);
              emit(
                state.copyWith(
                  receivingCardIds: receivingCardIds,
                  receivingCardItemIds: receivingCardItemIds,
                  kittingRequests: kittingRequests,
                ),
              );
              break;
            }
            qtyStop += qtyPick;
            final request = KittingRequest(
              rciDs: receivingCardIds?.mapIndexed((e, i) => (e, i)).toList(),
              rcDetailIDs: receivingCardItemIds?.mapIndexed((e, i) => (e, i)).toList(),
              kittingListDetailId: value.id,
              quantity: realQty,
            );
            kittingRequests.add(request);
            emit(
              state.copyWith(
                receivingCardIds: receivingCardIds,
                receivingCardItemIds: receivingCardItemIds,
                kittingRequests: kittingRequests,
              ),
            );
          }
        }
      }
      qtyStop = 0.0;
      final response = await kittingRepository.createKittingCard(
        kittingCardRequests: state.kittingRequests,
        isPreview: isPreview,
        material: state.material,
      );

      if (!isPreview) {
        if (printer == null) {
          throw ValidationError(type: ValidationErrorType.connectPrinterError);
        }
        await printKittingCard(kittingCards: response, printerDevice: printer);
        commands.clear();
        emit(
          state.copyWith(
            receivingCards: [],
            receivingCardItems: [],
            totalQuantityBarcode: 0,
            material: '',
          ),
        );
      }
      cleatData();
      return response;
    });
  }
  Future<void> printKittingCard({
    required PrinterDevice printerDevice,
    required List<KittingCard> kittingCards,
  }) {
    return launch(() async {
      savePrinterDevice = printerDevice;
      final printer = getIt<Printer>();
      for (final element in kittingCards) {
        commands.add(element.command);
      }
      await printer.multiPrint(printerDevice, commands);
    });
  }

  Future<List<PlutoRow>> createPlutoRow(
    List<KittingDetail> data,
    PlutoGridStateManager stateManager,
  ) async {
    stateManager.removeAllRows();
    final row = List.generate(data.length, (index) {
      final kittingItem = data[index];
      return PlutoRow(
        cells: {
          Constants.kPartFieldKey: PlutoCell(value: kittingItem.material),
          Constants.kModelFieldKey: PlutoCell(value: kittingItem.model),
          Constants.kQuantityFieldKey: PlutoCell(value: kittingItem.quantity),
          Constants.kLocationFieldKey:
              PlutoCell(value: kittingItem.locationName),
          Constants.kTimeFieldKey: PlutoCell(value: kittingItem.time ?? ''),
          Constants.kPickedQuantityFieldKey:
              PlutoCell(value: kittingItem.pickedQuantity),
          Constants.kPlantFieldKey: PlutoCell(value: kittingItem.plant ?? ''),
          Constants.kSlocKey: PlutoCell(value: kittingItem.sloc ?? ''),
          Constants.kDeliveryDate:
              PlutoCell(value: kittingItem.deliveryDate?.toText() ?? ''),
          Constants.kPl: PlutoCell(value: kittingItem.pl ?? ''),
          Constants.kReprint: PlutoCell(value: ''),
          Constants.kOverDue: PlutoCell(value: kittingItem.isOverdue),
          Constants.kMissing: PlutoCell(value: kittingItem.missingItem),
        },
      );
    });
    stateManager.insertRows(0, row);
    stateManager.moveScrollByRow(PlutoMoveDirection.up, 1);
    return row;
  }

  Future<void> removePartCard(ReceivingCardItem? receivingCardItem) async {
    var qtyTotal = 0.0;
    final listRcItems = state.receivingCardItems?.clone();
    final listRcs = state.receivingCards?.clone();
    listRcItems?.remove(receivingCardItem);
    final totalQuantityBarcode =
        state.totalQuantityBarcode - (receivingCardItem?.currentQuantity ?? 0);
    final listRcItemsByLocation = listRcItems
        ?.where((element) => element.location == state.locationOfBarcode)
        .toList();
    final listRcsByLocation = listRcs
        ?.where((element) => element.location == state.locationOfBarcode)
        .toList();
    for (final element in listRcItemsByLocation!) {
      qtyTotal += element.currentQuantity;
    }
    for (final element in listRcsByLocation!) {
      qtyTotal += element.currentQuantity;
    }
    if (qtyTotal == state.qtyOnLocation) {
      emit(state.copyWith(isScanEnough: true));
    } else {
      emit(state.copyWith(isScanEnough: false));
    }
    qtyBarcodeOnLocationScanned = qtyTotal;

    emit(
      state.copyWith(
        receivingCardItems: listRcItems,
        totalQuantityBarcode: totalQuantityBarcode,
        qtyBarcodeOnLocationScanned: qtyBarcodeOnLocationScanned,
      ),
    );
  }

  Future<void> removeReceivingCard(ReceivingCard? receivingCard) async {
    return launch(() async {
      var qtyTotal = 0.0;
      final listRcs = state.receivingCards?.clone();
      final listRcItems = state.receivingCardItems?.clone();
      listRcs?.remove(receivingCard);
      final totalQuantityBarcode =
          state.totalQuantityBarcode - (receivingCard?.currentQuantity ?? 0);
      final listRcsByLocation = listRcs
          ?.where((element) => element.location == state.locationOfBarcode)
          .toList();
      final listRcItemsByLocation = listRcItems
          ?.where((element) => element.location == state.locationOfBarcode)
          .toList();
      for (final element in listRcItemsByLocation!) {
        qtyTotal += element.currentQuantity;
      }
      for (final element in listRcsByLocation!) {
        qtyTotal += element.currentQuantity;
      }
      if (qtyTotal == state.qtyOnLocation) {
        emit(state.copyWith(isScanEnough: true));
      } else {
        emit(state.copyWith(isScanEnough: false));
      }
      qtyBarcodeOnLocationScanned = qtyTotal;
      emit(
        state.copyWith(
          receivingCards: listRcs,
          totalQuantityBarcode: totalQuantityBarcode,
          qtyBarcodeOnLocationScanned: qtyBarcodeOnLocationScanned,
        ),
      );
    });
  }

  Future<(int, List<KittingDetail>)> getListKittingDetailByModel(
      {String? material,
      String? model,
      bool? isKittingEnough,
      bool? isOnTheHour,
      int? startTime,
      int? endTime,
      String? deliveryDate,
      String? picUser,
      bool isDay = false,
        String? location,
      }) async {
    return launch(() async {
      final listData = await kittingRepository.getDataKittingDetail(
        material: material,
        model: model,
        isKittingEnough: isKittingEnough,
        isOnTheHour: isOnTheHour,
        startTime: startTime,
        endTime: endTime,
        deliveryDate: deliveryDate,
        picUser: picUser,
        isDay: isDay,
        location: location,
      );
      emit(
        state.copyWith(
            kittingModels: listData.$2,
            material: material,
            totalRecord: listData.$1,
            countKittingDone:
                listData.$2.firstOrNull?.countQtyKittingEnough ?? 0,
            isDay: isDay,
            suggestPaths: listData.$4,
            orderBlocks: listData.$3),
      );
      return (listData.$1, listData.$2);
    });
  }

  Future<void> discardBarcode() {
    return launch(() async {
      qtyBarcodeOnLocationScanned = 0.0;
      final picUser = getIt<StorageManager>().get<String>(StorageKeys.id);
      String? material;
      if (state.receivingCardItems != null) {
        final partCard = state.receivingCardItems?.first;
        material = partCard?.material;
        final receivingCard = await kittingRepository
            .getReceivingCardByPartCardId(partCardId: partCard?.id);
        final infoInLocation = await kittingRepository.getQtyByLocation(
            receivingCardId: receivingCard.id);
        if (state.qtyOnLocation == 0.0) {
          emit(state.copyWith(qtyOnLocation: infoInLocation.totalQty ?? 0.0));
        }
        if (state.locationOfBarcode == null) {
          emit(
            state.copyWith(
              locationOfBarcode: infoInLocation.name ?? '',
            ),
          );
        }

        if (partCard?.location?.trim() == infoInLocation.name?.trim()) {
          qtyBarcodeOnLocationScanned +=
              state.receivingCardItem!.currentQuantity.toDouble();
        }
        emit(state.copyWith(
          totalQuantityBarcode: partCard?.currentQuantity ?? 0,
          qtyBarcodeOnLocationScanned: qtyBarcodeOnLocationScanned,
        ));
      } else {
        final receivingCard = state.receivingCards?.first;
        material = receivingCard?.material;
        final infoInLocation = await kittingRepository.getQtyByLocation(
            receivingCardId: receivingCard?.id);
        if (state.qtyOnLocation == 0.0) {
          emit(state.copyWith(qtyOnLocation: infoInLocation.totalQty ?? 0.0));
        }
        if (state.locationOfBarcode == null) {
          emit(
            state.copyWith(
              locationOfBarcode: infoInLocation.name ?? '',
            ),
          );
        }
        if (receivingCard?.location?.trim() == infoInLocation.name?.trim()) {
          qtyBarcodeOnLocationScanned +=
              state.receivingCardItem!.currentQuantity.toDouble();
        }
        emit(state.copyWith(
            totalQuantityBarcode: receivingCard?.currentQuantity ?? 0,
            qtyBarcodeOnLocationScanned: qtyBarcodeOnLocationScanned));
      }
      if (state.qtyBarcodeOnLocationScanned == state.qtyOnLocation) {
        emit(state.copyWith(isScanEnough: true));
      }
      await getListKittingDetailByModel(
        material: material,
        startTime: state.startTime,
        endTime: state.endTime,
        isOnTheHour: state.isOnTheHour,
        isKittingEnough: state.isKittingEnough,
        deliveryDate: state.deliveryDate,
        picUser: picUser,
        isDay: state.isDay,
        location: state.locationOfBarcode,
      );
    });
  }

  void cleatData() {
    kittingRequests.clear();
    receivingCardIds?.clear();
    receivingCardItemIds?.clear();
    emit(
      state.copyWith(
        kittingRequests: kittingRequests,
        receivingCardIds: receivingCardIds,
        receivingCardItemIds: receivingCardItemIds,
      ),
    );
  }

  Future<void> updateModel(String? model) {
    return launch(() async {
      emit(state.copyWith(model: model ?? '', page: 0));
    });
  }

  Future<AppTableResponse> fetchData(
    AppTableRequest request,
    PlutoGridStateManager stateManager,
    BuildContext context,
  ) async {
    return launch(() async {
      final picUser = getIt<StorageManager>().get<String>(StorageKeys.id);
      final data = await getListKittingDetailByModel(
        material: state.material,
        model: state.model,
        isKittingEnough: state.isKittingEnough,
        isOnTheHour: state.isOnTheHour,
        startTime: state.startTime,
        endTime: state.endTime,
        deliveryDate: state.deliveryDate,
        picUser: picUser,
        isDay: state.isDay,
        location: state.locationOfBarcode,
      );

      final tempList = List.generate(data.$2.length, (index) {
        final kittingItem = data.$2[index];
        return PlutoRow(
          cells: {
            Constants.kPartFieldKey: PlutoCell(value: kittingItem.material),
            Constants.kModelFieldKey: PlutoCell(value: kittingItem.model),
            Constants.kQuantityFieldKey: PlutoCell(value: kittingItem.quantity),
            Constants.kLocationFieldKey:
                PlutoCell(value: kittingItem.locationName),
            Constants.kTimeFieldKey: PlutoCell(value: kittingItem.time ?? ''),
            Constants.kPickedQuantityFieldKey:
                PlutoCell(value: kittingItem.pickedQuantity),
            Constants.kPlantFieldKey: PlutoCell(value: kittingItem.plant ?? ''),
            Constants.kSlocKey: PlutoCell(value: kittingItem.sloc ?? ''),
            Constants.kDeliveryDate:
                PlutoCell(value: kittingItem.deliveryDate?.toText() ?? ''),
            Constants.kPl: PlutoCell(value: kittingItem.pl ?? ''),
            Constants.kReprint: PlutoCell(value: ''),
            Constants.kOverDue: PlutoCell(value: kittingItem.isOverdue),
            Constants.kMissing: PlutoCell(value: kittingItem.missingItem),
          },
        );
      });

      return Future.value(
        AppTableResponse(
          isLast: true,
          rows: tempList.toList(),
        ),
      );
    });
  }

  Future<void> checkConnectPrint({
    required PrinterDevice printerDevice,
  }) {
    return launch(() async {
      final printer = getIt<Printer>();
      await printer.connect(printerDevice);
    });
  }

  Future<List<KittingCard>> rePrintKittingCard(int index) {
    return launch(() async {
      final id = state.kittingModels[index].id;
      final kittingCards =
          await kittingRepository.getKittingCardByKittingListDetailId(id: id);
      return kittingCards;
    });
  }

  Future<void> getPositionOfMaterialOnMap(
      BuildContext context,
      PlutoGridStateManager stateManager,
      ) {
    return launch(() async {
      if (state.kittingModels.isNotEmpty) {
        final listRow = stateManager.currentSelectingRows.toList();
        var listKittingDetails = List<KittingDetail>.empty(growable: true);
        final listLocations = List<String>.empty(growable: true);
        final selectedLocations = List<String>.empty(growable: true);

        if (listRow.isNotEmpty) {
          for (final element in listRow) {
            listKittingDetails.add(state.kittingModels[element.sortIdx]);
          }
          for (final element in listKittingDetails) {
            if (!selectedLocations.contains(element.locationName)) {
              selectedLocations.add(element.locationName!);
            }
          }
        }

        if (context.mounted) {
          context.pushRoute(
            EmapKittingRoute(
              listKittingDetails: state.kittingModels,
              selectedLocations: selectedLocations,
            ),
          );
        }
      } else {
        throw ValidationError(
          type: ValidationErrorType.scanBarcodeForGetLocation,
        );
      }
    });
  }
}
