import 'package:collection/collection.dart';
import 'package:injectable/injectable.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/entities/kitting/kitting_card.dart';
import 'package:smart_warehouse/entities/kitting/kitting_detail.dart';
import 'package:smart_warehouse/entities/kitting_filter.dart';
import 'package:smart_warehouse/entities/kitting_request.dart';
import 'package:smart_warehouse/entities/receiving_card.dart';
import 'package:smart_warehouse/entities/receiving_card_item.dart';
import 'package:smart_warehouse/entities/storage_card.dart';
import 'package:smart_warehouse/enums/kitting_type.dart';
import 'package:smart_warehouse/repositories/kitting_repository.dart';
import 'package:smart_warehouse/repositories/master_repository.dart';
import 'package:smart_warehouse/repositories/receiving_card_repository.dart';
import 'package:smart_warehouse/repositories/storing_repository.dart';
import 'package:smart_warehouse/shared/base/base_cubit.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/extensions/datetime_extensions.dart';
import 'package:smart_warehouse/shared/extensions/iterable_extensions.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';
import 'package:smart_warehouse/shared/utils/storage_manager.dart';
import 'package:smart_warehouse/subsystem/printer/printer.dart';

import 'kitting_state.dart';

@injectable
class KittingController extends BaseCubit<KittingState> {
  KittingController(
    this._kittingRepository,
    this._receivingCardRepository,
    this._masterRepository,
    this._storingRepository,
  ) : super(KittingState());

  final KittingRepository _kittingRepository;
  final ReceivingCardRepository _receivingCardRepository;
  final StoringRepository _storingRepository;
  final MasterRepository _masterRepository;

  late KittingType? kittingType;
  List<PrinterDevice>? printerDevices;
  PrinterDevice? savedPrinterDevice;
  String? savedBarcode;

  @override
  Future<void> initData() {
    return launch(() async {
      final response = await _masterRepository.getPrinterDevices();
      printerDevices = response.$2;
      savedPrinterDevice = _masterRepository.getPreviousPrinterDevice();

      DateTime? deliveryDate;

      final savedDate = getIt<StorageManager>()
          .get<String>(StorageKeys.kittingDate)
          ?.toDate(DateTimeType.yyyyMMdd);
      if (savedDate != null && (savedDate.isAfter(DateTime.now()) || savedDate.toText() == DateTime.now().toText())) {
        deliveryDate ??= savedDate;
      }
      emit(
        state.copyWith(
          kittingFilter: state.kittingFilter.copyWith(
            kittingType: kittingType ?? KittingType.fa,
            deliveryDate: deliveryDate,
            isDay: deliveryDate != null,
          ),
        ),
      );

      await loadKittingListItems();
    });
  }

  void updateFilter(KittingFilter filter) {
    emit(state.copyWith(kittingFilter: filter));
    loadKittingListItems();
  }
 // Tuấn Anh thêm
  void UpdateBlock(String Block){
    emit(state.copyWith(scanningLocation: Block));
  }


  void clearFilter() {
    const kittingFilter = KittingFilter(kittingType: KittingType.fa);
    emit(state.copyWith(kittingFilter: kittingFilter));
    loadKittingListItems();
  }

  void updateSelectedKittingDetails(List<int> selectedList) {
    emit(state.copyWith(selectedKittingDetails: selectedList));
  }

  Future<void> loadKittingListItems() {
    return launch(() async {
      final filter = state.kittingFilter;
      final picUser = getIt<StorageManager>().get<String>(StorageKeys.id);

      final kittingRes = await _kittingRepository.getDataKittingDetail(
        picUser: [KittingType.fa, KittingType.dip].contains(filter.kittingType)
            ? picUser
            : null,
        material: filter.material,
        kittingTimeType: filter.kittingTimeType.text,
        pageSize: filter.pageSize,
        pageNumber: filter.pageNumber,
        startTime: filter.startTime,
        endTime: filter.endTime,
        isJIT: filter.isJIT,
        model: filter.model,
        location: filter.location,
        isDownstairs: filter.isDownstairs,
        isOnTheHour: filter.isOnTheHour,
        isKittingEnough: filter.isKittingEnough,
        deliveryDate: filter.deliveryDate?.toText(DateTimeType.yyyyMMdd),
        isUrgent: filter.isUrgent,
        kittingType: filter.kittingType.code,
        startLocation: filter.startLocation,
        uploadNo: filter.uploadNo,
        category: filter.category,
        reason: filter.reason,
        isDay: filter.isDay,
        isSub: filter.isSub,
      );

      clearData();
      emit(
        state.copyWith(
          kittingDetails: kittingRes.$2,
          suggestPaths: kittingRes.$4 ?? [],
          orderBlocks: kittingRes.$3 ?? [],
        ),
      );
    });
  }

