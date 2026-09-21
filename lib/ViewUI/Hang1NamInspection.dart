import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ControllerAPI/api_IQC.dart';
import '../di/di.dart';
import '../repositories/auth_repository.dart';

class Hang1NamInspection extends StatefulWidget {
  const Hang1NamInspection({super.key});

  @override
  _ExampleWidgetState createState() => _ExampleWidgetState();
}

class _ExampleWidgetState extends State<Hang1NamInspection> {
  String userId = '';

  late DateTime now = DateTime.now();
  late String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(now);

  final txtScan = TextEditingController();
  final txtpartcard = TextEditingController();
  final txtsoluonghuy = TextEditingController(text: '0');
  final txtusersubmit = TextEditingController();
  final txtcodedate = TextEditingController();
  final txtremark = TextEditingController();
  final txtstatus = TextEditingController();
  final txtSLNG = TextEditingController();
  final txtrecheck = TextEditingController();
  final txtbox = TextEditingController();

  final FocusNode scanid = FocusNode();
  final FocusNode partcardid = FocusNode();
  final FocusNode soluonghuyid = FocusNode();
  final FocusNode usersubmitid = FocusNode();
  final FocusNode codateid = FocusNode();
  final FocusNode remarkid = FocusNode();
  final FocusNode statusid = FocusNode();
  final FocusNode slngid = FocusNode();
  final FocusNode recheckid = FocusNode();
  final FocusNode boxid = FocusNode();

  Color _boxColor = Colors.white;

  String lblinvoice = "";
  String lblincomingdate = "";
  String vitri = "";
  String LotQty = "";
  String lbldeliverydate = "";
  String lblplant = "";
  String lbldano = "";
  String lblpono = "";
  String lblvender = "";
  String lblctrlkey = "";
  String lblctrlt = "";
  String lblsloc = "";
  String lbllotdate = "";
  String lblCateQC = "";

  String IDmahang = "";

  String typecheck = 'Sample';
  String group_OK_NG2 = '';

  String codedate_ = "";
  String remark_ = "";
  String soluong_huy_spl_ = "";
  String soluong_huy_rohs_ = "";
  String user_finish_spl_ = "";
  String user_finish_rohs_ = "";
  String ketqua_spl_ = "";
  String ketqua_rohs_ = "";

  String status_check_spl = "";
  String status_check_rohs = "";

  String lblqtyNG = "";
  String Barcodeid = "";

  bool isinsert = false;
  bool isDisabled = false; // trang thai disabled cua checkbox Insert 1Year

  bool checkunit = false; // khong phai hang unit box

  // Co theo doi dialog Loading dang mo hay khong.
  bool _isLoading = false;

  static const String _typerecheck = "Hang1Nam";

  // ==================== HELPERS ====================

  /// Parse so an toan: chuoi rong / sai dinh dang => 0 (khong throw).
  double _toDouble(String? s) => double.tryParse((s ?? '').trim()) ?? 0;

  /// Lay gia tri cot an toan: null / vuot index => ''.
  String _cell(List<dynamic> row, int index) {
    if (index < 0 || index >= row.length) return '';
    final v = row[index];
    return v == null ? '' : v.toString();
  }

  /// Lay dong dau tien cua ket qua API, rong => null.
  List<dynamic>? _firstRow(List<Map<String, dynamic>> dt) =>
      dt.isEmpty ? null : dt[0].values.toList();

  void checkRadio(String value) => setState(() => typecheck = value);

  void checkRadio2(String value) => setState(() => group_OK_NG2 = value);

