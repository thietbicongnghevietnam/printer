import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ControllerAPI/api_IQC.dart';
import '../di/di.dart';
import '../repositories/auth_repository.dart';

class Findlocation extends StatefulWidget {
  const Findlocation({super.key});

  @override
  _ExampleWidgetState createState() => _ExampleWidgetState();
}

class _ExampleWidgetState extends State<Findlocation> {
  String userId = '';

  late DateTime now = DateTime.now();
  late String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(now);

  final txtScan = TextEditingController();
  final FocusNode scanid = FocusNode();

  String lblmaterial = "";
  String lbldeliverydate = "";
  String lblvender = "";
  String lblinvoice = "";
  List<String> locations = [];

  // Co theo doi dialog Loading dang mo hay khong.
  bool _isLoading = false;

  // ==================== HELPERS ====================

  /// Chuyen gia tri bat ky sang String, null => ''.
  String _str(dynamic v) => v == null ? '' : v.toString();

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
  }

  void hideKeyboard() async {
    await Future.delayed(const Duration(milliseconds: 100));
    SystemChannels.textInput.invokeMethod('TextInput.hide');
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

  /// O Location: tu gian chieu cao, moi vi tri la 1 the rieng.
  Widget _locationBox() {
    return InputDecorator(
      isEmpty: locations.isEmpty,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: locations.isEmpty
            ? 'Location'
            : 'Location (${locations.length})',
        contentPadding: const EdgeInsets.fromLTRB(8, 14, 8, 10),
      ),
      child: locations.isEmpty
          ? const SizedBox(height: 20)
          : Wrap(
        spacing: 6,
        runSpacing: 6,
        children: locations
            .map(
              (loc) => Container(
            padding: const EdgeInsets.symmetric(
                horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.08),
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              loc,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
            .toList(),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find material quickly'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- Scan ---
              SizedBox(
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

              const SizedBox(height: 8),
              _infoBox('Material', lblmaterial),

              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                      child: _infoBox('DeliveryDate', lbldeliverydate)),
                  const SizedBox(width: 8),
                  Expanded(child: _infoBox('Invoice', lblinvoice)),
                ],
              ),

              const SizedBox(height: 8),
              _infoBox('Vender', lblvender),

              const SizedBox(height: 8),
              _locationBox(),

              const SizedBox(height: 16),

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

  void _scanError(String msg) {
    thongbaoNG(msg);
    txtScan.text = "";
    safeRequestFocus(scanid);
  }

  Future<void> scanid_function(String chuoibarcode) async {
    try {
      Openpeding();
      final List<Map<String, dynamic>> dtinfor =
      await Query_thongtinbarcode2(chuoibarcode.toString());
      if (!mounted) return;
      Closepending();

      if (dtinfor.isEmpty) {
        _scanError("Chưa có dữ liệu trong IQC, kiểm tra lại!");
        return;
      }

      final firstValues = dtinfor[0].values.toList();
      final String mahang = firstValues.isEmpty ? '' : _str(firstValues[0]);
      if (mahang == '0') {
        _scanError("Kiểm tra lại dữ liệu, liên hệ IT!");
        return;
      }

      final List<String> dsVitri = [];
      String material = "";
      String deliverydate = "";
      String vender = "";
      String invoice = "";

      for (final item in dtinfor) {
        if (item.containsKey('vitri') &&
            item.containsKey('mahang') &&
            item.containsKey('DeliveryDate') &&
            item.containsKey('Vender') &&
            item.containsKey('Invoice')) {
          final String vitri = _str(item['vitri']).trim();
          if (vitri.isNotEmpty && !dsVitri.contains(vitri)) {
            dsVitri.add(vitri);
          }
          material = _str(item['mahang']);
          deliverydate = _str(item['DeliveryDate']);
          vender = _str(item['Vender']);
          invoice = _str(item['Invoice']);
        }
      }

      setState(() {
        locations = dsVitri;
        lblmaterial = material;
        lbldeliverydate = deliverydate;
        lblvender = vender;
        lblinvoice = invoice;
      });

      txtScan.selection =
          TextSelection(baseOffset: 0, extentOffset: txtScan.text.length);
      safeRequestFocus(scanid);
      hideKeyboard();
    } catch (e) {
      Closepending();
      thongbaoNG(e.toString());
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
      txtScan.text = "";
      lblmaterial = "";
      lbldeliverydate = "";
      lblvender = "";
      lblinvoice = "";
      locations = [];
    });
    safeRequestFocus(scanid);
  }
}
