// lib/l10n/app_lang.dart
//
// Quan ly ngon ngu (Tieng Viet / English) don gian, khong can thu vien ngoai.
// - LangController.current: ngon ngu hien tai (ValueNotifier => UI tu cap nhat)
// - LangController.load(): doc ngon ngu da luu (SharedPreferences)
// - LangController.set(lang): doi ngon ngu va luu lai
// - tr('key') / tr('key', {'n': '3'}): lay chuoi theo ngon ngu hien tai

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppLang { vi, en }

class LangController {
  LangController._();

  static const String _prefKey = 'app_lang';
  static final ValueNotifier<AppLang> current = ValueNotifier(AppLang.vi);

  static Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    current.value = prefs.getString(_prefKey) == 'en' ? AppLang.en : AppLang.vi;
  }

  static Future<void> set(AppLang lang) async {
    current.value = lang;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefKey, lang.name);
  }

  static bool get isVi => current.value == AppLang.vi;
}

/// Lay chuoi theo ngon ngu hien tai. Tham so dang {ten} se duoc thay the.
String tr(String key, [Map<String, String>? params]) {
  final entry = _strings[key];
  var text = entry?[LangController.current.value] ?? entry?[AppLang.vi] ?? key;
  params?.forEach((k, v) => text = text.replaceAll('{$k}', v));
  return text;
}

