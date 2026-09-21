import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:smart_warehouse/shared/resources/locale_keys.dart';

class ErrorEntity implements Exception {
  ErrorEntity({required this.message});

  final String message;

  @override
  String toString() {
    return '$runtimeType: $message\n';
  }
}

class UnknownError extends ErrorEntity {
  UnknownError() : super(message: LocaleKeys.error_something_error.tr());
}

class NullPointerErrorEntity extends ErrorEntity {
  NullPointerErrorEntity()
      : super(message: LocaleKeys.error_field_cannot_nullable.tr());
}

class ValidationError extends ErrorEntity {
  ValidationError({required this.type, String? message}) : super(message: message ?? type.toString());

  final ValidationErrorType type;
}

enum ValidationErrorType {
  uidInvalid,
  draftReceivingCard(true),
  barcodeInvalid,
  barcodeScanned,
  barcodeNotEnough(true),
  barcodeExisted(true),
  barcodeNotExistedDA(true),
  barcodeNotGR(true),
  barcodeHaveManyDASame(true),
  barcodeHaveManyPlantSame(true),
  barcodeNotSame(true),
  barcodeNotSupport(true),
  barcodeNotTypeScanByLot(true),
  daInvoiceNotExist(true),
  daInvoiceGR(true),
  materialNotExistInDAInvoice(true),
  exceedPO(true),
  receivingCardNotInputLocation,
  receivingCardMoreQuantity(true),
  receivingCardNull(true),
  receivingCardNotExist(true),
  firstLotNotExist(true),
  receivingCardNotStored(true),
  openReceivingCardError(true),
  scanPalletRequired(true),
  receivingCardInvalid,
  receivingCardScanned,
  receivingCardExistInPallet(true),
  inputMoreQuantity(true),
  boxIsRequired(true),
  connectPrinterError(true),
  printError(true),
  bluetoothNotAvailable(true),
  macAddressInvalid(true),
  palletInvalid,
  palletSame,
  canNotEmpty,
  importReCardOpenMap,
  reCardNullTypeFrequency,
  importSameTypeFrequency,
  doNotHaveData,
  locationSame,
  kittingListNotExist(true),
  kittingCardInvalid(true),
  soMuchPartCard(true),
  receivingCardExistStorage,
  kittingCardNoBelongKittingList(true),
  kittingListScanned,
  kittingWrongPosition(true),
  //Tuấn Anh thêm
  RequirePosition(true),
  //
  kittingWrongPositionLot(true),
  firstLotRequired(true),
  stockInValid,
  trolleySame,
  partCardNotExist,
  materialEmpty,
  qtyOnBarcodeNotEnough,
  plsScanPartCard,
  plsInputSlocQty,
  reCardNullCate,
  noDataRevert,
  rcNotFinishedQC,
  trolleyInvalid,
  cardNotStoraged,
  locationStoreIsNotValid,
  kittingListNotEnough,
  kittingListEnough(true),
  scanBarcodeForGetLocation,
  doNotHaveVendorInfo,
  notEnoughRcScanned,
  materialNotInKittingList(true),
  lineNotSame,
  plsScanLine,
  boxCardScanned,
  numberBoxNotContain,
  isNotFirstLot,
  wareHouseCardInvalid,
  outTempRequired,
  dataInvalid,
  noDataForKitting,
  materialNotEnoughKittingCard(true),
  kittingCardIsScanned,
  materialNotSame(true),
  slocNotSame(true),
  inTempRequired,
  overDue,
  pleaseScanRcCard,
  pleaseScanRcCardSameLot,
  boxCardNotExistInReceivingCard,
  plsInputPlantCateSloc,
  quantityNeedBiggerThanZero,
  boxNotHaveHistoryBorrow,
  doNotHaveHistory,
  qtyReturnBiggerThanBorrow,
  qtyEnterNeedSmallerCurrentQty,
  boxcardNotExistInQCHistory,
  boxWasReturned,
  receivingCardNotHaveBox,
  BarcodeExistsInServer(true)
  ;

  const ValidationErrorType([this.needConfirm = false]);

  final bool needConfirm;

