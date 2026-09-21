import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/barcode/barcode.dart';
import 'package:smart_warehouse/entities/inventory/plant_sloc_category.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/entities/receiving_card_item.dart';
import 'package:smart_warehouse/enums/receving_card_type.dart';
import 'package:smart_warehouse/repositories/inventory_repository.dart';
import 'package:smart_warehouse/repositories/master_repository.dart';
import 'package:smart_warehouse/repositories/receiving_card_repository.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/extensions/duration_extensions.dart';
import 'package:smart_warehouse/shared/extensions/iterable_extensions.dart';
import 'package:smart_warehouse/shared/extensions/list_update_extension.dart';
import 'package:smart_warehouse/shared/extensions/object_extensions.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';
import 'package:smart_warehouse/subsystem/printer/printer.dart';
import 'package:smart_warehouse/views/dialogs/print_box_card_dialog.dart';

import 'split_receiving_card_state.dart';

@injectable
class SplitReceivingCardController extends BaseCubit<SplitReceivingCardState> {
  SplitReceivingCardController(
    this._receivingCardRepository,
    this._inventoryRepository,
    this._masterRepository,
  ) : super(SplitReceivingCardState());

  final InventoryRepository _inventoryRepository;
  final ReceivingCardRepository _receivingCardRepository;
  final MasterRepository _masterRepository;

  PrinterDevice? savePrinterDevice;
  List<PrinterDevice>? printerDevices;

