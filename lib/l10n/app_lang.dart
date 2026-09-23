// lib/l10n/app_lang.dart
//
// Quan ly ngon ngu (Tieng Viet / English) don gian, khong can thu vien ngoai.
// - LangController.current: ngon ngu hien tai (ValueNotifier => UI tu cap nhat)
// - LangController.load(): doc ngon ngu da luu (SharedPreferences)
// - LangController.set(lang): doi ngon ngu va luu lai
// - tr('key') / tr('key', {'n': '3'}): lay chuoi theo ngon ngu hien tai

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppLang { vi, en, ja }  //them giao dien tieng nhat

class LangController {
  LangController._();

  static const String _prefKey = 'app_lang';
  static final ValueNotifier<AppLang> current = ValueNotifier(AppLang.vi);

  static Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_prefKey);
    current.value = switch (saved) {
      'en' => AppLang.en,
      'ja' => AppLang.ja,
      _ => AppLang.vi, // mặc định
    };
  }

  static Future<void> set(AppLang lang) async {
    current.value = lang;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefKey, lang.name);
  }

  static bool get isVi => current.value == AppLang.vi;
  static bool get isEn => current.value == AppLang.en;
  static bool get isJa => current.value == AppLang.ja;
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
  'language': {
    AppLang.vi: 'Ngôn ngữ',
    AppLang.en: 'Language',
    AppLang.ja: '言語',
  },
  'loading': {
    AppLang.vi: 'Đang tải...',
    AppLang.en: 'Loading...',
    AppLang.ja: '読み込み中...',
  },
  'notify': {
    AppLang.vi: 'Thông báo',
    AppLang.en: 'Notify',
    AppLang.ja: '通知',
  },
  'yes': {
    AppLang.vi: 'Có',
    AppLang.en: 'Yes',
    AppLang.ja: 'はい',
  },
  'no': {
    AppLang.vi: 'Không',
    AppLang.en: 'No',
    AppLang.ja: 'いいえ',
  },
  'error': {
    AppLang.vi: 'Lỗi: {e}',
    AppLang.en: 'Error: {e}',
    AppLang.ja: 'エラー: {e}',
  },

  // ---------- Man hinh RecheckInspection ----------
  'insertRecheckOK': {
    AppLang.vi: 'Thêm Recheck OK',
    AppLang.en: 'Insert recheck OK',
    AppLang.ja: '再検査OKを追加',
  },
  'recheckTitle': {
    AppLang.vi: 'Kiểm tra lại IQC',
    AppLang.en: 'Recheck Inspection IQC',
    AppLang.ja: 'IQC再検査',
  },
  'insertRecheckNG': {
    AppLang.vi: 'Chèn recheck NG',
    AppLang.en: 'Insert recheck NG',
    AppLang.ja: '再検査NGを挿入',
  },
  'slbox': {
    AppLang.vi: 'SL box',
    AppLang.en: 'slbox',
    AppLang.ja: 'ボックス数',
  },
  'msgNoRecheckQty': {
    AppLang.vi: 'Bạn chưa nhập số lượng Recheck!',
    AppLang.en: 'Please enter the recheck quantity!',
    AppLang.ja: '再検査数量を入力してください！',
  },
  'msgNotJudgedYet': {
    AppLang.vi: 'Lô hàng chưa được đánh giá OK/NG lần nào!',
    AppLang.en: 'This lot has not been judged OK/NG yet!',
    AppLang.ja: 'このロットはまだOK/NG判定されていません！',
  },
  'msgNotNGYet': {
    AppLang.vi: 'Lô hàng này chưa được kiểm NG!',
    AppLang.en: 'This lot has not been inspected as NG yet!',
    AppLang.ja: 'このロットはまだNG検査されていません！',
  },
  'msgNGSuccess': {
    AppLang.vi: 'Đánh giá hàng kho NG thành công!',
    AppLang.en: 'NG stock judgment completed successfully!',
    AppLang.ja: '在庫NG判定が正常に完了しました！',
  },
  'msgNotCheckedYet': {
    AppLang.vi: 'Lô hàng này chưa được check lần nào!',
    AppLang.en: 'This lot has not been checked yet!',
    AppLang.ja: 'このロットはまだ検査されていません！',
  },
  'msgRecheckReprint': {
    AppLang.vi: 'Hàng này là phiếu recheck in lại!\nBạn có muốn kiểm tiếp tục?',
    AppLang.en: 'This is a reprinted recheck slip!\nDo you want to continue inspection?',
    AppLang.ja: 'これは再印刷された再検査票です！\n検査を続けますか？',
  },

  // ---------- end RecheckInspection ----------

  // ---------- Man hinh IQC ----------
  'iqcTitle': {
    AppLang.vi: 'Kiểm tra IQC',
    AppLang.en: 'Inspection IQC',
    AppLang.ja: 'IQC検査',
  },
  'checkSample': {
    AppLang.vi: 'Kiểm tra mẫu',
    AppLang.en: 'Check Sample',
    AppLang.ja: 'サンプル検査',
  },
  'checkRohs': {
    AppLang.vi: 'Kiểm tra RoHS',
    AppLang.en: 'Check RoHS',
    AppLang.ja: 'RoHS検査',
  },
  'scanBoxes': {
    AppLang.vi: 'quét nhiều box',
    AppLang.en: 'scan boxes',
    AppLang.ja: '複数ボックスをスキャン',
  },
  'scanReceivingCard': {
    AppLang.vi: 'Quét Receiving Card',
    AppLang.en: 'Scan Receiving Card',
    AppLang.ja: '受入カードをスキャン',
  },
  'scanBox': {
    AppLang.vi: 'Quét box',
    AppLang.en: 'Scan box',
    AppLang.ja: 'ボックスをスキャン',
  },
  'invoice': {
    AppLang.vi: 'Hóa đơn',
    AppLang.en: 'Invoice',
    AppLang.ja: '請求書',
  },
  'date': {
    AppLang.vi: 'Ngày',
    AppLang.en: 'Date',
    AppLang.ja: '日付',
  },
  'position': {
    AppLang.vi: 'Vị trí',
    AppLang.en: 'Position',
    AppLang.ja: '位置',
  },
  'ctrlKey': {
    AppLang.vi: 'CtrlKey',
    AppLang.en: 'CtrlKey',
    AppLang.ja: 'CtrlKey',
  },
  'ctrlT': {
    AppLang.vi: 'CtrlT',
    AppLang.en: 'CtrlT',
    AppLang.ja: 'CtrlT',
  },
  'qty': {
    AppLang.vi: 'SL',
    AppLang.en: 'Qty',
    AppLang.ja: '数量',
  },
  'codeDate': {
    AppLang.vi: 'Code date',
    AppLang.en: 'Code date',
    AppLang.ja: 'コード日付',
  },
  'qtyInput': {
    AppLang.vi: 'SL nhập',
    AppLang.en: 'QtyInput',
    AppLang.ja: '入力数量',
  },
  'remark': {
    AppLang.vi: 'Ghi chú',
    AppLang.en: 'Remark',
    AppLang.ja: '備考',
  },
  'qtyNG': {
    AppLang.vi: 'SL NG',
    AppLang.en: 'QtyNG',
    AppLang.ja: 'NG数量',
  },
  'qtyScrap': {
    AppLang.vi: 'SL hủy',
    AppLang.en: 'Q.Scrap',
    AppLang.ja: '廃棄数量',
  },
  'userId': {
    AppLang.vi: 'Mã NV',
    AppLang.en: 'UserID',
    AppLang.ja: '社員番号',
  },
  'status': {
    AppLang.vi: 'Trạng thái',
    AppLang.en: 'Status',
    AppLang.ja: 'ステータス',
  },
  'judgmentOK': {
    AppLang.vi: 'Đánh giá OK',
    AppLang.en: 'Judgment OK',
    AppLang.ja: '判定OK',
  },
  'judgmentNG': {
    AppLang.vi: 'Đánh giá NG',
    AppLang.en: 'Judgment NG',
    AppLang.ja: '判定NG',
  },
  'submit': {
    AppLang.vi: 'Lưu',
    AppLang.en: 'Submit',
    AppLang.ja: '保存',
  },
  'reset': {
    AppLang.vi: 'Làm mới',
    AppLang.en: 'Reset',
    AppLang.ja: 'リセット',
  },
  'delete': {
    AppLang.vi: 'Xóa',
    AppLang.en: 'Del',
    AppLang.ja: '削除',
  },
  'exit': {
    AppLang.vi: 'Thoát',
    AppLang.en: 'Exit',
    AppLang.ja: '終了',
  },

  // ---------- Thong bao ----------
  'msgNoCheckType': {
    AppLang.vi: 'Bạn chưa chọn kiểu loại hình kiểm tra',
    AppLang.en: 'Please select an inspection type',
    AppLang.ja: '検査タイプを選択してください',
  },
  'msgCheckBoxCard': {
    AppLang.vi: 'Kiểm tra lại thông tin box card {n}!',
    AppLang.en: 'Please check the box card information ({n})!',
    AppLang.ja: 'ボックスカード情報を確認してください ({n})！',
  },
  'msgQcUserEmpty': {
    AppLang.vi: 'Người kiểm tra QC không được trống!',
    AppLang.en: 'QC inspector cannot be empty!',
    AppLang.ja: 'QC検査者を入力してください！',
  },
  'msgLotQtyZero': {
    AppLang.vi: 'Số lượng lô = 0, Bạn check lại thông tin!',
    AppLang.en: 'Lot quantity = 0, please check the information!',
    AppLang.ja: 'ロット数量が0です。情報を確認してください！',
  },
  'msgMustScanBox': {
    AppLang.vi: 'Hàng này bắt buộc phải scan box!',
    AppLang.en: 'This item requires scanning the box!',
    AppLang.ja: 'この品目はボックスのスキャンが必須です！',
  },
  'msgCheckGR': {
    AppLang.vi: 'NG, Check GR, Liên hệ IT!',
    AppLang.en: 'NG, GR check failed, please contact IT!',
    AppLang.ja: 'NG、GRチェック失敗、ITに連絡してください！',
  },
  'msgNotInStock': {
    AppLang.vi: 'Số lượng này chưa nhập kho, Chờ MCS hoàn thành!',
    AppLang.en: 'This quantity is not in stock yet, wait for MCS to finish!',
    AppLang.ja: 'この数量はまだ入庫されていません。MCSの完了を待ってください！',
  },
  'msgPickupDone': {
    AppLang.vi: 'Hoàn thành trạng thái lấy hàng!',
    AppLang.en: 'Pick-up status completed!',
    AppLang.ja: 'ピックアップステータスが完了しました！',
  },
  'msgNoPermission': {
    AppLang.vi: 'Bạn không có quyền sửa kết quả kiểm tra!',
    AppLang.en: 'You do not have permission to edit the inspection result!',
    AppLang.ja: '検査結果を編集する権限がありません！',
  },
  'msgSystemNG': {
    AppLang.vi: 'NG, Hệ thống, liên hệ IT!',
    AppLang.en: 'NG, system error, please contact IT!',
    AppLang.ja: 'NG、システムエラー、ITに連絡してください！',
  },
  'msgCheckSuccess': {
    AppLang.vi: 'Kiểm tra hàng thành công!',
    AppLang.en: 'Inspection completed successfully!',
    AppLang.ja: '検査が正常に完了しました！',
  },
  'msgCheckSuccessNoMCS': {
    AppLang.vi: 'Kiểm tra hàng thành công! Chưa trừ kho MCS',
    AppLang.en: 'Inspection completed! MCS stock not deducted yet',
    AppLang.ja: '検査が完了しました！MCS在庫はまだ減算されていません',
  },
  'msgConfirmNGAllLot': {
    AppLang.vi: 'Bạn xác nhận trường hợp này có phải đánh giá All LOT không?',
    AppLang.en: 'Do you confirm this case is judged NG for the whole LOT?',
    AppLang.ja: 'このケースを全ロットNG判定として確定しますか？',
  },
  'msgRevertSuccess': {
    AppLang.vi: 'Revert hàng thành công! Bạn phải đánh giá lại!',
    AppLang.en: 'Revert successful! Please judge again!',
    AppLang.ja: 'リバートが成功しました！再度判定してください！',
  },
  'msgCheckInfoNG': {
    AppLang.vi: 'NG! Kiểm tra lại thông tin',
    AppLang.en: 'NG! Please check the information',
    AppLang.ja: 'NG！情報を確認してください',
  },
  'msgDeleteSuccess': {
    AppLang.vi: 'Hủy hàng thành công!',
    AppLang.en: 'Item cancelled successfully!',
    AppLang.ja: '品目のキャンセルが成功しました！',
  },
  'msgAlreadyJudged': {
    AppLang.vi: 'Hàng đã được đánh giá, không thể hủy!',
    AppLang.en: 'Item has already been judged, cannot cancel!',
    AppLang.ja: 'すでに判定済みのため、キャンセルできません！',
  },
  'msgAlreadyDeleted': {
    AppLang.vi: 'Lô hàng đã được hủy, kiểm tra lại!',
    AppLang.en: 'This lot has already been cancelled, please check!',
    AppLang.ja: 'このロットはすでにキャンセルされています。確認してください！',
  },
  'msgNotInFreeLocation': {
    AppLang.vi: 'Hàng này không qua Map freelocation! \n Liên hệ MCS để fix vị trí?',
    AppLang.en: 'This item was not mapped to a free location! \n Contact MCS to fix the location.',
    AppLang.ja: 'この品目はフリーロケーションにマッピングされていません！\nMCSに連絡して位置を修正してください。',
  },
  'msgNotInSystem': {
    AppLang.vi: 'Hàng không có trong hệ thống!, liên hệ IT!',
    AppLang.en: 'Item not found in the system! Please contact IT!',
    AppLang.ja: 'システムに品目が見つかりません！ITに連絡してください！',
  },
  'msgOver1Year': {
    AppLang.vi: 'Bạn đang kiểm tra hàng quá hạn 1 năm? \n Bạn phải nhập Số lượng vào!',
    AppLang.en: 'Are you inspecting an item older than 1 year? \n You must enter the quantity!',
    AppLang.ja: '1年以上経過した品目を検査していますか？\n数量を入力してください！',
  },
  'msgRecheck': {
    AppLang.vi: 'Hàng này là hàng recheck, Nếu kiểm tra không? \n Bạn phải nhập Số lượng vào!',
    AppLang.en: 'This is a recheck item. Do you want to inspect it? \n You must enter the quantity!',
    AppLang.ja: 'これは再検査品です。検査しますか？\n数量を入力してください！',
  },
  'msgNonInspection': {
    AppLang.vi: 'Hàng này không qua Map freelocation! \n Bạn có muốn kiểm tra không?',
    AppLang.en: 'This item was not mapped to a free location! \n Do you want to inspect it?',
    AppLang.ja: 'この品目はフリーロケーションにマッピングされていません！\n検査しますか？',
  },
  'msgCheckInfoNG2': {
    AppLang.vi: 'NG, Kiểm tra lại thông tin!',
    AppLang.en: 'NG, please check the information!',
    AppLang.ja: 'NG、情報を確認してください！',
  },
  'msgNoLotQty': {
    AppLang.vi: 'Bạn chưa nhập số lượng lô!',
    AppLang.en: 'Please enter the lot quantity!',
    AppLang.ja: 'ロット数量を入力してください！',
  },
  'msgQtyOverLot': {
    AppLang.vi: 'Số lượng nhập vào lớn hơn số lượng lot ban đầu!',
    AppLang.en: 'The entered quantity exceeds the original lot quantity!',
    AppLang.ja: '入力数量が元のロット数量を超えています！',
  },
};