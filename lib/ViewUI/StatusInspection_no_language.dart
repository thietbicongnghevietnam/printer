import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ControllerAPI/api_IQC.dart';
import '../ModelUI/class_api_IQC.dart';
import '../di/di.dart';
import '../repositories/auth_repository.dart';

class StatusInspection extends StatefulWidget {
  const StatusInspection({super.key});

  @override
  _ExampleWidgetState createState() => _ExampleWidgetState();
}

class _ExampleWidgetState extends State<StatusInspection> {
  String userId = '';

  late DateTime now = DateTime.now();
  late String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(now);

  final txtScan = TextEditingController();
  final FocusNode scanid = FocusNode();

  String lblbarcode = "";
  String lblmaterial = "";
  String lblincomingdate = "";

  String lblvitri = "";
  String lblLotQty = "";
  String lblplant = "";
  String lbldeliverydate = "";
  String lblDANo = "";
  String lblPONo = "";
  String lblVender = "";
  String lblCtrlkey = "";
  String lblCtrlT = "";
  String lblsloc = "";
  String lblLotdate = "";
  String lblCateQC = "";
  String lblinvoice = "";
  String lblid = "";
  String lblcodate = "";
  String lblremark = "";
  String lblstatus = "";

  String lblhuyspl = "";
  String lblhuyrohs = "";

  String ketqua_SPL = "";
  String ketqua_ROHS = "";

  // Chu hien thi trong o trang thai Sample / ROHS
  String txtSPLStatus = "";
  String txtROHSStatus = "";

  String ParallelStatus = "0";
  String ParallelStatus2 = "0";
  String ParallelStatus3 = "0";
  String ParallelStatus4 = "0";

  Color _boxColor2 = Colors.white;
  Color _boxColor3 = Colors.white;

  List<Get_Recheck> Rechecklist = [];

  // null = chua chon. DropdownButton bat buoc value phai null
  // hoac trung voi 1 item, neu khong se crash.
  String? droprecheck;

  // Co theo doi dialog Loading dang mo hay khong.
  bool _isLoading = false;

  // ==================== HELPERS ====================

  /// Lay gia tri cot an toan: null / vuot index => ''.
  String _cell(List<dynamic> row, int index) {
    if (index < 0 || index >= row.length) return '';
    final v = row[index];
    return v == null ? '' : v.toString();
  }

  /// Lay dong dau tien cua ket qua API, rong => null.
  List<dynamic>? _firstRow(List<Map<String, dynamic>> dt) =>
      dt.isEmpty ? null : dt[0].values.toList();

  /// Danh sach ten loai recheck, bo trung lap.
  List<String> get _dropItems => Rechecklist
      .map((e) => e.NameRecheck.toString())
      .where((e) => e.isNotEmpty)
      .toSet()
      .toList();

  // Future<void> autogetuser() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   if (!mounted) return;
  //   setState(() async {
  //     //userId = prefs.getString('username') ?? '';
  //     userId = await getIt<AuthRepository>().getUserID();
  //   });
  // }

  Future<void> autogetuser() async {
    // final SharedPreferences prefs = await SharedPreferences.getInstance();
    // final id = prefs.getString('username') ?? '';
    final id = await getIt<AuthRepository>().getUserID();
    print(id);

    if (!mounted) return;
    setState(() {
      userId = id;
    });
  }

  @override
  void initState() {
    super.initState();
    autogetuser();
    hideKeyboard();
    tally_get_recheck();
  }

  Future<void> tally_get_recheck() async {
    try {
      final temp = await Freelocation_get_recheck();
      if (!mounted) return;
      setState(() {
        Rechecklist = temp ?? <Get_Recheck>[];
      });
    } catch (e) {
      // Loi lay danh sach => dropdown de trong, khong crash man hinh
    }
  }