  void _validate(String barcode) {
    // Kiểm tra số lượng đã quét đã
    if (pickedQuantity > totalQuantity) {
      throw ValidationError(type: ValidationErrorType.kittingListEnough);
    }

    // Kiểm tra barcode có cùng mã với barcode đang quét không?
    if (state.scanningItem != null &&
        !barcode.contains(state.scanningItem!.material)) {
      throw ValidationError(type: ValidationErrorType.materialNotSame);
    }

    // Kiểm tra barcode có nằm trong danh sách đã quét rồi không?
    if (state.kittingBoxScanned.any((element) => element.barcode == barcode)) {
      throw ValidationError(type: ValidationErrorType.barcodeScanned);
    }

    // Kiểm tra mã của barcode có nằm trong danh sách cần lấy không?
    if (!state.kittingDetails
        .any((element) => barcode.contains(element.material))) {
      throw ValidationError(type: ValidationErrorType.materialNotInKittingList);
    }
  }

  Future<void> _checkFirstLot(StorageCard scanningItem) async {
    final locationRes =
        await _storingRepository.getLocationByReId(rcId: scanningItem.rcId);

    if (locationRes?.location == null) {
      throw ValidationError(type: ValidationErrorType.receivingCardNotStored);
    }

    //Tuấn Anh thêm
    // if(state.kittingDetails.any((x)=> x.material == scanningItem.material && x.sameMaterial)){
    //   if( state.scanningLocation == null){
    //     throw ValidationError(type: ValidationErrorType.RequirePosition);
    //   }
    // }

    // if(locationRes?.location != state.scanningLocation){
    //   throw ValidationError(type: ValidationErrorType.kittingWrongPosition);
    // }
    
    if (state.scanningLocation != null &&
        state.scanningLocation != locationRes?.location) {
      throw ValidationError(type: ValidationErrorType.kittingWrongPosition);
    }

    if (!getKittingDetailFilter().any(
      (element) =>
          element.locationName == locationRes?.location &&
          element.material == scanningItem.material,
    )) {
      throw ValidationError(type: ValidationErrorType.kittingWrongPositionLot);
    }
    emit(state.copyWith(scanningLocation: locationRes?.location));
    var rcInLocation = await _storingRepository.getMaterialByLocation(
      locationName: locationRes?.location ?? '',
    );
    rcInLocation = rcInLocation
        ?.where(
          (element) =>
              element.material == scanningItem.material &&
              element.totalCurrentQuantity != 0,
        )
        .toList();
    rcInLocation?.sort(
      (a, b) => '${a.receivingCardDate}'.compareTo('${b.receivingCardDate}'),
    );
    final preRCID = state.scanningItem?.rcId;
    if (scanningItem.rcId != preRCID) {
      // Kiểm tra Receiving Card cùng ngày đó đã quét đã hết chưa?
      if (preRCID != null &&
          state.scanningItem?.receivingDate != scanningItem.receivingDate) {
        final lastRCQuantity = rcInLocation
                ?.firstWhereOrNull((e) => e.receivingCardID == preRCID)
                ?.totalCurrentQuantity ??
            0;
        final pickedQuantityInRC = state.kittingBoxScanned
            .where((element) => element.rcId == preRCID)
            .map((e) => e.quantity)
            .sum;
        if (lastRCQuantity > pickedQuantityInRC) {
          throw ValidationError(
            type: ValidationErrorType.qtyOnBarcodeNotEnough,
          );
        }
      }

      // kiểm tra Receiving Card có phải first lot hay không?
      final rcRemains = rcInLocation?.where(
            (element) => !state.kittingBoxScanned
                .any((box) => box.rcId == element.receivingCardID),
          ) ??
          [];

      final rcFirsts =
          groupBy(rcRemains, (p0) => p0.receivingCardDate).values.first;

      if (!rcFirsts
          .any((element) => element.receivingCardID == scanningItem.rcId)) {
        throw ValidationError(type: ValidationErrorType.firstLotRequired);
      }
    }

    emit(state.copyWith(receivingCardInLocation: rcInLocation));
  }

