import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import '../ControllerAPI/api_IQC.dart';
import '../ModelUI/class_api_IQC.dart';
import '../di/di.dart';
import '../l10n/app_lang.dart';
import '../repositories/auth_repository.dart';
import '../views/pages/iqc/iqc_menu_page.dart';

class CheckInspection extends StatefulWidget {
  const CheckInspection({super.key});

  @override
  _ExampleWidgetState createState() => _ExampleWidgetState();
}

class _ExampleWidgetState extends State<CheckInspection> {
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
  final txtSLNG = TextEditingController(text: '0');
  final txtrecheck = TextEditingController();
  final txtctrlkey = TextEditingController();
  final txtctrlT = TextEditingController();
  final txtbox = TextEditingController();
  final txtqtybox = TextEditingController();

  Color _boxColor = Colors.white;

  final FocusNode scanid = FocusNode();
  final FocusNode partcardid = FocusNode();
  final FocusNode soluonghuyid = FocusNode();
  final FocusNode usersubmitid = FocusNode();
  final FocusNode codateid = FocusNode();
  final FocusNode remarkid = FocusNode();
  final FocusNode statusid = FocusNode();
  final FocusNode slngid = FocusNode();
  final FocusNode recheckid = FocusNode();
  final FocusNode ctrlkeyid = FocusNode();
  final FocusNode ctrlTid = FocusNode();
  final FocusNode boxid = FocusNode();
  final FocusNode qtyboxid = FocusNode();

  String lblqtyboxid = "0";

  String lblinvoice = "";
  String lblincomingdate = "";
  String vitri = "";
  String LotQty = "";
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

  String lblCtrlkey = "";
  String lblCtrlT = "";
  String lblbarcodebox = "";
  String lblcateQC = "";

  bool checkunit = false; // khong phai hang unit box
  bool isboxng = false; // bien scan nhieu box NG
  bool isScanboxNG = false;

  var droprecheck;

  // Co theo doi dialog Loading dang mo hay khong.
  // Tranh truong hop Closepending() pop nham man hinh chinh.
  bool _isLoading = false;

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
    final id = await getIt<AuthRepository>().getUserID();
    print(id);