  @override
  Future<void> initData() async {
    try {
      launch(() async {
        final response = await _masterRepository.getPrinterDevices();
        printerDevices = response.$2;
        savePrinterDevice = _masterRepository.getPreviousPrinterDevice();

        final resPlant = await _inventoryRepository.getAllPlantCate();
        if (resPlant.isNotEmpty) {
          emit(state.copyWith(listPlant: resPlant));
        }
      });
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> scanReceivingCard(String value) async {
    if (value.isEmpty) {
      return;
    }

    try {
      launch(() async {
        if (value.isNotEmpty && value.contains(';')) {
          final receivingCardID = ReceivingCard.getReceivingCardID(value);

          final res =
              await _receivingCardRepository.getReceivingCard(receivingCardID);

          final rcPlant = res.plant ?? '';
          final rcCate = res.category ?? '';
          final rcSloc = res.sloc ?? '';

          if (rcPlant.isNotEmpty) {
            List<CategorySloc> listCate = [];
            List<String> listSloc = [];
            final plantListData = state.listPlant.clone();

            PlantCategory? currentPlant;
            CategorySloc? currentCate;
            String? currentSloc;
            for (var plant in plantListData) {
              if (plant.plant == rcPlant) {
                currentPlant = plant;
                listCate = plant.categoryList;

                if (rcCate.isNotEmpty) {
                  for (var cate in listCate) {
                    if (cate.category == rcCate) {
                      currentCate = cate;
                      listSloc = cate.sloc;
                      if (rcSloc.isNotEmpty) {
                        for (var sloc in listSloc) {
                          if (sloc == rcSloc) {
                            currentSloc = sloc;
                          }
                        }
                      }
                    }
                  }
                } else {
                  currentCate = currentCate?.copyWith(cate: rcCate);
                  currentSloc = rcSloc;
                }
              }
            }

            emit(
              state.copyWith(
                currentSloc: currentSloc,
                currentPlant: currentPlant,
                currentCate: currentCate,
                listCate: listCate,
                listSloc: listSloc,
              ),
            );
          }
          emit(state.copyWith(currentReCard: res, listBoxScanned: []));
        } else {
          throw ValidationError(type: ValidationErrorType.receivingCardInvalid);
        }
      });
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> scanBoxCard(String boxCard) {
    return launch(() async {
      if (boxCard.isEmpty) {
        return;
      }
      final boxCardListScanned = state.listBoxScanned.clone();
      final rcScanned = state.currentReCard;
      List<ReceivingCardItem> boxCardInRc = [];
      boxCardInRc.addAll(rcScanned?.items ?? []);

      if (boxCardInRc.isNotEmpty) {
        final boxScanned =
            boxCardInRc.firstWhereOrNull((e) => e.barcode == boxCard);
        if (boxScanned != null) {
          final checkVisible =
              boxCardListScanned.any((e) => e.barcode == boxCard);
          if (checkVisible) {
            throw ValidationError(type: ValidationErrorType.barcodeScanned);
          } else {
            boxCardListScanned.insert(0, boxScanned);
          }
        } else {
          throw ValidationError(
              type: ValidationErrorType.boxCardNotExistInReceivingCard);
        }

        emit(state.copyWith(listBoxScanned: boxCardListScanned));
      }
    });
  }

  void scanSloc(String sloc) {
    emit(state.copyWith(slocUpdate: sloc));
  }

  void updateMaterial(String material) {
    emit(state.copyWith(materialUpdate: material));
  }

  Future<void> updateQuantity(String location) {
    return launch(() async {});
  }

  void onSelectPlant(PlantCategory newPlant) {
    emit(state.copyWith(
      currentPlant: newPlant,
      listCate: newPlant.categoryList,
      currentCate: newPlant.categoryList.first,
      listSloc: newPlant.categoryList.first.sloc,
      currentSloc: newPlant.categoryList.first.sloc.first,
    ));
  }

  void onSelectCate(CategorySloc newCategory) {
    emit(state.copyWith(
      currentCate: newCategory,
      listSloc: newCategory.sloc,
      currentSloc: newCategory.sloc.first,
    ));
  }

  void onSelectSloc(String newSloc) {
    emit(state.copyWith(currentSloc: newSloc));
  }

  Future<void> updateQtyBoxInRc({
    required int updateQty,
    required ReceivingCardItem rcItem,
    required int index,
  }) async {
    return launch(() async {
      List<ReceivingCardItem> listBoxScanned = state.listBoxScanned.clone();
      ReceivingCardItem boxUpdate = rcItem.copyWith(quantity: updateQty);

      listBoxScanned.update(index, boxUpdate);
      emit(state.copyWith(listBoxScanned: listBoxScanned));
    });
  }

  void removeBoxCard({
    required int index,
  }) {
    List<ReceivingCardItem> listBoxScanned = state.listBoxScanned.clone();

    listBoxScanned.removeAt(index);
    emit(state.copyWith(listBoxScanned: listBoxScanned));
  }

  void onChangeReCheck(bool value) {
    if(value){
      onChangeSampling(true);
    }
    emit(state.copyWith(qcSamplingReCheck: value));
  }

  void onChangeSampling(bool value) {
    emit(state.copyWith(isSamplingCheck: value));
  }

  Future<ReceivingCard> splitReceivingCard({
    bool isPreview = false,
    required String qtyUpdate,
    required String materialUpdate,
    required String slocUpdate,
  }) {
    return launch(() async {
      ReceivingCard? currentRc = state.currentReCard;

      if (currentRc == null) {
        throw ValidationError(
          type: ValidationErrorType.openReceivingCardError,
        );
      }

      // Tuấn Anh Check
      List<ReceivingCardItem> boxInRc = state.listBoxScanned.clone();


      final reCheck = state.qcSamplingReCheck;
      final isSamplingCheck = state.isSamplingCheck;
      final currentPlant = state.currentPlant?.plant ?? currentRc.plant;
      final currentCate = state.currentCate?.category ?? currentRc.category;
      final currentSloc = slocUpdate.isNotEmpty
          ? slocUpdate
          : state.currentSloc ?? currentRc.sloc ?? '';
      String materialUpdate = '';
      if (state.materialUpdate.isNotEmpty &&
          state.materialUpdate != currentRc.material) {
        materialUpdate = state.materialUpdate;
      }
      final hasBox = currentRc.items.isNotEmpty;
      final listBoxNotSame = currentRc.items.map((e) => e.barcode).toSet();

      int qtySplit = qtyUpdate.isNotEmpty ? qtyUpdate.toInt() : 0;
      if (listBoxNotSame.length == currentRc.items.length && hasBox) {
        qtySplit = boxInRc.map((e) => e.currentQuantity).sum;
      }

      // Tuấn Anh Check
      // if (currentRc.items.length == 1) {
      //   ReceivingCardItem rcFirst = currentRc.items.first;
      //   rcFirst = rcFirst.copyWith(quantity: qtySplit);
      //   boxInRc.add(rcFirst);
      // }

      if (currentPlant == null || currentCate == null || currentSloc == '') {
        throw ValidationError(type: ValidationErrorType.plsInputPlantCateSloc);
      }

      return _receivingCardRepository.splitReceivingCard(
        parentId: currentRc.id.value(),
        quantity: qtySplit,
        box: boxInRc.length,
        isRecheck: reCheck,
        sloc: currentSloc,
        listMaterial: boxInRc,
        isPreview: isPreview,
        category: currentCate,
        plant: currentPlant,
        isSamplingCheck: isSamplingCheck,
        material: materialUpdate.isNotEmpty ? materialUpdate : null,
      );
    });
  }

  Future<void> runConverterPrint({
    PrinterDevice? printer,
    ReceivingCard? receivingCardConverted,
    required BuildContext context,
  }) async {
    if (printer == null) {
      throw ValidationError(type: ValidationErrorType.connectPrinterError);
    }

    if (receivingCardConverted != null) {
      var rcAddBox = receivingCardConverted;
      final rcCheck = state.qcSamplingReCheck;
      final materialUpdate = state.materialUpdate;
      final selectedSloc = state.currentSloc;
      final materialInOldRc = state.currentReCard?.material;
      final rcSloc = state.currentReCard?.sloc;
      // Tuấn Anh check 309
      final is309Case = materialUpdate.isNotEmpty && materialUpdate != materialInOldRc || (selectedSloc != null && rcSloc != null && selectedSloc != rcSloc);

      rcAddBox = rcAddBox.copyWith(
        quantity: rcCheck ? rcAddBox.currentQuantity : rcAddBox.totalQuantity,
        rcCurrentType: rcCheck
            ? ReceivingCardPrinterType.reCheckCard
            : is309Case
                ? ReceivingCardPrinterType.three09Card
                : ReceivingCardPrinterType.receivingCard,
      );
      await printReceivingCard(
        printerDevice: printer,
        receivingCard: rcAddBox,
        context: context,
      );

      // Print box when Rc that's split get box

      //Tuấn Anh sửa
      if (materialUpdate.isNotEmpty &&
          materialUpdate != materialInOldRc &&
          rcAddBox.items.isNotEmpty) {
        final barcodes = rcAddBox.items.map((e) => e.partCard).toList() ?? [];
        await Duration.zero.delay(() async {
          showPrintBoxCardDialog(
            context,
            barcodes: barcodes,
            onConfirm: (printer, from, to) {
              printBoxCards(
                barcodes: barcodes.sublist(from - 1, to),
                printerDevice: printer,
              );
            },
            printerDevices: printerDevices ?? [],
            previousPrinterDevice: printer,
          );
        });
      }

      clearData();
    }
  }

  Future<void> printReceivingCard({
    required PrinterDevice printerDevice,
    required ReceivingCard receivingCard,
    required BuildContext context,
  }) {
    return launch(() async {
      savePrinterDevice = printerDevice;
      final printer = getIt<Printer>();
      await printer.connect(printerDevice);
      await printer.print(printerDevice, receivingCard.command);
    });
  }

  Future<void> printBoxCards({
    required List<Barcode> barcodes,
    required PrinterDevice printerDevice,
  }) {
    return launch(() async {
      await getIt<Printer>().connect(printerDevice);
      await getIt<Printer>()
          .multiPrint(printerDevice, barcodes.map((e) => e.command).toList());
    });
  }

  void clearData() {
    emit(
      state.copyWith(
        currentReCard: null,
        currentSloc: null,
        currentCate: null,
        materialUpdate: '',
        qcSamplingReCheck: false,
        isSamplingCheck: false,
        listSloc: [],
        listCate: [],
        listBoxScanned: [],
      ),
    );
  }
}