  Future<void> scanCard(String barcode, {bool skipCheckFirstLot = false}) {
    return launch(() async {
      _validate(barcode);
      savedBarcode = barcode;

      final scanningItem = await _receivingCardRepository.getStorageCard(
          barcode, state.kittingFilter.isSub);

      if (scanningItem.quantity == 0) {
        throw ValidationError(type: ValidationErrorType.barcodeNotEnough);
      }

      if (!skipCheckFirstLot && !state.kittingFilter.isSub) {
        await _checkFirstLot(scanningItem);
      }

      final newList = state.kittingBoxScanned.clone()..add(scanningItem);
      emit(
        state.copyWith(
          scanningItem: scanningItem,
          kittingBoxScanned: newList,
        ),
      );
    });
  }

  void updateCard(StorageCard card) {
    final newList = state.kittingBoxScanned.clone();
    final index = newList.indexWhere(
      (element) =>
          element.id == card.id && element.runtimeType == card.runtimeType,
    );
    newList[index] = card;
    emit(state.copyWith(kittingBoxScanned: newList));
  }

  void deleteCard(StorageCard card) {
    if (state.kittingBoxScanned.length == 1) {
      clearData();
      return;
    }

    final newList = state.kittingBoxScanned.clone()..remove(card);
    emit(state.copyWith(kittingBoxScanned: newList));
  }

  void removeLocationFilter() {
    emit(state.copyWith(scanningLocation: null));
  }

  Future<List<KittingCard>> createKittingCard({
    required List<KittingDetail> kittingDetails,
    bool isPreview = false,
  }) {
    return launch(() async {
      final kittingCardRequests = <KittingRequest>[];

      final storageCards =
          state.kittingBoxScanned.clone(); // Tạo bản sao của danh sách

      for (final kittingDetail in kittingDetails) {
        // Tính toán số lượng cần kitting
        var needKittingQuantity =
            (kittingDetail.quantity - kittingDetail.pickedQuantity)
                .toInt(); // Lấy số lượng từ kittingDetail

        var pickedQuantity = 0; // Số lượng đã pick
        final pickedCard = <StorageCard>[];

        final remainingStorageCards =
            <StorageCard>[]; // Danh sách tạm cho các phần tử không được loại bỏ

        for (var element in storageCards) {
          if (needKittingQuantity <= 0) {
            remainingStorageCards.add(element);
            continue; // Nếu đã đạt đủ số lượng, thoát vòng lặp
          }

          if (element.quantity <= needKittingQuantity) {
            // Nếu số lượng của element nhỏ hơn hoặc bằng số lượng cần thiết
            pickedQuantity += element.quantity; // Cộng dồn vào pickedQuantity
            needKittingQuantity -=
                element.quantity; // Giảm số lượng cần kitting
            element = element.copyWith(stockQuantity: 0);
          } else {
            // Nếu số lượng của element lớn hơn số lượng cần thiết
            pickedQuantity +=
                needKittingQuantity; // Cộng dồn số lượng còn cần thiết
            element = element.copyWith(
              stockQuantity: element.quantity -
                  needKittingQuantity, // Trừ số lượng cần kitting
            );
            needKittingQuantity = 0; // Đã đủ số lượng cần kitting
          }

          pickedCard.add(element);

          // Nếu phần tử vẫn còn số lượng sau khi trừ, thêm vào danh sách tạm
          if (element.quantity > 0) {
            remainingStorageCards.add(element);
          }
        }

        // Cập nhật lại danh sách storageCards còn lại
        storageCards
          ..clear()
          ..addAll(remainingStorageCards);

        final rcIds = <(int, int)>[];
        final rcDetailIDs = <(int, int)>[];

        for (var i = 0; i < pickedCard.length; i++) {
          final card = pickedCard[i];
          if (card is ReceivingCard) {
            rcIds.add((card.id, i));
          } else {
            rcDetailIDs.add((card.id, i));
          }
        }

        // Tạo yêu cầu kitting
        kittingCardRequests.add(
          KittingRequest(
            kittingListDetailId: kittingDetail.id,
            quantity: pickedQuantity.toDouble(),
            // Đảm bảo pickedQuantity có giá trị đúng
            rciDs: rcIds,
            rcDetailIDs: rcDetailIDs,
          ),
        );

        // Kiểm tra nếu không còn thẻ kitting nào có số lượng lớn hơn 0, thoát khỏi vòng lặp
        if (storageCards.sumBy((e) => e.quantity) == 0) {
          break;
        }
      }

      return _kittingRepository.createKittingCard(
        kittingCardRequests: kittingCardRequests,
        material: state.scanningItem?.material,
        isPreview: isPreview,
        isSub: state.kittingFilter.isSub,
      );
    });
  }

