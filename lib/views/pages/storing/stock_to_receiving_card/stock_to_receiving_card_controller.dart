import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/barcode/barcode.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/entities/receiving_card_item.dart';
import 'package:smart_warehouse/entities/stock_card.dart';
import 'package:smart_warehouse/entities/warehouse_card.dart';
import 'package:smart_warehouse/enums/receving_card_type.dart';
import 'package:smart_warehouse/enums/storage_scan_recard_error.dart';
import 'package:smart_warehouse/repositories/master_repository.dart';
import 'package:smart_warehouse/repositories/storing_repository.dart';
import 'package:smart_warehouse/services/models/request/receiving_card_by_stock_request_model.dart';
import 'package:smart_warehouse/services/models/response/plant_type_freqquency_response_model.dart';
import 'package:smart_warehouse/services/models/response/sloc_info_from_plant_response_model.dart';
import 'package:smart_warehouse/services/translators/receiving_card_translator.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/extensions/datetime_extensions.dart';
import 'package:smart_warehouse/shared/extensions/iterable_extensions.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';
import 'package:smart_warehouse/subsystem/printer/printer.dart';

import 'stock_to_receiving_card_state.dart';

@injectable
class StockToReceivingCardController
    extends BaseCubit<StockToReceivingCardState> {
  StockToReceivingCardController(
    this._storingRepository,
    this._masterRepository,
  ) : super(StockToReceivingCardState());

  final StoringRepository _storingRepository;
  final MasterRepository _masterRepository;

  PrinterDevice? savePrinterDevice;
  List<PrinterDevice>? printerDevices;

  @override
  Future<void> initData() async {
    final response = await _masterRepository.getPrinterDevices();
    printerDevices = response.$2;
    savePrinterDevice = _masterRepository.getPreviousPrinterDevice();
  }

  Future<void> scanStockCard(String value) async {
    if (value.isEmpty) {
      return;
    }
    clearData();

    try {
      launch(() async {
        final currentStockCard = StockCard.getStockCardFormat(value);
        emit(state.copyWith(stockCard: currentStockCard));
        if (currentStockCard.material != null &&
            currentStockCard.material != '') {
          final material = currentStockCard.material ?? '';
          final resPlant = await _storingRepository.getAllPlanSlocFromMaterial(
              material: material);

          if (resPlant != null && resPlant.isNotEmpty) {
            emit(
              state.copyWith(
                listPlant: resPlant,
                stockCard: currentStockCard,
              ),
            );

            if (resPlant.length == 1) {
              emit(
                state.copyWith(
                  currentPlant: resPlant.first,
                  currentSloc: resPlant.first.slocs?.first,
                  currentListSloc: resPlant.first.slocs ?? [],
                ),
              );
              if (resPlant.first.slocs?.length == 1) {
                emit(
                  state.copyWith(
                    currentCategory:
                        resPlant.first.slocs?.first.category?.first ?? '',
                    currentListCate: resPlant.first.slocs?.first.category ?? [],
                  ),
                );
              }

              final currentPlant = resPlant.first.plant ?? '';
              final vendorCode = currentStockCard.vendorCode ?? '';
              final material = currentStockCard.material ?? '';
              if (currentPlant.isNotEmpty &&
                  vendorCode.isNotEmpty &&
                  material.isNotEmpty) {
                final resQm = await _storingRepository.getQmConvertStockCard(
                  material: material,
                  vendorCode: vendorCode,
                  plant: currentPlant,
                );
                if (resQm != null) {
                  emit(state.copyWith(samplingRohsVendor: resQm));
                }
              }
            }
          }

          final resUrgen = await _storingRepository.getUrgenInfoFromMaterial(
            material: currentStockCard.material!,
          );
          if (resUrgen != null) {
            emit(state.copyWith(urgenUlcoc: resUrgen));
          }
        }
      });
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> scanWarehouseCard(String value) async {
    if (value.isEmpty) {
      return;
    }

    try {
      launch(() async {
        final wareHouseCard = WareHouseCard.getWareHouseCardFormat(value);
        final currentMaterial = state.stockCard?.material;
        if (wareHouseCard.material != currentMaterial) {
          throw ValidationError(type: ValidationErrorType.materialNotSame);
        }

        final res = await _storingRepository.getAllBoxCard(
          material: wareHouseCard.material ?? '',
          plant: wareHouseCard.plant ?? '',
          sloc: wareHouseCard.sloc ?? '',
          position: wareHouseCard.position ?? '',
        );

        if (res != null && res.isNotEmpty) {
          emit(
            state.copyWith(
              boxCardList: res,
              wareHouseCard: wareHouseCard,
            ),
          );
        } else {
          throw ValidationError(type: ValidationErrorType.doNotHaveData);
        }
      });
    } catch (e) {
      logger.e(e);
    }
  }

  Future<void> checkConnectPrint({
    required PrinterDevice printerDevice,
  }) {
    return launch(() async {
      final printer = getIt<Printer>();
      await printer.connect(printerDevice);
    });
  }

  Future<void> printReceivingCard({
    required PrinterDevice printerDevice,
    required ReceivingCard receivingCard,
  }) {
    return launch(() async {
      savePrinterDevice = printerDevice;
      final printer = getIt<Printer>();
      await printer.connect(printerDevice);
      await printer.print(printerDevice, receivingCard.command);
    });
  }

  Future<ReceivingCard> convertStockToReceiving({
    required int totalQty,
    required int currentQty,
    required int boxTotal,
    required String barcodeStock,
  }) async {
    return launch(() async {
      final updateMaterialList = state.boxCardList
          .map((e) => ReceivingCardItem.fromBarcode(e))
          .toList();
      final body = ReceivingCardByStockRequestModel(
        receivingCardTime: DateTime.now().toText(DateTimeType.time),
        plant: state.currentPlant?.plant ?? '',
        receivingCardDate: state.stockCard?.deliveryDate,
        urgent: state.urgenUlcoc?.urgent ?? '',
        ulcoc: state.urgenUlcoc?.ulcoc ?? '',
        material: state.stockCard?.material ?? '',
        materialType: state.currentSloc?.type ?? '',
        materialFrequency: state.currentSloc?.frequency ?? '',
        daInvNo: state.stockCard?.daInv ?? '',
        vendorCode: state.stockCard?.vendorCode ?? '',
        category: state.currentCategory,
        totalQuantity: totalQty,
        currentQuantity: currentQty,
        box: boxTotal,
        pl: state.samplingRohsVendor?.iqcpl ?? '',
        rohs: state.samplingRohsVendor?.rohs ?? '',
        sloc: state.currentSloc?.sloc ?? '',
        vendorName: state.samplingRohsVendor?.vendorName ?? '',
        samplingCheck: state.samplingRohsVendor?.samplingCheck ?? 0,
        rohsCheck: state.samplingRohsVendor?.rohsCheck ?? 0,
        listMaterial:
            updateMaterialList.map((e) => e.toRequestModel()).toList(),
        barcodeStockCard: barcodeStock,
      );

      final res =
          await _storingRepository.createConvertStockToReCard(body: body);
      logger.i('create ReCard successfully');

      return res.toEntity(
        hasDeliveryPlan: false,
        daInvByStock: state.stockCard?.daInv,
      );
    });
  }

  Future<void> runConverterPrint({
    PrinterDevice? printer,
    ReceivingCard? receivingCardConverted,
    int boxTotal = 0,
  }) async {
    if (printer == null) {
      throw ValidationError(type: ValidationErrorType.connectPrinterError);
    }
    // await checkConnectPrint(printerDevice: printer);

    if (receivingCardConverted != null) {
      final rcAddBox = receivingCardConverted;
      rcAddBox.box = boxTotal;
      rcAddBox.rcType = ReceivingCardPrinterType.rcConvert;
      await printReceivingCard(
        printerDevice: printer,
        receivingCard: rcAddBox,
      );

      clearData();
    }
  }

  void onSelectPlant(PlantTypeFrequencyResponseModel newPlant) {
    emit(
      state.copyWith(
        currentPlant: newPlant,
        currentSloc: null,
        currentCategory: '',
        currentListCate: [],
        currentListSloc: newPlant.slocs ?? [],
      ),
    );
  }

  Future<void> onSelectSloc(SlocInfoFromPlantResponseModel currentSloc) async {
    return launch(() async {
      emit(state.copyWith(currentSloc: currentSloc));

      if (currentSloc.category?.length == 1) {
        emit(
          state.copyWith(
            currentCategory: currentSloc.category?.first ?? '',
            currentListCate: currentSloc.category ?? [],
          ),
        );
      } else {
        emit(
          state.copyWith(
            currentListCate: currentSloc.category ?? [],
          ),
        );
      }
      final currentPlant = state.currentPlant?.plant ?? '';
      final vendorCode = state.stockCard?.vendorCode ?? '';
      final material = state.stockCard?.material ?? '';
      if (currentPlant.isNotEmpty &&
          vendorCode.isNotEmpty &&
          material.isNotEmpty) {
        final resQm = await _storingRepository.getQmConvertStockCard(
          material: material,
          vendorCode: vendorCode,
          plant: currentPlant,
        );
        if (resQm != null) {
          emit(state.copyWith(samplingRohsVendor: resQm));
        }
      }
    });
  }

  Future<void> onSelectCate(String currentCate) async {
    return launch(() async {
      emit(state.copyWith(currentCategory: currentCate));
    });
  }

  Future<void> inputBoxCard(String value) async {
    return launch(() async {
      final currentBarcode = Barcode.fromBarcode(value);
      final clone = state.boxCardList.clone();
      final material = state.stockCard?.material ?? '';
      if (material != currentBarcode.material) {
        emit(state.copyWith(stockToRcError: StockToRcError.materialNotSame));

        throw ValidationError(type: ValidationErrorType.materialNotSame);
      }
      final validate =
          clone.any((e) => e.barcode.contains(currentBarcode.barcode));
      if (validate) {
        emit(state.copyWith(stockToRcError: StockToRcError.boxCardScanned));
        throw ValidationError(type: ValidationErrorType.boxCardScanned);
      }
      clone.add(currentBarcode);
      emit(state.copyWith(boxCardList: clone));
    });
  }

  void updateBoxCard(int i, int value) {
    List<Barcode> clone = state.boxCardList.clone();
    clone[i].quantity = value;
    emit(state.copyWith(boxCardList: clone));
  }

  void removeBoxCard(int i) {
    List<Barcode> clone = state.boxCardList.clone();
    clone.removeAt(i);
    emit(state.copyWith(boxCardList: clone));
  }

  void onChangeRcDate(DateTime value) {
    String formattedDate = DateFormat('MM/dd/yyyy').format(value);
    final stockTimeUpdate = state.stockCard;
    stockTimeUpdate?.deliveryDate = formattedDate;
    emit(state.copyWith(rcTime: value, stockCard: stockTimeUpdate));
  }

  void clearData() {
    emit(
      state.copyWith(
        listPlant: [],
        currentListSloc: [],
        currentListCate: [],
        boxCardList: [],
        currentCategory: '',
        stockCard: null,
        urgenUlcoc: null,
        samplingRohsVendor: null,
        currentPlant: null,
        currentSloc: null,
        receivingCardConverted: null,
        stockToRcError: null,
        wareHouseCard: null,
        rcTime: null,
      ),
    );
  }
}