  @override
  String toString() {
    return switch (this) {
      draftReceivingCard => LocaleKeys.error_draft_receiving_card.tr(),
      materialNotExistInDAInvoice =>
        LocaleKeys.error_material_not_exist_in_dainvoice.tr(),
      barcodeInvalid => LocaleKeys.error_part_card_invalid.tr(),
      barcodeScanned => LocaleKeys.error_part_card_scanned.tr(),
      barcodeNotEnough => 'Barcode đã được lấy hết hàng',
      barcodeExisted => LocaleKeys.error_part_card_existed.tr(),
      barcodeNotExistedDA => LocaleKeys.error_barcode_not_existed_da.tr(),
      uidInvalid => LocaleKeys.error_id_invalid.tr(),
      palletInvalid => LocaleKeys.error_pallet_invalid.tr(),
      palletSame => LocaleKeys.error_input_pallet_is_not_same.tr(),
      canNotEmpty => LocaleKeys.error_please_fill_all_data.tr(),
      barcodeHaveManyDASame => LocaleKeys.error_part_card_not_have_da.tr(),
      barcodeHaveManyPlantSame => 'Mã này có nhiều Plant',
      barcodeNotSupport => 'Barcode chưa được hỗ trợ tính năng này',
      barcodeNotGR => 'Barcode chưa được Good Receipt',
      barcodeNotSame => LocaleKeys.error_scan_another_material_item.tr(),
      barcodeNotTypeScanByLot =>
        LocaleKeys.error_barcode_not_type_scan_by_lot.tr(),
      daInvoiceNotExist => 'DA/Invoice không tồn tại',
      daInvoiceGR => 'DA/Invoice đã được Good Receipt',
      receivingCardMoreQuantity =>
        LocaleKeys.error_scanned_quantity_exceed_the_number_of_plans.tr(),
      inputMoreQuantity => LocaleKeys.error_input_more_quantity.tr(),
      scanPalletRequired => 'Vui lòng quét pallet trước',
      receivingCardNull => LocaleKeys.error_please_scan_part_card.tr(),
      receivingCardNotExist => LocaleKeys.error_receiving_card_not_exist.tr(),
      firstLotNotExist => 'Không tồn tại Receiving Card trong kho',
      receivingCardNotStored => 'Receiving Card chưa được lưu kho',
      receivingCardNotInputLocation =>
        'Receiving Card chưa được input location',
      receivingCardExistInPallet => 'Receiving Card đã tồn tại trong pallet',
      connectPrinterError => LocaleKeys.error_cannot_connect_with_printer.tr(),
      printError => LocaleKeys.error_print_error.tr(),
      bluetoothNotAvailable => LocaleKeys.error_bluetooth_not_available.tr(),
      macAddressInvalid => LocaleKeys.error_this_is_not_mac_address.tr(),
      openReceivingCardError => LocaleKeys.error_open_receiving_card_error.tr(),
      receivingCardInvalid => LocaleKeys.error_receiving_card_invalid.tr(),
      receivingCardScanned => LocaleKeys.error_receiving_card_scanned.tr(),
      boxIsRequired => 'Bạn chưa nhập số hộp',
      exceedPO => LocaleKeys.error_exceed_po.tr(),
      importReCardOpenMap =>
        LocaleKeys.error_please_scan_recard_to_use_this.tr(),
      reCardNullTypeFrequency =>
        LocaleKeys.error_not_enough_type_or_frequency_call_mcs.tr(),
      importSameTypeFrequency => 'Hãy quét cùng loại Receiving Card',
      doNotHaveData => LocaleKeys.error_do_not_have_data.tr(),
      locationSame => LocaleKeys.error_location_has_different.tr(),
      kittingListNotExist => 'Kitting List Không tồn tại',
      materialNotInKittingList => 'Mã này không có trong danh sách cần kitting',
      kittingCardInvalid => 'Kitting card không tồn tại',
      soMuchPartCard => 'Barcode bị trùng lặp, vui lòng quét Receiving Card!',
      receivingCardExistStorage => 'Receiving Card đã được lưu kho',
      kittingWrongPosition =>
        'Bạn đang quét vị trí khác so với các thẻ hiện tại',

      RequirePosition => 'Hãy Scan Block đang Kitting trước khi Scan Box',
      kittingWrongPositionLot => 'Bạn đã quét sai vị trí cần kitting',
      firstLotRequired =>
        'Bạn đang quét thẻ không phải First Lot, bạn có muốn tiếp tục?',
      kittingCardNoBelongKittingList =>
        'Không tồn tại kitting card này trong Kitting List!',
      kittingListScanned => 'Kitting List đã được quét',
      trolleySame => 'Trolley không được trùng',
      stockInValid => 'StockCard không đúng định dạng',
      partCardNotExist => 'Barcode Không Tồn Tại!',
      materialEmpty => 'Material Trống',
      qtyOnBarcodeNotEnough =>
        'Số lượng tại vị trí vẫn còn, vui lòng quét thêm barcode!',
      plsScanPartCard => 'Vui long quet Part Card de kitting.',
      plsInputSlocQty => 'Vui lòng chọn Sloc và nhập quantity',
      reCardNullCate => 'Receiving Card thiếu Category, liên hệ MCS',
      noDataRevert => 'Không có data để revert',
      rcNotFinishedQC => 'Receiving Card chưa hoàn thành QC Check',
      trolleyInvalid => 'Trolley Barcode không đúng định dạng',
      cardNotStoraged => 'Card chưa được lưu kho',
      locationStoreIsNotValid =>
        'Vị trí lưu kho không đúng, vui lòng kiểm tra lại',
      kittingListNotEnough => 'Kitting List còn thiếu hàng',
      kittingListEnough => 'Đã quét đủ vui lòng tạo Kitting Card',
      scanBarcodeForGetLocation => 'Không có dữ liệu!',
      doNotHaveVendorInfo => 'Không có dữ liệu của Vendor',
      notEnoughRcScanned => 'Chưa quét đủ Receiving Card',
      boxCardScanned => 'BoxCard đã được quyét',
      lineNotSame => 'Line không trùng khớp',
      plsScanLine => 'Vui lòng quét line',
      numberBoxNotContain => 'Boxcard thêm đang không đúng số lượng nhập',
      isNotFirstLot => 'Card đã quét không phải last lot',
      wareHouseCardInvalid => 'Thẻ kho không đúng định dạng',
      outTempRequired => 'ReceivingCard cần out khu đợi',
      dataInvalid => 'Dữ liệu không đúng định dạng',
      noDataForKitting => 'Không có dữ liệu Kitting',
      materialNotEnoughKittingCard => 'Chưa quét đủ Kitting Card!',
      kittingCardIsScanned => 'Kitting Card đã được quét!',
      materialNotSame =>
        'Material không giống nhau, vui lòng chọn material giống nhau',
      slocNotSame => 'Sloc không giống nhau, vui lòng chọn sloc giống nhau',
      inTempRequired => 'ReceivingCard cần lưu vào khu vực đợi trước!',
      overDue => 'Barcode đã quá hạn, vui lòng quét barcode khác!',
      pleaseScanRcCard => 'Boxcard không có dữ liệu, hãy quét ReceivingCard!',
      pleaseScanRcCardSameLot => 'Hãy Balance Receiving Card cùng lô!',
      boxCardNotExistInReceivingCard =>
        'Boxcard không tồn tại trong danh Receiving Card đã quyét!',
      plsInputPlantCateSloc => 'Hãy chọn Plant, Cate và Sloc!',
      quantityNeedBiggerThanZero => 'Qty phải lớn hơn 0!',
      boxNotHaveHistoryBorrow => 'Không tìm được lịch sử mượn của Box này',
      doNotHaveHistory =>
        'Không có lịch sử mượn của IQC theo Material, Plant, Sloc!',
      qtyReturnBiggerThanBorrow =>
        'Qty trả về đang lớn hơn qty IQC đã mượn của mã này!',
      qtyEnterNeedSmallerCurrentQty =>
        'Qty nhập vào cần nhỏ hơn qty thực tế của ReceivingCard',
      boxcardNotExistInQCHistory =>
        'Boxcard không tồn tại trong lịch sử mượn của IQC',
      boxWasReturned => 'Boxcard đã được IQC trả rồi',
      receivingCardNotHaveBox => 'ReceivingCard Không có box',
    // Tuấn Anh thêm
        BarcodeExistsInServer => 'Barcode Box đã tồn tại trên Database'
    };
  }
}