  Future<void> confirmCreateKittingCard({
    required List<KittingDetail> kittingDetails,
    required PrinterDevice printerDevice,
  }) {
    return launch(() async {
      final printer = getIt<Printer>();
      await printer.connect(printerDevice);

      final kittingCards =
          await createKittingCard(kittingDetails: kittingDetails);

      await printer.multiPrint(
        printerDevice,
        kittingCards.map((e) => e.command).toList(),
      );
    });
  }

  Future<List<KittingCard>> getKittingCardByKittingDetail(
    KittingDetail kittingDetail,
  ) {
    return launch(() async {
      final id = kittingDetail.id;
      final kittingCards =
          await _kittingRepository.getKittingCardByKittingListDetailId(id: id);
      return kittingCards;
    });
  }

  Future<void> reprintKittingCards(
    List<KittingCard> kittingCards,
    PrinterDevice printerDevice,
  ) {
    return launch(() async {
      logger.d(kittingCards.map((e) => e.barcode).join(' '));
      final printer = getIt<Printer>();
      await printer.connect(printerDevice);
      await printer.multiPrint(
        printerDevice,
        kittingCards.map((e) => e.command).toList(),
      );
    });
  }

  int get pickedItem => state.kittingDetails
      .where((element) => element.pickedQuantity == element.quantity)
      .length;

  int get totalItem => state.kittingDetails.length;

  List<KittingDetail> getKittingDetailFilter() {
    var kittingDetails = state.kittingDetails;

    var a = state.scanningItem;

    if (state.scanningItem != null) {
      kittingDetails = kittingDetails
          .where(
            (e) =>
                e.material == state.scanningItem?.material &&
                (e.locationName == state.scanningLocation ||
                    state.scanningLocation == null) &&
                e.pickedQuantity < e.quantity,
          )
          .toList();
    }

    return kittingDetails;
  }

  int get pickedQuantity {
    final kittingDetails = getKittingDetailFilter();
    return state.kittingBoxScanned.map((e) => e.quantity).sum +
        kittingDetails.map((e) => e.pickedQuantity).sum.toInt();
  }

  int get totalQuantity {
    var selectedKittingDetails = state.selectedKittingDetails
        .map(
          (id) =>
              state.kittingDetails.firstWhere((element) => element.id == id),
        )
        .toList();
    selectedKittingDetails = selectedKittingDetails.isNotEmpty
        ? selectedKittingDetails
        : getKittingDetailFilter();
    return selectedKittingDetails.sumBy((e) => e.quantity.toInt());
  }

  void clearData() {
    emit(
      state.copyWith(
        scanningItem: null,
        kittingBoxScanned: [],
        scanningLocation: null,
        receivingCardInLocation: null,
      ),
    );
  }
}