  Future<void> autogetuser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() async {
      //userId = prefs.getString('username') ?? '';
      userId = await getIt<AuthRepository>().getUserID();
    });
  }

  @override
  void initState() {
    super.initState();
    autogetuser();
    hideKeyboard();
    txtstatus.addListener(_updateColor);
  }

  void _updateColor() {
    if (!mounted) return;
    setState(() {
      if (txtstatus.text == "checked") {
        _boxColor = Colors.greenAccent;
      } else if (txtstatus.text == "finished") {
        _boxColor = Colors.green;
      } else {
        _boxColor = Colors.yellow;
      }
    });
  }

  void hideKeyboard() async {
    await Future.delayed(const Duration(milliseconds: 100));
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  @override
  void dispose() {
    txtstatus.removeListener(_updateColor);

    for (final c in [
      txtScan, txtpartcard, txtsoluonghuy, txtusersubmit, txtcodedate,
      txtremark, txtstatus, txtSLNG, txtrecheck, txtbox,
    ]) {
      c.dispose();
    }

    for (final f in [
      scanid, partcardid, soluonghuyid, usersubmitid, codateid, remarkid,
      statusid, slngid, recheckid, boxid,
    ]) {
      f.dispose();
    }

    // super.dispose() phai goi CUOI CUNG
    super.dispose();
  }

  void safeRequestFocus(FocusNode node) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      FocusScope.of(context).requestFocus(node);
    });
  }

  // ==================== UI WIDGETS ====================

  Widget _field({
    required TextEditingController controller,
    required FocusNode focusNode,
    required String label,
    String hint = '',
    bool readOnly = false,
    bool autofocus = false,
    TextInputType? keyboardType,
    Color? fillColor,
    ValueChanged<String>? onSubmitted,
  }) {
    return SizedBox(
      height: 50,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        readOnly: readOnly,
        autofocus: autofocus,
        showCursor: true,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
          hintText: hint,
          filled: fillColor != null,
          fillColor: fillColor,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        ),
        onSubmitted: onSubmitted,
      ),
    );
  }

  /// O hien thi thong tin (chi doc), co nhan giong TextField.
  Widget _infoBox(String label, String value) {
    return SizedBox(
      height: 50,
      child: InputDecorator(
        isEmpty: value.isEmpty,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
          contentPadding:
          const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        ),
        child: Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 15, color: Colors.blue),
        ),
      ),
    );
  }

  Widget _radioOption(String value, String groupValue, String label,
      ValueChanged<String> onChanged) {
    return InkWell(
      onTap: () => onChanged(value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<String>(
            value: value,
            groupValue: groupValue,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
            onChanged: (v) {
              if (v != null) onChanged(v);
            },
          ),
          Text(label),
          const SizedBox(width: 8),
        ],
      ),
    );
  }

  Widget _checkOption({
    required bool value,
    required bool disabled,
    required String label,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      children: [
        Checkbox(
          value: value,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
          onChanged: disabled ? null : (bool? v) => onChanged(v ?? false),
        ),
        Expanded(
          child: Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontSize: 12, color: Colors.blue, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _smallButton(String text, VoidCallback onPressed) {
    return SizedBox(
      height: 34,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 2),
          minimumSize: const Size(0, 34),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
          textStyle: const TextStyle(fontSize: 13),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(text, maxLines: 1),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('More 1 Year Inspection IQC'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- Kieu kiem tra ---
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  _radioOption("Sample", typecheck, "Check Sample", checkRadio),
                  _radioOption("Rohs", typecheck, "Check Rohs", checkRadio),
                ],
              ),

              const SizedBox(height: 8),

              // --- Scan receiving card + scan box ---
              Row(
                children: [
                  Expanded(
                    child: _field(
                      controller: txtScan,
                      focusNode: scanid,
                      label: 'Scan RecevingCard',
                      autofocus: true,
                      onSubmitted: (value) {
                        if (typecheck == "") {
                          thongbaoNG("Bạn chưa chọn kiểu loại hình kiểm tra");
                          txtScan.text = "";
                          safeRequestFocus(scanid);
                        } else {
                          scanid_function(value);
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _field(
                      controller: txtbox,
                      focusNode: boxid,
                      label: 'Scan box',
                      onSubmitted: _onBoxSubmitted,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // --- Invoice / Date / Insert 1Year ---
              Row(
                children: [
                  Expanded(flex: 4, child: _infoBox('Invoice', lblinvoice)),
                  const SizedBox(width: 4),
                  Expanded(flex: 4, child: _infoBox('Date', lblincomingdate)),
                  const SizedBox(width: 4),
                  Expanded(
                    flex: 3,
                    child: _checkOption(
                      value: isinsert,
                      disabled: isDisabled,
                      label: 'Insert 1Year',
                      onChanged: (v) => setState(() => isinsert = v),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // --- Location / Qty Lot ---
              Row(
                children: [
                  Expanded(child: _infoBox('Location', vitri)),
                  const SizedBox(width: 8),
                  Expanded(child: _infoBox('Qty Lot', LotQty)),
                ],
              ),

              const SizedBox(height: 8),

              // --- Code date / QtyInput ---
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: _field(
                      controller: txtcodedate,
                      focusNode: codateid,
                      label: 'Code date',
                      onSubmitted: codateid_function,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _field(
                      controller: txtrecheck,
                      focusNode: recheckid,
                      label: 'QtyInput',
                      hint: '0',
                      keyboardType: TextInputType.number,
                      onSubmitted: recheckid_function,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // --- Remark / QtyNG ---
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: _field(
                      controller: txtremark,
                      focusNode: remarkid,
                      label: 'Remark',
                      onSubmitted: (value) => safeRequestFocus(soluonghuyid),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _field(
                      controller: txtSLNG,
                      focusNode: slngid,
                      label: 'QtyNG',
                      hint: '0',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // --- Q.Scrap / UserID / Status ---
              Row(
                children: [
                  Expanded(
                    child: _field(
                      controller: txtsoluonghuy,
                      focusNode: soluonghuyid,
                      label: 'Q.Scrap',
                      hint: '0',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _field(
                      controller: txtusersubmit,
                      focusNode: usersubmitid,
                      label: 'UserID',
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _field(
                      controller: txtstatus,
                      focusNode: statusid,
                      label: 'Status',
                      readOnly: true,
                      fillColor: _boxColor,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 5),

              // --- Judgment OK / NG ---
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  _radioOption("OK", group_OK_NG2, "Judgment OK", checkRadio2),
                  _radioOption("NG", group_OK_NG2, "Judment NG", checkRadio2),
                ],
              ),

              const SizedBox(height: 5),

              // --- Buttons: nut nho, tren 1 hang ---
              Row(
                children: [
                  Expanded(child: _smallButton('Submit', _onSubmitPressed)),
                  const SizedBox(width: 4),
                  Expanded(child: _smallButton('Clear', reset)),
                  const SizedBox(width: 4),
                  Expanded(
                    child: _smallButton('Exit', () {
                      // Quay lai IQC Menu dang co san trong stack
                      Navigator.of(context).pop();
                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ==================== SCAN BOX ====================

  void _boxError(String msg) {
    thongbaoNG(msg);
    txtbox.text = "";
    safeRequestFocus(boxid);
    hideKeyboard();
  }

  Future<void> _onBoxSubmitted(String value) async {
    try {
      final List<Map<String, dynamic>> dtcompare =
      await Query_CheckBoxCard(Barcodeid, txtbox.text.toString());
      if (!mounted) return;

      final row = _firstRow(dtcompare);
      if (row == null) {
        _boxError("Kiểm tra lại thông tin box card 2!");
        return;
      }

      if (_cell(row, 0) != '0') {
        if (isinsert == true) {
          txtrecheck.text = "";
          safeRequestFocus(recheckid);
        } else {
          // neu khong insert 1 nam
          safeRequestFocus(usersubmitid);
        }
        hideKeyboard();
      } else {
        _boxError("Kiểm tra lại thông tin box card 1!");
      }
    } catch (e) {
      Closepending();
      thongbaoNG(e.toString());
    }
  }

  // ==================== SUBMIT ====================

  Future<void> _onSubmitPressed() async {
    try {
      final String ID = IDmahang;
      final String codate = txtcodedate.text;
      final String remark = txtremark.text;

      final String soluonghuy =
      txtsoluonghuy.text.trim().isEmpty ? "0" : txtsoluonghuy.text.trim();
      final String soluonghuy_spl = soluonghuy;
      final String soluonghuy_rohs = soluonghuy;

      final String user_finished_spl = txtusersubmit.text;
      final String user_finished_rohs = txtusersubmit.text;
      final String invoice_ = lblinvoice;

      final String kieucheck = typecheck;
      final String user_dangnhap = userId;

      final String trangthai_check_sql = status_check_spl;
      final String trangthai_check_rohs = status_check_rohs;

      final String ketqua_spl = group_OK_NG2;
      final String ketqua_rohs = group_OK_NG2;

      final String SLNG =
      txtSLNG.text.trim().isEmpty ? "0" : txtSLNG.text.trim();

      final String trangthai_TTcheck = txtstatus.text;
      const String typerecheck = _typerecheck;

      final String user_check_spl = ketqua_spl == "" ? txtusersubmit.text : "";
      final String user_check_rohs =
      ketqua_rohs == "" ? txtusersubmit.text : "";

      // vua lay hang, vua tra hang va danh gia luon
      final String check1lan =
      (trangthai_TTcheck == "waiting" && group_OK_NG2 != "") ? "1" : "0";

      if (txtusersubmit.text == "") {
        thongbaoNG("Người kiểm tra QC không được trống!");
        txtusersubmit.text = "";
        safeRequestFocus(usersubmitid);
        return;
      }
      if (LotQty.toString() == "0") {
        thongbaoNG("số lượng lô = 0, Bạn check lại thông tin!");
        txtrecheck.text = "";
        safeRequestFocus(recheckid);
        return;
      }
      if (checkunit == true && txtbox.text == "") {
        thongbaoNG("Hàng này bắt buộc phai scan box!");
        safeRequestFocus(boxid);
        return;
      }

      if (isinsert == true && trangthai_TTcheck != "checked") {
        // ===== insert hang 1 nam va lay hang =====
        if (txtrecheck.text.trim() == "" || _toDouble(txtrecheck.text) == 0) {
          thongbaoNG("Bạn chưa nhập số lượng Recheck!");
          txtrecheck.text = "";
          safeRequestFocus(recheckid);
          return;
        }

        final String remark_new = check1lan == "1" ? "check1lan" : "";

        Openpeding();
        final List<Map<String, dynamic>> dtrecheck;
        if (check1lan == "1") {
          // vua lay hang => vua danh gia OK/NG 1 lan luon
          dtrecheck = await Query_insert_recheck6(
            Barcodeid, // chuoibarcode
            txtScan.text.toString().trim(), // mahang
            "Hang1Nam", // vitri_new
            txtrecheck.text, // soluonglot
            lblplant,
            lbldeliverydate,
            lbldano,
            lblpono,
            lblvender,
            lblctrlkey,
            lblctrlt,
            lblsloc,
            lbllotdate,
            lblCateQC,
            invoice_,
            IDmahang,
            "", // codate_new
            remark_new,
            userId, // createuser
            typerecheck,
            typecheck,
            txtusersubmit.text, // usercheck
            group_OK_NG2, // kequacheck
          );
        } else {
          dtrecheck = await Query_insert_recheck4(
            Barcodeid,
            txtScan.text.toString().trim(),
            "Hang1Nam",
            txtrecheck.text,
            lblplant,
            lbldeliverydate,
            lbldano,
            lblpono,
            lblvender,
            lblctrlkey,
            lblctrlt,
            lblsloc,
            lbllotdate,
            lblCateQC,
            invoice_,
            IDmahang,
            "",
            remark_new,
            userId,
            typerecheck,
            typecheck,
            txtusersubmit.text,
          );
        }
        if (!mounted) return;
        Closepending();

        final row = _firstRow(dtrecheck);
        if (row == null) {
          thongbaoNG("NG, He thong, lien he IT1!");
        } else if (_cell(row, 0) == "1") {
          thongbaoOK("Hoàn thành trang thái lấy hàng!");
          reset();
        } else {
          // kequa == "4" lo chua duoc danh gia
          thongbaoNG("Lô hàng chưa được đánh giá OK/NG lần nào!");
        }
      } else {
        // ===== submit binh thuong =====
        Openpeding();
        final List<Map<String, dynamic>> dtupdate =
        await Query_update_check_QC_1nam(
            ID, codate, remark, soluonghuy_spl, soluonghuy_rohs,
            user_finished_spl, user_finished_rohs, user_check_spl,
            user_check_rohs, ketqua_spl, ketqua_rohs, kieucheck,
            user_dangnhap, trangthai_check_sql, trangthai_check_rohs,
            trangthai_TTcheck, invoice_, SLNG, typerecheck, check1lan);
        if (!mounted) return;
        Closepending();

        final row = _firstRow(dtupdate);
        if (row == null) {
          thongbaoNG("NG, He thong, lien he IT!");
          return;
        }

        final String kequa = _cell(row, 0);
        if (kequa == "1") {
          thongbaoOK("Hoàn thành trang thái lấy hàng!");
          reset();
        } else if (kequa == "3") {
          thongbaoNG("Bạn không có quyền sửa kết quả kiểm tra!");
        } else {
          // kequa == "2"
          await function_auto_rohs_NG(SLNG);
        }
      }
    } catch (e) {
      Closepending();
      thongbaoNG("loi try cach: $e");
    }
  }

  /// Tru kho MCS, hien thong bao va reset khi co ket qua.
  Future<void> _truKhoMCS(String qty) async {
    final List<Map<String, dynamic>> dtkq =
    await Auto_Sap_rohs_Iqc_new(Barcodeid, txtbox.text.toString(), qty);
    if (!mounted) return;
    final row = _firstRow(dtkq);
    if (row == null) return;
    if (_cell(row, 0) != '0') {
      thongbaoOK("Kiểm tra hàng thành công!");
    } else {
      thongbaoOK("Kiểm tra hàng thành công! Chưa trừ kho MCS");
    }
    reset();
  }

  Future<void> _xuLyNGAllLot(String SLNG) async {
    final int? NGallLot = await showdialognotify(
        "Bạn xác nhận trường hợp này có phải đánh giá All LOT không?");
    if (!mounted || NGallLot != 1) return;

    final List<Map<String, dynamic>> dtkq = await Auto_Sap_rohs_Iqc_NG(
        Barcodeid, txtbox.text.toString(), SLNG);
    if (!mounted) return;
    final row = _firstRow(dtkq);
    if (row == null) return;
    if (_cell(row, 0) != '0') {
      thongbaoOK("Kiểm tra hàng thành công!");
    } else {
      thongbaoOK("Kiểm tra hàng thành công! Chưa trừ kho MCS");
    }
    reset();
  }

  Future<void> function_auto_rohs_NG(String SLNG) async {
    final String qtyRosh =
    txtsoluonghuy.text.trim().isEmpty ? "0" : txtsoluonghuy.text.trim();

    final double qtyRoshNum = _toDouble(qtyRosh);
    final double slngNum = _toDouble(SLNG);
    final double lotQtyNum = _toDouble(LotQty);

    if (slngNum > 0 && slngNum > lotQtyNum) {
      // danh gia NG ca Lot
      await _xuLyNGAllLot(SLNG);
    } else if (qtyRoshNum > 0 && slngNum > 0) {
      // tru ca 2
      await _truKhoMCS((qtyRoshNum + slngNum).toString());
    } else if (qtyRoshNum > 0) {
      await _truKhoMCS(qtyRosh);
    } else if (slngNum > 0) {
      await _truKhoMCS(SLNG);
    } else {
      thongbaoOK("Kiểm tra hàng thành công!");
      reset();
    }
  }

  // ==================== SCAN RECEIVING CARD ====================

  Future<void> scanid_function(String chuoibarcode) async {
    try {
      Openpeding();
      final List<Map<String, dynamic>> dtinfor =
      await Query_thongtinbarcode(chuoibarcode.toString(), _typerecheck);
      if (!mounted) return;
      Closepending();

      final row = _firstRow(dtinfor);
      if (row == null || _cell(row, 0) == '0') {
        // chua co trong freelocation => lay tu receiving card
        await Input_Data_IQC(chuoibarcode, dtinfor);
        return;
      }

      final String mahang = _cell(row, 0);

      // check hang unit box
      final List<Map<String, dynamic>> dtcheckunit =
      await Query_CheckUnitbox(chuoibarcode.toString());
      if (!mounted) return;
      final unitRow = _firstRow(dtcheckunit);
      if (unitRow != null && _cell(unitRow, 0) == '1') {
        checkunit = true; // hang unit box => bat buoc scan box
      }

      final String invoice = _cell(row, 1);
      final String ngayhangve = _cell(row, 2);
      final String soluonglot = _cell(row, 4);
      final String _IDmahang = _cell(row, 5);
      final String codate = _cell(row, 6);
      final String remark = _cell(row, 7);
      final String soluong_huy_spl = _cell(row, 8);
      final String soluong_huy_rohs = _cell(row, 9);
      final String user_finish_spl = _cell(row, 10);
      final String user_finish_rohs = _cell(row, 11);
      final String ketqua_spl = _cell(row, 12);
      final String ketqua_rohs = _cell(row, 13);
      final String trangthai_kiemtra = _cell(row, 14);
      final String plant = _cell(row, 15);
      final String deliverydate = _cell(row, 16);
      final String dano = _cell(row, 17);
      final String pono = _cell(row, 18);
      final String vender = _cell(row, 19);
      final String ctrkey = _cell(row, 20);
      final String ctrt = _cell(row, 21);
      final String sloc = _cell(row, 22);
      final String lotdate = _cell(row, 23);
      final String CateQC = _cell(row, 24);
      final String soluongNG = _cell(row, 25);

      setState(() {
        status_check_spl = ketqua_spl == "" ? "0" : "1";
        status_check_rohs = ketqua_rohs == "" ? "0" : "1";

        isDisabled = true;

        lblinvoice = invoice;
        lblincomingdate = ngayhangve;
        vitri = "Hang1Nam";
        LotQty = soluonglot;
        IDmahang = _IDmahang;

        // luu lai thong tin de dung khi insert hang 1 nam
        lbldeliverydate = deliverydate;
        lblplant = plant;
        lbldano = dano;
        lblpono = pono;
        lblvender = vender;
        lblctrlkey = ctrkey;
        lblctrlt = ctrt;
        lblsloc = sloc;
        lbllotdate = lotdate;
        lblCateQC = CateQC;

        codedate_ = codate;
        remark_ = remark;
        soluong_huy_spl_ = soluong_huy_spl;
        soluong_huy_rohs_ = soluong_huy_rohs;
        user_finish_spl_ = user_finish_spl;
        user_finish_rohs_ = user_finish_rohs;
        ketqua_spl_ = ketqua_spl;
        ketqua_rohs_ = ketqua_rohs;
        lblqtyNG = soluongNG;
        Barcodeid = chuoibarcode;

        if (typecheck == "Sample") {
          txtsoluonghuy.text = soluong_huy_spl;
          txtusersubmit.text = user_finish_spl;
          group_OK_NG2 = user_finish_spl == "" ? "" : ketqua_spl;
        } else {
          txtsoluonghuy.text = soluong_huy_rohs;
          txtusersubmit.text = user_finish_rohs;
          group_OK_NG2 = user_finish_rohs == "" ? "" : ketqua_rohs;
        }
      });

      txtScan.text = mahang;
      txtcodedate.text = codate;
      txtremark.text = remark;
      txtstatus.text = trangthai_kiemtra;
      txtSLNG.text = soluongNG;

      if (isinsert == true) {
        txtbox.selection =
            TextSelection(baseOffset: 0, extentOffset: txtbox.text.length);
        safeRequestFocus(boxid);
      } else {
        safeRequestFocus(usersubmitid);
        hideKeyboard();
      }
    } catch (e) {
      Closepending();
      thongbaoNG(e.toString());
    }
  }

  Future<void> Input_Data_IQC(
      String chuoibarcode, List<Map<String, dynamic>> dtinfor) async {
    setState(() => Barcodeid = chuoibarcode.toString());

    final List<Map<String, dynamic>> dtrcheck =
    await Query_thongtinreceivingcard(chuoibarcode.toString(), _typerecheck);
    if (!mounted) return;

    final row = _firstRow(dtrcheck);
    if (row == null || _cell(row, 0) == '0') {
      thongbaoNG("Hàng không có trong hệ thống(1nam)!, liên hệ IT!");
      txtScan.text = "";
      safeRequestFocus(scanid);
      return;
    }

    final String mahang = _cell(row, 0);
    final String invoice = _cell(row, 1);
    final String ngayhangve = _cell(row, 2);
    final String soluonglot = _cell(row, 4);
    final String _IDmahang = _cell(row, 5);
    final String codate = _cell(row, 6);
    final String remark = _cell(row, 7);
    final String plant = _cell(row, 15);
    final String deliverydate = _cell(row, 16);
    final String dano = _cell(row, 17);
    final String pono = _cell(row, 18);
    final String vender = _cell(row, 19);
    final String ctrkey = _cell(row, 20);
    final String ctrt = _cell(row, 21);
    final String sloc = _cell(row, 22);
    final String lotdate = _cell(row, 23);
    final String CateQC = _cell(row, 24);

    setState(() {
      isDisabled = true;
      isinsert = true;

      status_check_spl = "0";
      status_check_rohs = "0";

      lblinvoice = invoice;
      lblincomingdate = ngayhangve;
      lbldeliverydate = deliverydate;
      vitri = "Hang1Nam";
      LotQty = soluonglot;
      IDmahang = _IDmahang;
      lblplant = plant;
      lbldano = dano;
      lblpono = pono;
      lblvender = vender;
      lblctrlkey = ctrkey;
      lblctrlt = ctrt;
      lblsloc = sloc;
      lbllotdate = lotdate;
      lblCateQC = CateQC;

      codedate_ = codate;
      remark_ = remark;
      soluong_huy_spl_ = "0";
      soluong_huy_rohs_ = "0";
      user_finish_spl_ = "";
      user_finish_rohs_ = "";
      ketqua_spl_ = "";
      ketqua_rohs_ = "";
      lblqtyNG = "0";
      Barcodeid = chuoibarcode;
    });

    txtScan.text = mahang;
    txtcodedate.text = codate;
    txtremark.text = remark;
    txtstatus.text = "waiting";
    txtSLNG.text = '';
    txtrecheck.text = "";
    safeRequestFocus(recheckid);
  }

  // ==================== FIELD HANDLERS ====================

  void codateid_function(String chuoicodedate) {
    safeRequestFocus(remarkid);
    hideKeyboard();
  }

  void recheckid_function(String soluonginput) {
    if (soluonginput.trim().isEmpty ||
        double.tryParse(soluonginput.trim()) == null) {
      thongbaoNG("Bạn chưa nhập số lượng lô!");
      txtrecheck.text = "";
      safeRequestFocus(recheckid);
      return;
    }

    if (_toDouble(soluonginput) > _toDouble(LotQty)) {
      thongbaoNG("Số lượng nhập vào lớn hơn so lượng lot ban đầu!");
      txtrecheck.text = "";
      safeRequestFocus(recheckid);
      return;
    }

    setState(() => group_OK_NG2 = "");
    txtusersubmit.text = "";
    safeRequestFocus(usersubmitid);
    hideKeyboard();
  }

  // ==================== DIALOGS ====================

  void thongbaoNG(String thongbao) {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.red,
        content: Text(
          thongbao,
          style: const TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void thongbaoOK(String thongbao) {
    if (!mounted) return;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.green,
        content: Text(
          thongbao,
          style: const TextStyle(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  void Openpeding() {
    if (!mounted || _isLoading) return;
    _isLoading = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 10),
              Text('Loading...'),
            ],
          ),
        );
      },
    ).then((_) => _isLoading = false);
  }

  void Closepending() {
    // Chi dong khi dialog Loading dang mo, tranh pop nham ca man hinh.
    if (!mounted || !_isLoading) return;
    _isLoading = false;
    Navigator.of(context, rootNavigator: true).pop();
  }

  Future<int?> showdialognotify(String notify) async {
    if (!mounted) return null;
    return showDialog<int>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Notify'),
          content: SingleChildScrollView(
            child: ListBody(children: <Widget>[Text(notify)]),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Yes'),
              onPressed: () => Navigator.of(context).pop(1),
            ),
            TextButton(
              child: const Text('No'),
              onPressed: () => Navigator.of(context).pop(0),
            ),
          ],
        );
      },
    );
  }

  // ==================== RESET ====================

  void reset() {
    if (!mounted) return;
    setState(() {
      txtScan.text = "";
      group_OK_NG2 = "";
      typecheck = "Sample";
      lblinvoice = '';
      lblincomingdate = '';
      vitri = '';
      LotQty = '';
      IDmahang = '';
      codedate_ = '';
      remark_ = '';
      soluong_huy_spl_ = '0';
      soluong_huy_rohs_ = '0';
      user_finish_spl_ = '';
      user_finish_rohs_ = '';
      ketqua_spl_ = '';
      ketqua_rohs_ = '';

      lbldeliverydate = "";
      lblplant = "";
      lbldano = "";
      lblpono = "";
      lblvender = "";
      lblctrlkey = "";
      lblctrlt = "";
      lblsloc = "";
      lbllotdate = "";
      lblCateQC = "";

      txtcodedate.text = "";
      txtremark.text = "";
      txtsoluonghuy.text = "";
      txtusersubmit.text = "";
      txtstatus.text = "";
      txtpartcard.text = "";
      txtSLNG.text = "";

      Barcodeid = "";
      txtrecheck.text = "";

      isinsert = false;
      isDisabled = false;

      txtbox.text = "";
      checkunit = false;
    });
    safeRequestFocus(scanid);
  }
}