class NewVersionError extends ErrorEntity {
  NewVersionError(
      {super.message =
          'Phiên bản mới vừa mới cập nhật\n Bạn có muốn cập nhật'});
}

class ServerError extends ErrorEntity {
  ServerError({required super.message, this.type});

  factory ServerError.fromDioException(DioException error) {
    if (error.type == DioExceptionType.unknown) {
      final status = error.response?.data['status'].toString().toInt();
      final type = ServerErrorType.fromCode(status);
      return ServerError(
        message: type.toString(),
        type: type,
      );
    }

    final message = switch (error.type) {
      DioExceptionType.cancel =>
        LocaleKeys.error_request_to_api_server_was_cancelled.tr(),
      DioExceptionType.connectionTimeout =>
        LocaleKeys.error_connection_timeout_with_api_server.tr(),
      DioExceptionType.receiveTimeout =>
        LocaleKeys.error_receive_timeout_in_connection_with_api_server.tr(),
      DioExceptionType.sendTimeout =>
        LocaleKeys.error_send_timeout_in_connection_with_api_server.tr(),
      DioExceptionType.connectionError =>
        LocaleKeys.error_connection_error_in_connection_with_api_server.tr(),
      DioExceptionType.badResponse =>
        error.response?.data?['detail'].toString(),
      _ => error.message,
    };

    return ServerError(
      message: message ?? LocaleKeys.error_internal_server_error.tr(),
    );
  }

  final ServerErrorType? type;
}

enum ServerErrorType {
  cannotFindDAInv(7878),
  rePrintReceivingCard(69),
  supplyNotEnough(14),
  isNotFirstLot(16),
  unknown(0);

  const ServerErrorType(this.code);

  final int code;

  static ServerErrorType fromCode(int? code) {
    return ServerErrorType.values
        .firstWhere((element) => element.code == code, orElse: () => unknown);
  }

  @override
  String toString() {
    return switch (this) {
      unknown => LocaleKeys.error_internal_server_error.tr(),
      cannotFindDAInv => LocaleKeys.error_choose_da_inv.tr(),
      rePrintReceivingCard => '',
      supplyNotEnough => '',
      isNotFirstLot => '',
    };
  }
}