const Map<String, Map<AppLang, String>> _strings = {
  // ---------- Chung ----------
  'language': {AppLang.vi: 'Ngôn ngữ', AppLang.en: 'Language'},
  'loading': {AppLang.vi: 'Đang tải...', AppLang.en: 'Loading...'},
  'notify': {AppLang.vi: 'Thông báo', AppLang.en: 'Notify'},
  'yes': {AppLang.vi: 'Có', AppLang.en: 'Yes'},
  'no': {AppLang.vi: 'Không', AppLang.en: 'No'},
  'error': {AppLang.vi: 'Lỗi: {e}', AppLang.en: 'Error: {e}'},

  // ---------- Man hinh RecheckInspection ----------
  'insertRecheckOK': {AppLang.vi: 'Thêm Recheck OK', AppLang.en: 'Insert recheck OK'},
  'recheckTitle': {
    AppLang.vi: 'Kiểm tra lại IQC',
    AppLang.en: 'Recheck Inspection IQC',
  },
  'insertRecheckNG': {
    AppLang.vi: 'Chèn recheck NG',
    AppLang.en: 'Insert recheck NG',
  },
  'slbox': {
    AppLang.vi: 'SL box',
    AppLang.en: 'slbox',
  },
  'msgNoRecheckQty': {
    AppLang.vi: 'Bạn chưa nhập số lượng Recheck!',
    AppLang.en: 'Please enter the recheck quantity!',
  },
  'msgNotJudgedYet': {
    AppLang.vi: 'Lô hàng chưa được đánh giá OK/NG lần nào!',
    AppLang.en: 'This lot has not been judged OK/NG yet!',
  },
  'msgNotNGYet': {
    AppLang.vi: 'Lô hàng này chưa được kiểm NG!',
    AppLang.en: 'This lot has not been inspected as NG yet!',
  },
  'msgNGSuccess': {
    AppLang.vi: 'Đánh giá hàng kho NG thành công!',
    AppLang.en: 'NG stock judgment completed successfully!',
  },
  'msgNotCheckedYet': {
    AppLang.vi: 'Lô hàng này chưa được check lần nào!',
    AppLang.en: 'This lot has not been checked yet!',
  },
  'msgRecheckReprint': {
    AppLang.vi: 'Hàng này là phiếu recheck in lại!\nBạn có muốn kiểm tiếp tục?',
    AppLang.en: 'This is a reprinted recheck slip!\nDo you want to continue inspection?',
  },


  // ---------- end RecheckInspection ----------

  // ---------- Man hinh IQC ----------
  'iqcTitle': {AppLang.vi: 'Kiểm tra IQC', AppLang.en: 'Inspection IQC'},
  'checkSample': {AppLang.vi: 'Kiểm tra mẫu', AppLang.en: 'Check Sample'},
  'checkRohs': {AppLang.vi: 'Kiểm tra RoHS', AppLang.en: 'Check RoHS'},
  'scanBoxes': {AppLang.vi: 'quét nhiều box', AppLang.en: 'scan boxes'},
  'scanReceivingCard': {
    AppLang.vi: 'Quét Receiving Card',
    AppLang.en: 'Scan Receiving Card'
  },
  'scanBox': {AppLang.vi: 'Quét box', AppLang.en: 'Scan box'},
  'invoice': {AppLang.vi: 'Hóa đơn', AppLang.en: 'Invoice'},
  'date': {AppLang.vi: 'Ngày', AppLang.en: 'Date'},
  'position': {AppLang.vi: 'Vị trí', AppLang.en: 'Position'},
  'ctrlKey': {AppLang.vi: 'CtrlKey', AppLang.en: 'CtrlKey'},
  'ctrlT': {AppLang.vi: 'CtrlT', AppLang.en: 'CtrlT'},
  'qty': {AppLang.vi: 'SL', AppLang.en: 'Qty'},
  'codeDate': {AppLang.vi: 'Code date', AppLang.en: 'Code date'},
  'qtyInput': {AppLang.vi: 'SL nhập', AppLang.en: 'QtyInput'},
  'remark': {AppLang.vi: 'Ghi chú', AppLang.en: 'Remark'},
  'qtyNG': {AppLang.vi: 'SL NG', AppLang.en: 'QtyNG'},
  'qtyScrap': {AppLang.vi: 'SL hủy', AppLang.en: 'Q.Scrap'},
  'userId': {AppLang.vi: 'Mã NV', AppLang.en: 'UserID'},
  'status': {AppLang.vi: 'Trạng thái', AppLang.en: 'Status'},
  'judgmentOK': {AppLang.vi: 'Đánh giá OK', AppLang.en: 'Judgment OK'},
  'judgmentNG': {AppLang.vi: 'Đánh giá NG', AppLang.en: 'Judgment NG'},
  'submit': {AppLang.vi: 'Lưu', AppLang.en: 'Submit'},
  'reset': {AppLang.vi: 'Làm mới', AppLang.en: 'Reset'},
  'delete': {AppLang.vi: 'Xóa', AppLang.en: 'Del'},
  'exit': {AppLang.vi: 'Thoát', AppLang.en: 'Exit'},

  // ---------- Thong bao ----------
  'msgNoCheckType': {
    AppLang.vi: 'Bạn chưa chọn kiểu loại hình kiểm tra',
    AppLang.en: 'Please select an inspection type'
  },
  'msgCheckBoxCard': {
    AppLang.vi: 'Kiểm tra lại thông tin box card {n}!',
    AppLang.en: 'Please check the box card information ({n})!'
  },
  'msgQcUserEmpty': {
    AppLang.vi: 'Người kiểm tra QC không được trống!',
    AppLang.en: 'QC inspector cannot be empty!'
  },
  'msgLotQtyZero': {
    AppLang.vi: 'Số lượng lô = 0, Bạn check lại thông tin!',
    AppLang.en: 'Lot quantity = 0, please check the information!'
  },
  'msgMustScanBox': {
    AppLang.vi: 'Hàng này bắt buộc phải scan box!',
    AppLang.en: 'This item requires scanning the box!'
  },
  'msgCheckGR': {
    AppLang.vi: 'NG, Check GR, Liên hệ IT!',
    AppLang.en: 'NG, GR check failed, please contact IT!'
  },
  'msgNotInStock': {
    AppLang.vi: 'Số lượng này chưa nhập kho, Chờ MCS hoàn thành!',
    AppLang.en: 'This quantity is not in stock yet, wait for MCS to finish!'
  },
  'msgPickupDone': {
    AppLang.vi: 'Hoàn thành trạng thái lấy hàng!',
    AppLang.en: 'Pick-up status completed!'
  },
  'msgNoPermission': {
    AppLang.vi: 'Bạn không có quyền sửa kết quả kiểm tra!',
    AppLang.en: 'You do not have permission to edit the inspection result!'
  },
  'msgSystemNG': {
    AppLang.vi: 'NG, Hệ thống, liên hệ IT!',
    AppLang.en: 'NG, system error, please contact IT!'
  },
  'msgCheckSuccess': {
    AppLang.vi: 'Kiểm tra hàng thành công!',
    AppLang.en: 'Inspection completed successfully!'
  },
  'msgCheckSuccessNoMCS': {
    AppLang.vi: 'Kiểm tra hàng thành công! Chưa trừ kho MCS',
    AppLang.en: 'Inspection completed! MCS stock not deducted yet'
  },
  'msgConfirmNGAllLot': {
    AppLang.vi: 'Bạn xác nhận trường hợp này có phải đánh giá All LOT không?',
    AppLang.en: 'Do you confirm this case is judged NG for the whole LOT?'
  },
  'msgRevertSuccess': {
    AppLang.vi: 'Revert hàng thành công! Bạn phải đánh giá lại!',
    AppLang.en: 'Revert successful! Please judge again!'
  },
  'msgCheckInfoNG': {
    AppLang.vi: 'NG! Kiểm tra lại thông tin',
    AppLang.en: 'NG! Please check the information'
  },
  'msgDeleteSuccess': {
    AppLang.vi: 'Hủy hàng thành công!',
    AppLang.en: 'Item cancelled successfully!'
  },
  'msgAlreadyJudged': {
    AppLang.vi: 'Hàng đã được đánh giá, không thể hủy!',
    AppLang.en: 'Item has already been judged, cannot cancel!'
  },
  'msgAlreadyDeleted': {
    AppLang.vi: 'Lô hàng đã được hủy, kiểm tra lại!',
    AppLang.en: 'This lot has already been cancelled, please check!'
  },
  'msgNotInFreeLocation': {
    AppLang.vi:
    'Hàng này không qua Map freelocation! \n Liên hệ MCS để fix vị trí?',
    AppLang.en:
    'This item was not mapped to a free location! \n Contact MCS to fix the location.'
  },
  'msgNotInSystem': {
    AppLang.vi: 'Hàng không có trong hệ thống!, liên hệ IT!',
    AppLang.en: 'Item not found in the system! Please contact IT!'
  },
  'msgOver1Year': {
    AppLang.vi:
    'Bạn đang kiểm tra hàng quá hạn 1 năm? \n Bạn phải nhập Số lượng vào!',
    AppLang.en:
    'Are you inspecting an item older than 1 year? \n You must enter the quantity!'
  },
  'msgRecheck': {
    AppLang.vi:
    'Hàng này là hàng recheck, Nếu kiểm tra không? \n Bạn phải nhập Số lượng vào!',
    AppLang.en:
    'This is a recheck item. Do you want to inspect it? \n You must enter the quantity!'
  },
  'msgNonInspection': {
    AppLang.vi:
    'Hàng này không qua Map freelocation! \n Bạn có muốn kiểm tra không?',
    AppLang.en:
    'This item was not mapped to a free location! \n Do you want to inspect it?'
  },
  'msgCheckInfoNG2': {
    AppLang.vi: 'NG, Kiểm tra lại thông tin!',
    AppLang.en: 'NG, please check the information!'
  },
  'msgNoLotQty': {
    AppLang.vi: 'Bạn chưa nhập số lượng lô!',
    AppLang.en: 'Please enter the lot quantity!'
  },
  'msgQtyOverLot': {
    AppLang.vi: 'Số lượng nhập vào lớn hơn số lượng lot ban đầu!',
    AppLang.en: 'The entered quantity exceeds the original lot quantity!'
  },
};