  void hideKeyboard() async {
    await Future.delayed(const Duration(milliseconds: 100));
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  /// Tinh chu + mau cho o trang thai Sample (logic giu nguyen nhu cu).
  void _tinhTrangThaiSPL() {
    final String t = ketqua_SPL;
    String text = t;
    Color color = Colors.white;

    if (ParallelStatus == "1" && ParallelStatus2 == "0") {
      color = Colors.greenAccent; // checking
      text = "Checking";
    } else if (ParallelStatus == "1" && ParallelStatus2 == "1" && t == "OK") {
      color = Colors.green; // finished OK
    } else if (ParallelStatus == "1" && ParallelStatus2 == "1" && t == "NG") {
      color = Colors.red; // finished NG
    } else if (lblCateQC == '0' && t == "NG") {
      color = Colors.red; // non inspection NG
    } else if (lblCateQC == '0' && t == "OK") {
      color = Colors.green; // non inspection OK
    } else if (lblCateQC == '3' || (lblCateQC == '0' && t == 'NULL')) {
      color = Colors.white70;
      text = "NA";
    } else if ((lblCateQC == '1' || lblCateQC == '2') &&
        ParallelStatus == "0" &&
        ParallelStatus2 == "0") {
      color = Colors.yellow;
      text = "Waiting";
    }

    _boxColor2 = color;
    txtSPLStatus = text;
  }

  /// Tinh chu + mau cho o trang thai ROHS (logic giu nguyen nhu cu).
  void _tinhTrangThaiROHS() {
    final String t = ketqua_ROHS;
    String text = t;
    Color color = Colors.white;

    if (ParallelStatus3 == "1" && ParallelStatus4 == "0") {
      color = Colors.greenAccent; // checking
      text = "Checking";
    } else if (ParallelStatus3 == "1" && ParallelStatus4 == "1" && t == "OK") {
      color = Colors.green;
    } else if (ParallelStatus3 == "1" && ParallelStatus4 == "1" && t == "NG") {
      color = Colors.red;
    } else if (lblCateQC == '0' && t == "NG") {
      color = Colors.red;
    } else if (lblCateQC == '0' && t == "OK") {
      color = Colors.green;
    } else if (lblCateQC == '1' || lblCateQC == '0') {
      color = Colors.white70;
      text = "NA";
    } else if ((lblCateQC == '2' || lblCateQC == '3') &&
        ParallelStatus3 == "0" &&
        ParallelStatus4 == "0") {
      color = Colors.yellow;
      text = "Waiting";
    }

    _boxColor3 = color;
    txtROHSStatus = text;
  }

  @override
  void dispose() {
    txtScan.dispose();
    scanid.dispose();
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

  /// O hien thi thong tin (chi doc), co nhan giong TextField.
  Widget _infoBox(String label, String value, {Color? fillColor}) {
    return SizedBox(
      height: 50,
      child: InputDecorator(
        isEmpty: value.isEmpty,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
          filled: fillColor != null,
          fillColor: fillColor,
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

  Widget _buildTypeDropdown() {
    final items = _dropItems;
    final String? currentValue =
    items.contains(droprecheck) ? droprecheck : null;

    return SizedBox(
      height: 50,
      child: InputDecorator(
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Type',
          contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<String>(
            isExpanded: true,
            isDense: true,
            value: currentValue,
            hint: const Text('Type'),
            items: items
                .map((name) => DropdownMenuItem<String>(
              value: name,
              child: Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 15),
              ),
            ))
                .toList(),
            onChanged: (newVal) {
              setState(() => droprecheck = newVal);
              safeRequestFocus(scanid);
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Status Inspection IQC'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- Scan + Type ---
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 50,
                      child: TextField(
                        autofocus: true,
                        controller: txtScan,
                        focusNode: scanid,
                        showCursor: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Scan RecevingCard',
                          contentPadding:
                          EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                        ),
                        onSubmitted: scanid_function,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(flex: 2, child: _buildTypeDropdown()),
                ],
              ),

              const SizedBox(height: 8),

              // --- Material ---
              _infoBox('Material', lblmaterial),

              const SizedBox(height: 8),

              // --- Invoice / Scrap SPL ---
              Row(
                children: [
                  Expanded(flex: 3, child: _infoBox('Invoice', lblinvoice)),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 2,
                    child: _infoBox(
                        'Scrap SPL', lblhuyspl.isEmpty ? '0' : lblhuyspl),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // --- Date / Scrap Rohs ---
              Row(
                children: [
                  Expanded(flex: 3, child: _infoBox('Date', lblincomingdate)),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 2,
                    child: _infoBox(
                        'Scrap Rohs', lblhuyrohs.isEmpty ? '0' : lblhuyrohs),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // --- Location / Qty Lot ---
              Row(
                children: [
                  Expanded(flex: 3, child: _infoBox('Location', lblvitri)),
                  const SizedBox(width: 8),
                  Expanded(flex: 2, child: _infoBox('Qty Lot', lblLotQty)),
                ],
              ),

              const SizedBox(height: 8),

              // --- Code date / CtrlKey ---
              Row(
                children: [
                  Expanded(flex: 3, child: _infoBox('Code date', lblcodate)),
                  const SizedBox(width: 8),
                  Expanded(flex: 2, child: _infoBox('CtrlKey', lblCtrlkey)),
                ],
              ),

              const SizedBox(height: 8),

              // --- Remark / CtrlT ---
              Row(
                children: [
                  Expanded(flex: 3, child: _infoBox('Remark', lblremark)),
                  const SizedBox(width: 8),
                  Expanded(flex: 2, child: _infoBox('CtrlT', lblCtrlT)),
                ],
              ),

              const SizedBox(height: 8),

              // --- Trang thai Sample / ROHS ---
              Row(
                children: [
                  Expanded(
                    child: _infoBox('Sample', txtSPLStatus,
                        fillColor: _boxColor2),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: _infoBox('ROHS', txtROHSStatus,
                        fillColor: _boxColor3),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // --- Buttons: nut nho, tren 1 hang ---
              Row(
                children: [
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

  // ==================== SCAN ====================

  Future<void> scanid_function(String chuoibarcode) async {
    try {
      final String typerecheck = droprecheck ?? "";

      Openpeding();
      final List<Map<String, dynamic>> dtinfor =
      await Query_thongtinbarcode(chuoibarcode.toString(), typerecheck);
      if (!mounted) return;
      Closepending();

      final row = _firstRow(dtinfor);
      if (row == null) {
        thongbaoNG("Chưa có dữ liệu trong IQC, kiểm tra lại!");
        reset();
        return;
      }

      final String mahang = _cell(row, 0);
      if (mahang == '0') {
        thongbaoNG("Chưa có dữ liệu trong IQC! kiểm tra lại!");
        txtScan.text = "";
        safeRequestFocus(scanid);
        return;
      }

      final String _Recheck = _cell(row, 26);

      setState(() {
        if (_Recheck == "recheck") {
          droprecheck = "recheck";
        } else if (_Recheck == "Hang1Nam") {
          droprecheck = "Hang1Nam";
        } else {
          droprecheck = null;
        }

        lblbarcode = chuoibarcode;
        lblmaterial = mahang;
        lblinvoice = _cell(row, 1);
        lblvitri = _cell(row, 3);
        lblLotQty = _cell(row, 4);
        lblid = _cell(row, 5);
        lblcodate = _cell(row, 6);
        lblremark = _cell(row, 7);
        lblhuyspl = _cell(row, 8);
        lblhuyrohs = _cell(row, 9);
        ketqua_SPL = _cell(row, 12);
        ketqua_ROHS = _cell(row, 13);
        lblstatus = _cell(row, 14);
        lblplant = _cell(row, 15);
        lbldeliverydate = _cell(row, 16);
        lblincomingdate = lbldeliverydate;
        lblDANo = _cell(row, 17);
        lblPONo = _cell(row, 18);
        lblVender = _cell(row, 19);
        lblCtrlkey = _cell(row, 20);
        lblCtrlT = _cell(row, 21);
        lblsloc = _cell(row, 22);
        lblLotdate = _cell(row, 23);
        lblCateQC = _cell(row, 24);

        ParallelStatus = _cell(row, 27);
        ParallelStatus2 = _cell(row, 28);
        ParallelStatus3 = _cell(row, 29);
        ParallelStatus4 = _cell(row, 30);

        _tinhTrangThaiSPL();
        _tinhTrangThaiROHS();
      });

      txtScan.text = mahang;
      txtScan.selection =
          TextSelection(baseOffset: 0, extentOffset: txtScan.text.length);
      safeRequestFocus(scanid);
      hideKeyboard();
    } catch (e) {
      Closepending();
      thongbaoNG(e.toString());
      reset();
    }
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

  // ==================== RESET ====================

  void reset() {
    if (!mounted) return;
    setState(() {
      lblbarcode = "";
      lblmaterial = "";
      lblvitri = "";
      lblLotQty = "";
      lblplant = "";
      lbldeliverydate = "";
      lblincomingdate = "";
      lblDANo = "";
      lblPONo = "";
      lblVender = "";
      lblCtrlkey = "";
      lblCtrlT = "";
      lblsloc = "";
      lblLotdate = "";
      lblCateQC = "";
      lblinvoice = "";
      lblid = "";
      lblcodate = "";
      lblremark = "";
      lblstatus = "";

      lblhuyspl = "";
      lblhuyrohs = "";

      ketqua_SPL = "";
      ketqua_ROHS = "";
      txtSPLStatus = "";
      txtROHSStatus = "";

      txtScan.text = "";
      droprecheck = null;

      _boxColor2 = Colors.white;
      _boxColor3 = Colors.white;

      ParallelStatus = "0";
      ParallelStatus2 = "0";
      ParallelStatus3 = "0";
      ParallelStatus4 = "0";
    });
    safeRequestFocus(scanid);
  }
}