    if (!mounted) return;
    setState(() {
      userId = id;
    });
  }

  // ==================== NGON NGU ====================

  /// Khi doi ngon ngu => build lai man hinh.
  void _onLangChanged() {
    if (!mounted) return;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    LangController.current.addListener(_onLangChanged);
    LangController.load(); // doc ngon ngu da luu lan truoc
    autogetuser();
    droprecheck = "";
    hideKeyboard();
    txtstatus.addListener(_updateColor);
  }

  void _updateColor() {
    if (!mounted) return;
    setState(() {
      // Luu y: "checked"/"finished" la gia tri du lieu tu server,
      // KHONG dich cac gia tri nay.
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
    LangController.current.removeListener(_onLangChanged);
    txtstatus.removeListener(_updateColor);

    for (final c in [
      txtScan, txtpartcard, txtsoluonghuy, txtusersubmit, txtcodedate,
      txtremark, txtstatus, txtSLNG, txtrecheck, txtctrlkey, txtctrlT,
      txtbox, txtqtybox,
    ]) {
      c.dispose();
    }

    for (final f in [
      scanid, partcardid, soluonghuyid, usersubmitid, codateid, remarkid,
      statusid, slngid, recheckid, ctrlkeyid, ctrlTid, boxid, qtyboxid,
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

  /// Nut chon ngon ngu tren AppBar.
  Widget _languageButton() {
    return PopupMenuButton<AppLang>(
      tooltip: tr('language'),
      initialValue: LangController.current.value,
      onSelected: (lang) => LangController.set(lang),
      itemBuilder: (_) => const [
        PopupMenuItem(value: AppLang.vi, child: Text('🇻🇳  Tiếng Việt')),
        PopupMenuItem(value: AppLang.en, child: Text('🇬🇧  English')),
        PopupMenuItem(value: AppLang.ja, child: Text('🇯🇵  日本語')),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.language),
            const SizedBox(width: 4),
            Text(
              switch (LangController.current.value) {
                AppLang.vi => 'VI',
                AppLang.en => 'EN',
                AppLang.ja => 'JA',
              },
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

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

  Widget _infoCard(String value, String placeholder) {
    return SizedBox(
      height: 40,
      child: Card(
        margin: const EdgeInsets.all(2),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              value.isEmpty ? placeholder : value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 16, color: Colors.blue),
            ),
          ),
        ),
      ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tr('iqcTitle')),
        actions: [_languageButton()],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- Kieu kiem tra + scan boxes ---
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  _radioOption(
                      "Sample", typecheck, tr('checkSample'), checkRadio),
                  _radioOption("Rohs", typecheck, tr('checkRohs'), checkRadio),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Checkbox(
                        value: isboxng,
                        materialTapTargetSize:
                        MaterialTapTargetSize.shrinkWrap,
                        visualDensity: VisualDensity.compact,
                        onChanged: isScanboxNG
                            ? null
                            : (bool? value) {
                          setState(() => isboxng = value ?? false);
                        },
                      ),
                      Text(
                        tr('scanBoxes'),
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
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
                      label: tr('scanReceivingCard'),
                      autofocus: true,
                      onSubmitted: (value) {
                        if (typecheck == "") {
                          thongbaoNG(tr('msgNoCheckType'));
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
                      label: tr('scanBox'),
                      onSubmitted: _onBoxSubmitted,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 5),

              // --- Invoice / Date / LotQty ---
              Row(
                children: [
                  Expanded(
                      flex: 4, child: _infoCard(lblinvoice, tr('invoice'))),
                  Expanded(
                      flex: 3, child: _infoCard(lblincomingdate, tr('date'))),
                  Expanded(flex: 2, child: _infoCard(LotQty, '0')),
                ],
              ),

              const SizedBox(height: 5),

              // --- Position / CtrlKey / CtrlT / Qty ---
              Row(
                children: [
                  Expanded(child: _infoCard(vitri, tr('position'))),
                  const SizedBox(width: 4),
                  Expanded(
                    child: _field(
                      controller: txtctrlkey,
                      focusNode: ctrlkeyid,
                      label: tr('ctrlKey'),
                      readOnly: true,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: _field(
                      controller: txtctrlT,
                      focusNode: ctrlTid,
                      label: tr('ctrlT'),
                      readOnly: true,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: _field(
                      controller: txtqtybox,
                      focusNode: qtyboxid,
                      label: tr('qty'),
                      hint: '0',
                      readOnly: true,
                    ),
                  ),
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
                      label: tr('codeDate'),
                      onSubmitted: codateid_function,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _field(
                      controller: txtrecheck,
                      focusNode: recheckid,
                      label: tr('qtyInput'),
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
                      label: tr('remark'),
                      onSubmitted: remarkid_function,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _field(
                      controller: txtSLNG,
                      focusNode: slngid,
                      label: tr('qtyNG'),
                      hint: '0',
                      keyboardType: TextInputType.number,
                      onSubmitted: (value) {
                        setState(() => lblqtyboxid = txtSLNG.text);
                        txtbox.text = "";
                        safeRequestFocus(boxid);
                      },
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
                      label: tr('qtyScrap'),
                      hint: '0',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _field(
                      controller: txtusersubmit,
                      focusNode: usersubmitid,
                      label: tr('userId'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _field(
                      controller: txtstatus,
                      focusNode: statusid,
                      label: tr('status'),
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
                  _radioOption(
                      "OK", group_OK_NG2, tr('judgmentOK'), checkRadio2),
                  _radioOption(
                      "NG", group_OK_NG2, tr('judgmentNG'), checkRadio2),
                ],
              ),

              const SizedBox(height: 5),

              // --- Buttons: nut nho, 4 nut tren 1 hang ---
              Row(
                children: [
                  Expanded(
                      child: _smallButton(tr('submit'), _onSubmitPressed)),
                  const SizedBox(width: 4),
                  Expanded(child: _smallButton(tr('reset'), reset)),
                  const SizedBox(width: 4),
                  Expanded(
                      child: _smallButton(tr('delete'), _onDeletePressed)),
                  const SizedBox(width: 4),
                  Expanded(
                    child: _smallButton(tr('exit'), () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const IQCMenuPage()),
                      );
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
      final String barcode = Barcodeid;
      final String barcodeBox = txtbox.text.toString();
      final String QtyRC = lblqtyboxid;

      if (isboxng == true && _toDouble(txtSLNG.text) > 0) {
        // scan nhieu box 1 luc tru kho MCS
        final List<Map<String, dynamic>> dtupdatebox =
        await Query_CheckBoxCard_manybox(barcode, barcodeBox, QtyRC);
        if (!mounted) return;

        final row = _firstRow(dtupdatebox);
        if (row == null) {
          _boxError(tr('msgCheckBoxCard', {'n': '3'}));
          return;
        }

        final String kq = _cell(row, 0);
        final String soluongconlai = _cell(row, 1);
        if (kq != '0') {
          setState(() {
            txtqtybox.text = soluongconlai;
            lblqtyboxid = soluongconlai;
          });
          txtbox.text = "";
          if (_toDouble(lblqtyboxid) == 0) {
            txtusersubmit.text = "";
            safeRequestFocus(usersubmitid);
          } else {
            safeRequestFocus(boxid);
          }
          hideKeyboard();
        } else {
          _boxError(tr('msgCheckBoxCard', {'n': '4'}));
        }
      } else {
        // truong hop normal
        final List<Map<String, dynamic>> dtcompare =
        await Query_CheckBoxCard(barcode, barcodeBox);
        if (!mounted) return;

        final row = _firstRow(dtcompare);
        if (row == null) {
          _boxError(tr('msgCheckBoxCard', {'n': '2'}));
          return;
        }

        if (_cell(row, 0) != '0') {
          if (isboxng == true) {
            txtbox.text = "";
            safeRequestFocus(boxid);
          } else {
            txtusersubmit.text = "";
            safeRequestFocus(usersubmitid);
          }
          hideKeyboard();
        } else {
          _boxError(tr('msgCheckBoxCard', {'n': '1'}));
        }
      }
    } catch (e) {
      Closepending();
      thongbaoNG(tr('error', {'e': e.toString()}));
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

      final String SLNG =
      txtSLNG.text.trim().isEmpty ? "0" : txtSLNG.text.trim();

      final String ketqua_spl = group_OK_NG2;
      final String ketqua_rohs = group_OK_NG2;

      final String trangthai_TTcheck = txtstatus.text;
      final String typerecheck = droprecheck.toString();

      final String user_check_spl = ketqua_spl == "" ? txtusersubmit.text : "";
      final String user_check_rohs =
      ketqua_rohs == "" ? txtusersubmit.text : "";

      // cung lay hang, cung check, cung tra hang va danh gia luon
      final String check1lan =
      (trangthai_TTcheck == "waiting" && group_OK_NG2 != "") ? "1" : "0";

      if (txtusersubmit.text == "") {
        thongbaoNG(tr('msgQcUserEmpty'));
        txtusersubmit.text = "";
        safeRequestFocus(usersubmitid);
        return;
      }
      if (LotQty.toString() == "0") {
        thongbaoNG(tr('msgLotQtyZero'));
        txtrecheck.text = "";
        safeRequestFocus(recheckid);
        return;
      }
      if (checkunit == true && txtbox.text == "") {
        thongbaoNG(tr('msgMustScanBox'));
        safeRequestFocus(boxid);
        return;
      }

      Openpeding();
      final String barcode = Barcodeid;
      final String barcodeBox = txtbox.text.toString();
      final String qtyRosh = soluonghuy;

      Future<void> doSubmit() => Submit_IQC_Inspection(
        ID, codate, remark, soluonghuy_spl, soluonghuy_rohs,
        user_finished_spl, user_finished_rohs, user_check_spl,
        user_check_rohs, ketqua_spl, ketqua_rohs, kieucheck,
        user_dangnhap, trangthai_check_sql, trangthai_check_rohs,
        trangthai_TTcheck, invoice_, SLNG, typerecheck, check1lan,
        barcodeBox, qtyRosh, barcode,
      );

      if (_toDouble(SLNG) > 0) {
        // chan hang NG neu chua duoc GR
        final List<Map<String, dynamic>> dtGR =
        await Query_Check_GR(barcode, SLNG);
        if (!mounted) return;

        final row = _firstRow(dtGR);
        if (row == null) {
          Closepending();
          thongbaoNG(tr('msgCheckGR'));
        } else if (_cell(row, 0) == "1") {
          await doSubmit();
        } else {
          Closepending();
          thongbaoNG(tr('msgNotInStock'));
        }
      } else {
        await doSubmit();
      }
    } catch (e) {
      Closepending();
      thongbaoNG(tr('error', {'e': e.toString()}));
    }
  }

  Future<void> Submit_IQC_Inspection(
      String ID,
      String codate,
      String remark,
      String soluonghuy_spl,
      String soluonghuy_rohs,
      String user_finished_spl,
      String user_finished_rohs,
      String user_check_spl,
      String user_check_rohs,
      String ketqua_spl,
      String ketqua_rohs,
      String kieucheck,
      String user_dangnhap,
      String trangthai_check_sql,
      String trangthai_check_rohs,
      String trangthai_TTcheck,
      String invoice_,
      String SLNG,
      String typerecheck,
      String check1lan,
      String barcodeBox,
      String qtyRosh,
      String barcode,
      ) async {
    final List<Map<String, dynamic>> dtupdate = await Query_update_check_QC(
        ID, codate, remark, soluonghuy_spl, soluonghuy_rohs,
        user_finished_spl, user_finished_rohs, user_check_spl,
        user_check_rohs, ketqua_spl, ketqua_rohs, kieucheck, user_dangnhap,
        trangthai_check_sql, trangthai_check_rohs, trangthai_TTcheck,
        invoice_, SLNG, typerecheck, check1lan, barcodeBox);
    if (!mounted) return;

    Closepending();

    final row = _firstRow(dtupdate);
    if (row == null) {
      thongbaoNG(tr('msgSystemNG'));
      return;
    }

    final String kequa = _cell(row, 0);
    if (kequa == "1") {
      thongbaoOK(tr('msgPickupDone'));
      reset();
      return;
    }
    if (kequa == "3") {
      thongbaoNG(tr('msgNoPermission'));
      return;
    }

    final double qtyRoshNum = _toDouble(qtyRosh);
    final double slngNum = _toDouble(SLNG);
    final double lotQtyNum = _toDouble(LotQty);

    if (slngNum > 0 && slngNum > lotQtyNum) {
      // danh gia NG ca Lot
      await _xuLyNGAllLot(barcode, barcodeBox, SLNG);
    } else if (qtyRoshNum > 0 && slngNum > 0) {
      // tru ca 2 (normal)
      final String qtytong = (qtyRoshNum + slngNum).toString();
      await _truKhoMCS(barcode, barcodeBox, qtytong, "all");
    } else if (qtyRoshNum > 0) {
      // chi tru rohs / sample
      String typeIQC;
      if (typecheck == "Sample") {
        typeIQC = "sample";
      } else if (typecheck == "Rohs") {
        typeIQC = "rohs";
      } else {
        typeIQC = typecheck;
      }
      await _truKhoMCS(barcode, barcodeBox, qtyRosh, typeIQC);
    } else if (slngNum > 0) {
      await _truKhoMCS(barcode, barcodeBox, SLNG, "NG");
    } else {
      thongbaoOK(tr('msgCheckSuccess'));
    }

    if (mounted) reset();
  }

  Future<void> _truKhoMCS(
      String barcode, String barcodeBox, String qty, String typeIQC) async {
    final List<Map<String, dynamic>> dtkq =
    await Auto_Sap_rohs_Iqc_new2(barcode, barcodeBox, qty, typeIQC);
    if (!mounted) return;
    final row = _firstRow(dtkq);
    if (row == null) return;
    if (_cell(row, 0) != '0') {
      thongbaoOK(tr('msgCheckSuccess'));
    } else {
      thongbaoOK(tr('msgCheckSuccessNoMCS'));
    }
  }

  Future<void> _xuLyNGAllLot(
      String barcode, String barcodeBox, String SLNG) async {
    final int? NGallLot = await showdialognotify(tr('msgConfirmNGAllLot'));
    if (!mounted) return;

    if (NGallLot == 1) {
      final List<Map<String, dynamic>> dtkq =
      await Auto_Sap_rohs_Iqc_NG(barcode, barcodeBox, SLNG);
      if (!mounted) return;
      final row = _firstRow(dtkq);
      if (row == null) return;
      if (_cell(row, 0) != '0') {
        thongbaoOK(tr('msgCheckSuccess'));
      } else {
        thongbaoOK(tr('msgCheckSuccessNoMCS'));
      }
    } else {
      // revert lai so luong bang free location
      final List<Map<String, dynamic>> dtkq =
      await Auto_Sap_rohs_Iqc_NG_revert(barcode, barcodeBox, SLNG);
      if (!mounted) return;
      final row = _firstRow(dtkq);
      if (row == null) return;
      if (_cell(row, 0) != '0') {
        thongbaoOK(tr('msgRevertSuccess'));
      } else {
        thongbaoNG(tr('msgCheckInfoNG'));
      }
    }
  }

  // ==================== DELETE ====================

  Future<void> _onDeletePressed() async {
    try {
      if (txtusersubmit.text == "") {
        thongbaoNG(tr('msgQcUserEmpty'));
        txtusersubmit.text = "";
        safeRequestFocus(usersubmitid);
        return;
      }

      final List<Map<String, dynamic>> dt_huycheck =
      await Freelocation_delete_inspection_mobile(IDmahang, Barcodeid,
          lblcateQC.toString(), codedate_, remark_, userId);
      if (!mounted) return;

      final row = _firstRow(dt_huycheck);
      final String kequa = row == null ? '' : _cell(row, 0);
      if (kequa == "1") {
        thongbaoOK(tr('msgDeleteSuccess'));
        reset();
      } else if (kequa == "2") {
        thongbaoNG(tr('msgAlreadyJudged'));
      } else {
        thongbaoNG(tr('msgAlreadyDeleted'));
      }
    } catch (e) {
      thongbaoNG(tr('error', {'e': e.toString()}));
    }
  }

  // ==================== SCAN RECEIVING CARD ====================

  Future<void> scanid_function(String chuoibarcode) async {
    try {
      final String typerecheck = droprecheck.toString();
      Openpeding();

      final List<Map<String, dynamic>> dtinfor =
      await Query_thongtinbarcode(chuoibarcode.toString(), typerecheck);
      if (!mounted) return;
      Closepending();

      final row = _firstRow(dtinfor);
      if (row == null) {
        thongbaoNG(tr('msgNotInFreeLocation'));
        return;
      }

      final String mahang = _cell(row, 0);
      if (mahang == '0') {
        await Input_Data_IQC(chuoibarcode, dtinfor);
        return;
      }

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
      final String _vitri = _cell(row, 3);
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
      final String Ctrlkey = _cell(row, 20);
      final String CtrlT = _cell(row, 21);
      final String cateQC = _cell(row, 24);
      final String soluongNG = _cell(row, 25);
      final String barcodebox = _cell(row, 31);

      setState(() {
        status_check_spl = ketqua_spl == "" ? "0" : "1";
        status_check_rohs = ketqua_rohs == "" ? "0" : "1";

        lblinvoice = invoice;
        lblincomingdate = ngayhangve;
        vitri = _vitri;
        LotQty = soluonglot;
        IDmahang = _IDmahang;

        lblCtrlkey = Ctrlkey;
        lblCtrlT = CtrlT;
        lblbarcodebox = barcodebox;
        lblcateQC = cateQC;

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
      txtctrlkey.text = Ctrlkey;
      txtctrlT.text = CtrlT;
      txtbox.text = barcodebox;

      if (checkunit == true) {
        txtbox.selection =
            TextSelection(baseOffset: 0, extentOffset: txtbox.text.length);
        safeRequestFocus(boxid);
      } else {
        safeRequestFocus(usersubmitid);
        hideKeyboard();
      }
    } catch (e) {
      Closepending();
      thongbaoNG(tr('error', {'e': e.toString()}));
    }
  }

  Future<void> Input_Data_IQC(
      String chuoibarcode, List<Map<String, dynamic>> dtinfor) async {
    setState(() => Barcodeid = chuoibarcode.toString());

    final String typerecheck = droprecheck.toString();
    final List<Map<String, dynamic>> dtrcheck =
    await Query_thongtinreceivingcard(chuoibarcode.toString(), typerecheck);
    if (!mounted) return;

    final row = _firstRow(dtrcheck);
    if (row == null || _cell(row, 0) == '0') {
      thongbaoNG(tr('msgNotInSystem'));
      txtScan.text = "";
      safeRequestFocus(scanid);
      return;
    }

    final String mahang = _cell(row, 0);
    final String barcode = chuoibarcode;
    final String invoice = _cell(row, 1);
    final String soluonglot = _cell(row, 4);
    final String idrecheck = _cell(row, 5);
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
    final String createuser = userId;

    String message;
    String vitriInsert;
    String soluongInsert;
    bool focusQtyInput;

    if (typerecheck == 'Hang1Nam') {
      message = tr('msgOver1Year');
      vitriInsert = "Hang1Nam";
      soluongInsert = "0";
      focusQtyInput = true;
    } else if (typerecheck == 'recheck') {
      message = tr('msgRecheck');
      vitriInsert = "recheck";
      soluongInsert = soluonglot;
      focusQtyInput = true;
    } else {
      // hang non inspection --> insert luon vao bang freelocation cua IQC
      message = tr('msgNonInspection');
      vitriInsert = "Noninspection";
      soluongInsert = soluonglot;
      focusQtyInput = false;
    }

    final int? rs = await showdialognotify(message);
    if (!mounted) return;
    if (rs != 1) {
      reset();
      return;
    }

    final List<Map<String, dynamic>> dtupdate = await Query_insert_recheck2(
        barcode, mahang, vitriInsert, soluongInsert, plant, deliverydate,
        dano, pono, vender, ctrkey, ctrt, sloc, lotdate, CateQC, invoice,
        idrecheck, codate, remark, createuser, typerecheck);
    if (!mounted) return;

    final newRow = _firstRow(dtupdate);
    if (newRow == null) {
      thongbaoNG(tr('msgCheckInfoNG2'));
      reset();
      return;
    }

    final String IDnew = _cell(newRow, 0);

    setState(() {
      status_check_spl = "0";
      status_check_rohs = "0";
      group_OK_NG2 = "";

      lblinvoice = invoice;
      lblincomingdate = deliverydate;
      vitri = vitriInsert;
      LotQty = soluonglot;
      IDmahang = IDnew;
      lblcateQC = CateQC;

      codedate_ = codate;
      remark_ = remark;
      soluong_huy_spl_ = '0';
      soluong_huy_rohs_ = '0';
      user_finish_spl_ = '';
      user_finish_rohs_ = '';
      ketqua_spl_ = '';
      ketqua_rohs_ = '';
      lblqtyNG = '';
    });

    txtScan.text = mahang;
    txtcodedate.text = codate;
    txtremark.text = remark;
    txtstatus.text = "waiting";
    txtSLNG.text = '';

    if (focusQtyInput) {
      txtrecheck.text = "";
      safeRequestFocus(recheckid);
    } else {
      safeRequestFocus(usersubmitid);
      hideKeyboard();
    }
  }

  // ==================== FIELD HANDLERS ====================

  void codateid_function(String chuoicodedate) {
    safeRequestFocus(remarkid);
    hideKeyboard();
  }

  void remarkid_function(String chuoiremak) {
    safeRequestFocus(soluonghuyid);
    hideKeyboard();
  }

  void recheckid_function(String soluonginput) {
    if (soluonginput.trim().isEmpty ||
        double.tryParse(soluonginput.trim()) == null) {
      thongbaoNG(tr('msgNoLotQty'));
      txtrecheck.text = "";
      safeRequestFocus(recheckid);
      return;
    }

    if (_toDouble(soluonginput) > _toDouble(LotQty)) {
      thongbaoNG(tr('msgQtyOverLot'));
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
        return AlertDialog(
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 10),
              Text(tr('loading')),
            ],
          ),
        );
      },
    ).then((_) => _isLoading = false);
  }

  void Closepending() {
    // Chi dong khi dialog Loading dang mo.
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
          title: Text(tr('notify')),
          content: SingleChildScrollView(
            child: ListBody(children: <Widget>[Text(notify)]),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(tr('yes')),
              onPressed: () => Navigator.of(context).pop(1),
            ),
            TextButton(
              child: Text(tr('no')),
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
      droprecheck = "";

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

      txtcodedate.text = "";
      txtremark.text = "";
      txtsoluonghuy.text = "";
      txtusersubmit.text = "";
      txtstatus.text = "";
      txtpartcard.text = "";
      txtSLNG.text = "";

      txtctrlkey.text = "";
      txtctrlT.text = "";
      lblCtrlkey = "";
      lblCtrlT = "";

      lblbarcodebox = "";
      txtbox.text = "";
      txtqtybox.text = "";

      Barcodeid = "";
      txtrecheck.text = "";

      checkunit = false;
      isboxng = false;
      isScanboxNG = false;
      lblqtyboxid = "0";
    });
    safeRequestFocus(scanid);
  }
}
