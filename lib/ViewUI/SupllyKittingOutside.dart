import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:smart_warehouse/ControllerAPI/api_IQC.dart';
import 'package:smart_warehouse/ModelUI/class_api_IQC.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';

import '../repositories/auth_repository.dart';

/// Man hinh: scan Kitting Card -> xem thong tin -> Xac nhan cap hang ra ngoai.
class SupllyKittingOutside extends StatefulWidget {
  const SupllyKittingOutside({super.key});

  @override
  State<SupllyKittingOutside> createState() => _SupllyKittingOutsideState();
}

class _SupllyKittingOutsideState extends State<SupllyKittingOutside> {
  final txtScan = TextEditingController();
  final FocusNode scanid = FocusNode();

  // Thong tin lay tu dt[0] - chi xem, khong sua
  final txtMaterial = TextEditingController();
  final txtLine = TextEditingController();
  final txtDeliveryDate = TextEditingController();
  final txtQuantity = TextEditingController();

  String userId = '';
  String scannedBarcode = "";
  KittingCardOutside? kittingCard;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    autogetuser();
    _hideKeyboard();
  }

  @override
  void dispose() {
    txtScan.dispose();
    scanid.dispose();

    txtMaterial.dispose();
    txtLine.dispose();
    txtDeliveryDate.dispose();
    txtQuantity.dispose();

    super.dispose();
  }

  // Future<void> autogetuser() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final String id = await getIt<AuthRepository>().getUserID();
  //   if (!mounted) return;
  //   setState(() => userId = id);
  //   debugPrint('[SupllyKittingOutside] user: $userId');
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

  void _hideKeyboard() async {
    await Future.delayed(const Duration(milliseconds: 100));
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  void _focusScan() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      FocusScope.of(context).requestFocus(scanid);
    });
  }

  // ==================== DIALOGS ====================

  /// Hop thoai loi: noi dung cuon duoc + cat ngan, khong bao gio tran man hinh.
  Future<void> _showError(String message) async {
    debugPrint('[SupllyKittingOutside] $message');
    if (!mounted) return;

    String msg = message.replaceFirst('Exception: ', '');
    if (msg.length > 300) msg = '${msg.substring(0, 300)}...';

    await showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: Colors.red,
        content: SingleChildScrollView(
          child: Text(
            msg,
            style: const TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Đóng', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _openLoading() {
    if (!mounted || _isLoading) return;
    _isLoading = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const AlertDialog(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 10),
            Text('Loading...'),
          ],
        ),
      ),
    ).then((_) => _isLoading = false);
  }

  void _closeLoading() {
    if (!mounted || !_isLoading) return;
    _isLoading = false;
    Navigator.of(context, rootNavigator: true).pop();
  }

  // ==================== LOGIC ====================

  /// Do du lieu tu Kitting Card (dt[0]) vao cac o thong tin.
  void _fillCardInfo(KittingCardOutside? card) {
    txtMaterial.text = card?.material ?? '';
    txtLine.text = card?.line ?? '';
    txtDeliveryDate.text = card?.deliveryDate ?? '';
    txtQuantity.text = card?.quantity ?? '';
  }

  /// Goi API lay thong tin Kitting Card.
  Future<KittingCardOutside?> _fetchKittingCard(String barcode, String userId) async {
    final List<Map<String, dynamic>> dt =
    await Query_KittingCard_Outside(barcode,userId);

    debugPrint('[KC fetch] $barcode -> ${dt.isEmpty ? 'RONG' : dt.first}');

    if (dt.isEmpty) return null;
    final card = KittingCardOutside.fromMap(dt[0]);
    return card.isFound ? card : null;
  }

  /// Scan xong: lay thong tin Kitting Card ve de kiem tra.
  Future<void> _onScan(String value) async {
    final String barcode = value.trim();
    if (barcode.isEmpty) return;

    _openLoading();
    try {
      final card = await _fetchKittingCard(barcode,userId);
      if (!mounted) return;
      _closeLoading();

      if (card == null) {
        _showError('Không tìm thấy Kitting Card này!');
        setState(() {
          txtScan.text = "";
          scannedBarcode = "";
          kittingCard = null;
          _fillCardInfo(null);
        });
        _focusScan();
        return;
      }

      setState(() {
        scannedBarcode = barcode;
        kittingCard = card;
        _fillCardInfo(card);
      });
      txtScan.selection =
          TextSelection(baseOffset: 0, extentOffset: txtScan.text.length);
      _focusScan();
      _hideKeyboard();
    } catch (e) {
      _closeLoading();
      _showError(e.toString());
    }
  }

  /// Bam Xac nhan: gui len server.
  /// Bam Xac nhan: gui len server.
  Future<void> _onConfirm() async {
    if (txtScan.text.trim().isEmpty) {
      _showError('Vui lòng quét Kitting Card');
      _focusScan();
      return;
    }

    // Truong hop go tay ma chua Enter => tu lay du lieu truoc
    if (kittingCard == null || scannedBarcode != txtScan.text.trim()) {
      await _onScan(txtScan.text);
      if (!mounted || kittingCard == null) return;
    }

    _openLoading();
    try {
      final row = await Update_SupplyKittingOutside(
        barcode: scannedBarcode,
        line: txtLine.text.trim(),
        userName: userId,
      );
      if (!mounted) return;
      _closeLoading();

      final lower = <String, String>{
        for (final e in row.entries)
          e.key.toLowerCase(): (e.value ?? '').toString().trim(),
      };
      final String kq = lower['kq'] ?? '';
      final String msg = lower['message'] ?? lower['msg'] ?? '';

      if (row.isEmpty) {
        _showError('Server không trả về kết quả, kiểm tra lại!');
        return;
      }

      if (kq == '0' || kq.toLowerCase() == 'false') {
        _showError(msg.isEmpty ? 'Server từ chối dữ liệu, kiểm tra lại!' : msg);
        return;
      }

      getIt<AppAlertDialog>().show(
        context,
        message: msg.isEmpty ? 'Xác nhận thành công' : msg,
        onConfirm: _clear,
      );
    } catch (e) {
      _closeLoading();
      _showError(e.toString());
    }
  }

  void _clear() {
    if (!mounted) return;
    setState(() {
      txtScan.text = "";
      scannedBarcode = "";
      kittingCard = null;
      _fillCardInfo(null);
    });
    _focusScan();
  }

  // ==================== UI ====================

  /// O thong tin chi doc, lay tu dt[0].
  Widget _infoField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      readOnly: true,
      style: const TextStyle(fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        isDense: true,
        filled: true,
        fillColor: Colors.grey.shade200,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
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
    final card = kittingCard;

    return Scaffold(
      appBar: AppBar(title: const Text('Supply Kitting Outside')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 50,
                child: TextField(
                  autofocus: true,
                  controller: txtScan,
                  focusNode: scanid,
                  showCursor: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Scan Kitting Card',
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  ),
                  onSubmitted: _onScan,
                ),
              ),

              const SizedBox(height: 12),

              Row(
                children: [
                  const Icon(Icons.info_outline,
                      size: 18, color: Colors.blueGrey),
                  const SizedBox(width: 4),
                  Text(
                    card == null
                        ? 'Thông tin Kitting Card'
                        : '(kiểm tra trước khi xác nhận)',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blueGrey),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              card == null
                  ? Container(
                height: 160,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Quét Kitting Card để xem thông tin',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              )
                  : Column(
                children: [
                  _infoField('Material', txtMaterial),
                  const SizedBox(height: 8),
                  _infoField('Line', txtLine),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                          child: _infoField(
                              'Delivery date', txtDeliveryDate)),
                      const SizedBox(width: 8),
                      Expanded(child: _infoField('Qty', txtQuantity)),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(child: _smallButton('Xác nhận', _onConfirm)),
                  const SizedBox(width: 4),
                  Expanded(child: _smallButton('Clear', _clear)),
                  const SizedBox(width: 4),
                  Expanded(
                    child: _smallButton(
                        'Exit', () => Navigator.of(context).pop()),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
