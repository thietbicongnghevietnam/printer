import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:smart_warehouse/ControllerAPI/api_IQC.dart';
import 'package:smart_warehouse/ModelUI/class_api_IQC.dart';
import 'package:smart_warehouse/di/di.dart';
import 'package:smart_warehouse/shared/utils/alert.dart';
import 'package:smart_warehouse/subsystem/printer/printer.dart';
import 'package:smart_warehouse/subsystem/printer/receiving_card_template.dart';

import '../repositories/auth_repository.dart';

/// Nguon de in lai Receiving Card.
enum ReprintSource {
  // Thu tu o day = thu tu hien thi tren man hinh
  receivingCard('ReceivingCard', 'Receiving Card'),
  kittingCard('KittingCard', 'Kitting Card');

  const ReprintSource(this.code, this.label);

  final String code; // gui len API
  final String label; // hien thi
}

class PrintReceivingCardPage extends StatefulWidget {
  const PrintReceivingCardPage({super.key});

  @override
  State<PrintReceivingCardPage> createState() => _PrintReceivingCardPageState();
}

class _PrintReceivingCardPageState extends State<PrintReceivingCardPage> {
  final txtScan = TextEditingController();
  final FocusNode scanid = FocusNode();
  String userId = '';

  // Thong tin lay tu dt[0] - chi xem, khong sua
  final txtMaterial = TextEditingController();
  final txtQuantity = TextEditingController();
  final txtSloc = TextEditingController();

  // Nguoi dung nhap / chon
  final txtRepLoc = TextEditingController();
  final FocusNode repLocFocus = FocusNode();

  List<String> tcodes = const [];
  List<String> reasons = const [];

  String? tcode;   // null = chua chon
  String? reason;
  bool loadingList = false;



  ReprintSource source = ReprintSource.receivingCard; // mac dinh

  String scannedBarcode = "";
  ReceivingCardIQC? receivingCard;

  List<PrinterDevice> printerDevices = [];
  //PrinterDevice? savedPrinterDevice;

  /// May in da dung gan nhat. static => van nho khi thoat trang roi vao lai.
  static PrinterDevice? _savedPrinter;

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    autogetuser();
    _hideKeyboard();
    _loadCombos();
  }

  @override
  void dispose() {
    txtScan.dispose();
    scanid.dispose();

    txtMaterial.dispose();
    txtQuantity.dispose();
    txtSloc.dispose();
    txtRepLoc.dispose();
    repLocFocus.dispose();

    super.dispose();
  }

  Future<void> autogetuser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (!mounted) return;
    setState(() async {
      //userId = prefs.getString('username') ?? '';
      userId = await getIt<AuthRepository>().getUserID();
      print(userId);
    });
  }

  /// Nap Tcode (DM_Tcode) va Ly do (DM_lydo311) tu server.
  Future<void> _loadCombos() async {
    setState(() => loadingList = true);
    try {
      final results = await Future.wait([
        Query_List_Tcode(),
        Query_List_Lydo311(),
      ]);
      if (!mounted) return;

      final t = _codesFrom(results[0]);
      final r = _codesFrom(results[1]);

      setState(() {
        tcodes = t;
        reasons = r;
        if (!t.contains(tcode)) tcode = t.isEmpty ? null : t.first;
        if (!r.contains(reason)) reason = r.isEmpty ? null : r.first;
      });
    } catch (e) {
      if (mounted) _showError('Không tải được danh sách Tcode / Lý do: $e');
    } finally {
      if (mounted) setState(() => loadingList = false);
    }
  }

  void _hideKeyboard() async {
    await Future.delayed(const Duration(milliseconds: 100));
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  /// Do du lieu tu Receiving Card (dt[0]) vao cac o thong tin.
  void _fillCardInfo(ReceivingCardIQC? card) {
    txtMaterial.text = card?.material ?? '';
    txtQuantity.text = card == null
        ? ''
        : (card.currentQuantity.isNotEmpty
        ? card.currentQuantity
        : card.totalQuantity);
    txtSloc.text = card?.sloc ?? '';
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
    debugPrint('[PrintReceivingCard] $message'); // xem day du trong Run/Debug console
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

  /// Popup chon may in: scan nhan ten may in (VD: VT 003514) de chon luon,
  /// hoac cham chon trong danh sach roi bam In.
  Future<PrinterDevice?> _choosePrinter([ReceivingCardIQC? card]) {
    return showDialog<PrinterDevice>(
      context: context,
      builder: (_) => PrinterPickerDialog(
        printers: printerDevices,
        initialMacAddress: _savedPrinter?.macAddress,
        subtitle:
        card == null ? '' : '${card.material}  -  Qty ${card.quantity}',
      ),
    );
  }

  /// Nap lai danh sach may in roi cho chon. null = huy hoac khong co may in.
  Future<PrinterDevice?> _pickPrinter([ReceivingCardIQC? card]) async {
    //_openLoading();
    try {
      final devices = await _fetchPrinterDevices();
      if (!mounted) return null;
      _closeLoading();
      setState(() => printerDevices = devices);
    } catch (e) {
      //_closeLoading();
      _showError(e.toString());
      return null;
    }

    if (printerDevices.isEmpty) {
      _showError('Chưa có máy in nào trong danh sách (tblPrinterDevice)!');
      return null;
    }
    return _choosePrinter(card);
  }

  /// Store chi tra ve 1 cot (Tcode / Lydo) => lay gia tri cua cot dau tien.
  List<String> _codesFrom(List<Map<String, dynamic>> rows) {
    final result = <String>[];
    final seen = <String>{};

    for (final row in rows) {
      if (row.isEmpty) continue;
      final s = (row.values.first ?? '').toString().trim();
      if (s.isEmpty || s.toLowerCase() == 'null') continue;
      if (seen.add(s.toUpperCase())) result.add(s);
    }
    return result;
  }

  /// Nut "Doi may in" tren man hinh.
  Future<void> _changePrinter() async {
    final device = await _pickPrinter(receivingCard);
    if (device == null || !mounted) return;
    setState(() => _savedPrinter = device);
  }

  /// Kiem tra Bluetooth truoc khi in.
  Future<bool> _ensureBluetooth() async {
    final bool btOn = await FlutterBluetoothSerial.instance.isEnabled ?? false;
    if (!btOn) {
      await _showError('Bluetooth đang tắt, vui lòng bật Bluetooth!');
      return false;
    }
    return true;
  }


  // ==================== LOGIC ====================

  /// Goi API lay Receiving Card. typeSource mac dinh theo nguon dang chon.
  Future<ReceivingCardIQC?> _fetchReceivingCard(String barcode,
      {String? typeSource}) async {
    final List<Map<String, dynamic>> dt =
    await Query_ReceivingCard_Reprint(barcode, typeSource ?? source.code);

    debugPrint('[RC fetch] $barcode -> ${dt.isEmpty ? 'RONG' : dt.first}');

    if (dt.isEmpty) return null;
    final card = ReceivingCardIQC.fromMap(dt[0]);
    return card.isFound ? card : null;
  }

  /// Danh sach may in tu bang tblPrinterDevice (ID = ten nhan, MacAddress).
  Future<List<PrinterDevice>> _fetchPrinterDevices() async {
    final List<Map<String, dynamic>> dt = await Query_PrinterDevice_List();

    final result = <PrinterDevice>[];
    final seenMac = <String>{};

    for (final row in dt) {
      final lower = <String, dynamic>{
        for (final e in row.entries) e.key.toLowerCase(): e.value,
      };
      final String id = (lower['id'] ?? '').toString().trim();
      final String mac = (lower['macaddress'] ?? '').toString().trim();
      if (id.isEmpty || mac.isEmpty || id == 'null' || mac == 'null') continue;

      // Bo may in trung MacAddress
      if (seenMac.add(mac.toUpperCase())) {
        result.add(PrinterDevice(id: id, macAddress: mac));
      }
    }

    result.sort((x, y) => x.id.compareTo(y.id));
    return result;
  }

  /// Scan xong: lay Receiving Card ve de xem truoc.
  Future<void> _onScan(String value) async {
    final String barcode = value.trim();
    if (barcode.isEmpty) return;

    _openLoading();
    try {
      final card = await _fetchReceivingCard(barcode);
      if (!mounted) return;
      _closeLoading();

      if (card == null) {
        _showError('Không tìm thấy Receiving Card từ ${source.label} này!');
        setState(() {
          txtScan.text = "";
          scannedBarcode = "";
          receivingCard = null;
          _fillCardInfo(null);       // <-- them
        });
        _focusScan();
        return;
      }

      setState(() {
        scannedBarcode = barcode;
        receivingCard = card;
        _fillCardInfo(card);         // <-- them
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

  /// Gui thong tin len server truoc khi in. true = server nhan OK.
  /// Gui thong tin len server. Tra ve barcode moi, null neu that bai.
  Future<String?> _saveToServer() async {
    _openLoading();
    try {
      final row = await Insert_ReceivingCard_RepLoc(
        barcode: scannedBarcode,
        typeSource: source.code,
        plant: receivingCard?.plant ?? '',
        material: txtMaterial.text.trim(),
        quantity: txtQuantity.text.trim(),
        sloc: txtSloc.text.trim(),
        repLoc: txtRepLoc.text.trim(),
        tcode: tcode ?? '',
        reason: reason ?? '',
        userName: userId,
      );
      if (!mounted) return null;
      _closeLoading();

      final lower = <String, String>{
        for (final e in row.entries)
          e.key.toLowerCase(): (e.value ?? '').toString().trim(),
      };
      final String kq = lower['kq'] ?? '';
      final String msg = lower['message'] ?? lower['msg'] ?? '';
      final String newBarcode = lower['barcode'] ?? '';

      if (kq == '0' || kq.toLowerCase() == 'false') {
        _showError(msg.isEmpty ? 'Server từ chối dữ liệu, kiểm tra lại!' : msg);
        return null;
      }
      if (newBarcode.isEmpty) {
        _showError('Server không trả về barcode mới!');
        return null;
      }
      return newBarcode;
    } catch (e) {
      _closeLoading();
      _showError(e.toString());
      return null;
    }
  }

  /// Bam Xac nhan: chon may in roi in.
  Future<void> _onConfirm() async {
    if (txtScan.text.trim().isEmpty) {
      _showError('Vui lòng quét ${source.label}');
      _focusScan();
      return;
    }

    if (receivingCard == null || scannedBarcode != txtScan.text.trim()) {
      await _onScan(txtScan.text);
      if (!mounted || receivingCard == null) return;
    }

    if (txtRepLoc.text.trim().isEmpty) {
      _showError('Vui lòng nhập RepLoc');
      repLocFocus.requestFocus();
      return;
    }

    if (tcode == null || reason == null) {
      _showError('Vui lòng chọn Tcode và Reason');
      return;
    }

    final int qty = int.tryParse(txtQuantity.text.trim()) ?? 0;
    if (qty <= 0) {
      _showError('Số lượng không hợp lệ!');
      return;
    }

    final int qtyGoc = int.tryParse(receivingCard!.currentQuantity.isNotEmpty
        ? receivingCard!.currentQuantity
        : receivingCard!.totalQuantity) ??
        0;
    if (qtyGoc > 0 && qty > qtyGoc) {
      _showError('Số lượng nhập ($qty) lớn hơn số lượng gốc ($qtyGoc)!');
      return;
    }

    if (!await _ensureBluetooth() || !mounted) return;

    // Ghi nhan len server truoc, server OK moi in tem
    //if (!await _saveToServer() || !mounted) return;

    // Ghi nhan len server, lay barcode moi roi nap lai the moi de in
    final String? newBarcode = await _saveToServer();
    //_openLoading();
    if (newBarcode == null || !mounted) return;
    try {
      //final newCard = await _fetchReceivingCard(newBarcode);

      final newCard = await _fetchReceivingCard(newBarcode, typeSource: 'ReceivingCard');

      if (!mounted) return;
      //_closeLoading();

      if (newCard == null) {
        _showError('Đã tạo Receiving Card mới ($newBarcode) '
            'nhưng không đọc được dữ liệu để in, báo IT!');
        return;
      }
      setState(() {
        scannedBarcode = newBarcode;
        receivingCard = newCard;
        _fillCardInfo(newCard);   // cap nhat lai cac o tren man hinh
      });
    } catch (e) {
      //_closeLoading();
      _showError(e.toString());
      return;
    }

    // Da co may in cu => in luon, khong hoi lai
    if (_savedPrinter != null) {
      final ok = await _print(_savedPrinter!, receivingCard!, showError: false);
      if (!mounted) return;
      if (ok) {
        _printDone();
        return;
      }
      await _showError(
          'Không in được với máy in ${_savedPrinter!.id}, vui lòng chọn lại máy in!');
      if (!mounted) return;
    }

    final device = await _pickPrinter(receivingCard);
    if (device == null || !mounted) return;

    final ok = await _print(device, receivingCard!);
    if (!ok || !mounted) return;
    _printDone();
  }

  void _printDone() {
    getIt<AppAlertDialog>().show(
      context,
      message: 'In lại thành công',
      onConfirm: _clear,
    );
  }

  /// Ket noi va in. Tra ve true neu in thanh cong.
  Future<bool> _print(PrinterDevice device, ReceivingCardIQC card,
      {bool showError = true}) async {

    final Map<String, String> values = card.toTemplateValues();
    values['txtQuantity'] = txtQuantity.text.trim(); // so luong nguoi dung sua

    final String command;
    try {
      //command = ReceivingCardTemplate.build(card.toTemplateValues());
      command = ReceivingCardTemplate.build(values);
    } catch (e) {
      _showError('Lỗi template tem: $e');
      return false;
    }

    //_openLoading();
    try {
      final printer = getIt<Printer>();
      await printer.connect(device);
      await printer.print(device, command);
      if (!mounted) return false;
      //_closeLoading();
      setState(() => _savedPrinter = device); // nho may in cho lan in sau
      return true;
    } catch (e) {
      //_closeLoading();
      if (showError) {
        _showError(
            'Không in được, kiểm tra máy in ${device.id} đã bật và ở gần PDA!');
      }
      return false;
    }
  }

  void _clear() {
    if (!mounted) return;
    setState(() {
      txtScan.text = "";
      scannedBarcode = "";
      receivingCard = null;

      _fillCardInfo(null);
      txtRepLoc.clear();

    });
    _focusScan();
  }

  void _changeSource(ReprintSource value) {
    if (value == source) return;
    setState(() {
      source = value;
      // Doi nguon thi du lieu cu khong con dung
      txtScan.text = "";
      scannedBarcode = "";
      receivingCard = null;

      _fillCardInfo(null);
      txtRepLoc.clear();

    });
    _focusScan();
  }

  // ==================== UI ====================

  Widget _sourceOption(ReprintSource value) {
    return InkWell(
      onTap: () => _changeSource(value),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Radio<ReprintSource>(
            value: value,
            groupValue: source,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
            onChanged: (v) {
              if (v != null) _changeSource(v);
            },
          ),
          Text(value.label),
          const SizedBox(width: 12),
        ],
      ),
    );
  }

  /// O so luong cho phep sua, chi nhan chu so.
  Widget _quantityField() {
    return TextField(
      controller: txtQuantity,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      style: const TextStyle(fontWeight: FontWeight.bold),
      onTap: () => txtQuantity.selection = TextSelection(
        baseOffset: 0,
        extentOffset: txtQuantity.text.length,
      ), // cham vao la boi den de go de
      decoration: InputDecoration(
        labelText: 'CurrentQuantity',
        border: const OutlineInputBorder(),
        isDense: true,
        contentPadding:
        const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        suffixIcon: IconButton(
          icon: const Icon(Icons.restore, size: 20),
          tooltip: 'Lấy lại số lượng gốc',
          onPressed: () => setState(() {
            final card = receivingCard;
            txtQuantity.text = card == null
                ? ''
                : (card.currentQuantity.isNotEmpty
                ? card.currentQuantity
                : card.totalQuantity);
          }),
        ),
      ),
    );
  }

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

  /// Combobox chon gia tri co san.
  Widget _combo(String label, String? value, List<String> items,
      ValueChanged<String> onPicked) {
    return DropdownButtonFormField<String>(
      value: items.contains(value) ? value : null,
      isDense: true,
      isExpanded: true,
      hint: Text(loadingList ? 'Đang tải...' : 'Chọn $label'),
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        suffixIcon: loadingList
            ? const Padding(
          padding: EdgeInsets.all(12),
          child: SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(strokeWidth: 2)),
        )
            : (items.isEmpty
            ? IconButton(
          icon: const Icon(Icons.refresh),
          tooltip: 'Tải lại danh sách',
          onPressed: _loadCombos,
        )
            : null),
      ),
      items: items
          .map((e) => DropdownMenuItem<String>(
        value: e,
        child: Text(e, maxLines: 1, overflow: TextOverflow.ellipsis),
      ))
          .toList(),
      onChanged: loadingList
          ? null
          : (v) {
        if (v != null) setState(() => onPicked(v));
      },
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
    final card = receivingCard;

    return Scaffold(
      appBar: AppBar(title: const Text('Print Receiving Card')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'In lại từ:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: ReprintSource.values.map(_sourceOption).toList(),
              ),

              const SizedBox(height: 8),

              SizedBox(
                height: 50,
                child: TextField(
                  autofocus: true,
                  controller: txtScan,
                  focusNode: scanid,
                  showCursor: true,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Scan ${source.label}',
                    contentPadding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                  ),
                  onSubmitted: _onScan,
                ),
              ),

              // thong tin receving card
              const SizedBox(height: 10),

              _infoField('Material', txtMaterial),
              const SizedBox(height: 8),

              Row(
                children: [
                  Expanded(child: _quantityField()),
                  const SizedBox(width: 8),
                  Expanded(child: _infoField('Sloc', txtSloc)),
                ],
              ),
              const SizedBox(height: 8),

              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: TextField(
                      controller: txtRepLoc,
                      focusNode: repLocFocus,
                      textCapitalization: TextCapitalization.characters,
                      decoration: const InputDecoration(
                        labelText: 'RepLoc',
                        hintText: 'Scan / nhập RepLoc',
                        border: OutlineInputBorder(),
                        isDense: true,
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                      ),
                      onSubmitted: (_) => repLocFocus.unfocus(),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 2,
                    child: _combo('Tcode', tcode, tcodes, (v) => tcode = v),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              _combo('Reason', reason, reasons, (v) => reason = v),

              const SizedBox(height: 10),

              Row(
                children: [
                  const Icon(Icons.visibility, size: 18, color: Colors.blueGrey),
                  const SizedBox(width: 4),
                  Text(
                    card == null ? 'Xem trước tem' : 'Xem trước tem (kiểm tra trước khi in)',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.blueGrey),
                  ),
                ],
              ),
              const SizedBox(height: 6),

              card == null
                  ? Container(
                height: 160,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  'Quét ${source.label} để xem trước tem',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              )
                  : ReceivingCardLabelPreview(card: card, quantity: txtQuantity.text.trim()),

              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(child: _smallButton('In tem', _onConfirm)),
                  const SizedBox(width: 4),
                  Expanded(child: _smallButton('Clear', _clear)),
                  const SizedBox(width: 4),
                  Expanded(
                    child: _smallButton(
                        'Exit', () => Navigator.of(context).pop()),
                  ),
                ],
              ),
              //hiện máy in đang dùng + nút đổi
              if (_savedPrinter != null)
                Row(
                  children: [
                    const Icon(Icons.print, size: 16, color: Colors.blueGrey),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        'Máy in: ${_savedPrinter!.id}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.blueGrey),
                      ),
                    ),
                    TextButton(
                      onPressed: _changePrinter,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        minimumSize: const Size(0, 32),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: const Text('Đổi máy in'),
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


/// Ban xem truoc tem Receiving Card, bo cuc mo phong template Lien Label.
/// Du lieu lay tu cung ham toTemplateValues() voi lenh in => noi dung khop tem.
class ReceivingCardLabelPreview extends StatelessWidget {
  const ReceivingCardLabelPreview({super.key, required this.card,this.quantity});   //show Qty theo o Qty duoc nhap => them bien quantity

  final ReceivingCardIQC card;
  final String? quantity; //show Qty theo o Qty duoc nhap

  @override
  Widget build(BuildContext context) {
    final val = card.toTemplateValues();
    if (quantity != null && quantity!.isNotEmpty) val['txtQuantity'] = quantity!; //show Qty theo o Qty duoc nhap
    String x(String key) => val[key] ?? '';

    const border = BorderSide(color: Colors.black, width: 1.5);
    const lbl = TextStyle(fontSize: 13, color: Colors.black87);
    const txt = TextStyle(
        fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold);

    Widget cell(String text,
        {TextStyle style = txt, int flex = 1, bool right = true}) =>
        Expanded(
          flex: flex,
          child: Container(
            height: 26,
            padding: const EdgeInsets.symmetric(horizontal: 4),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              border: Border(right: right ? border : BorderSide.none),
            ),
            child: Text(text,
                maxLines: 1, overflow: TextOverflow.ellipsis, style: style),
          ),
        );

    Widget row(List<Widget> children) => Container(
      decoration: const BoxDecoration(border: Border(bottom: border)),
      child: Row(children: children),
    );

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: Container(
        width: 380,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 2),
          boxShadow: const [
            BoxShadow(color: Colors.black26, blurRadius: 6, offset: Offset(1, 2)),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ----- Dau tem: gio | tieu de | QR -----
            Container(
              decoration: const BoxDecoration(border: Border(bottom: border)),
              padding: const EdgeInsets.all(4),
              child: Row(
                children: [
                  SizedBox(
                    width: 60,
                    child: Text(x('txtTime'), style: lbl),
                  ),
                  const Expanded(
                    child: Text(
                      'Receiving Card',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                  x('txtQRCode').isEmpty
                      ? const SizedBox(width: 64, height: 64)
                      : QrImageView(
                    data: x('txtQRCode'),
                    size: 64,
                    padding: EdgeInsets.zero,
                    backgroundColor: Colors.white,
                  ),
                ],
              ),
            ),
            row([
              cell(x('txtPlan'), flex: 2),
              cell(x('txtDelieverydate'), flex: 5, right: false),
            ]),
            row([
              cell('Material', style: lbl, flex: 2),
              cell(x('txtMaterial'), flex: 5, right: false),
            ]),
            // ----- Khu type/frequency/sloc + khung IQC ben phai -----
            Container(
              decoration: const BoxDecoration(border: Border(bottom: border)),
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(
                      decoration:
                      const BoxDecoration(border: Border(right: border)),
                      child: Column(
                        children: [
                          row([
                            cell('type', style: lbl, flex: 2),
                            cell(x('TypeMaterial'), flex: 3, right: false),
                          ]),
                          row([
                            cell('frequency', style: lbl, flex: 2),
                            cell(x('Typefrequency'), flex: 3, right: false),
                          ]),
                          Row(children: [
                            cell('Sloc', style: lbl, flex: 2),
                            cell(x('txtSloc'), flex: 3, right: false),
                          ]),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        row([
                          Expanded(
                            child: SizedBox(
                              height: 26,
                              child: const Center(
                                  child: Text('IQCCheck/IQC', style: txt)),
                            ),
                          ),
                        ]),
                        row([
                          cell('Sample', style: lbl),
                          cell('ROHS', style: lbl, right: false),
                        ]),
                        Row(children: [
                          cell(x('txtSample')),
                          cell(x('txtRohs'), right: false),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            row([
              cell('Code date', style: lbl, flex: 2),
              cell(x('trxtCodedate'), flex: 5, right: false),
            ]),
            row([
              cell('Quantity', style: lbl, flex: 2),
              cell(x('txtQuantity'), flex: 5, right: false),
            ]),
            row([
              cell('Invoice', style: lbl, flex: 2),
              cell(x('txtInvoice'), flex: 3),
              cell(x('txtvendor'), flex: 2, right: false),
            ]),
            Row(children: [
              cell('IQC', style: lbl, flex: 2),
              Expanded(
                flex: 3,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  decoration:
                  const BoxDecoration(border: Border(right: border)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('IQC/PL', style: lbl),
                      Text(x('txtIQCPL'), style: txt),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('ROHS', style: lbl),
                      //Text(x('txtRohs'), style: txt),
                      Text(x('txtRohsBottom'), style: txt)
                    ],
                  ),
                ),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}

/// Chuan hoa de so khop: bo khoang trang, dau : - _ ; viet hoa.
/// "VT 003514" == "vt003514" ; "00:01:90:AF:0A:4B" == "000190AF0A4B"
String _normalizePrinterKey(String s) =>
    s.toUpperCase().replaceAll(RegExp(r'[\s:\-_]'), '');

class PrinterPickerDialog extends StatefulWidget {
  const PrinterPickerDialog({
    super.key,
    required this.printers,
    this.initialMacAddress,
    this.subtitle = '',
  });

  final List<PrinterDevice> printers;
  final String? initialMacAddress;
  final String subtitle;

  @override
  State<PrinterPickerDialog> createState() => _PrinterPickerDialogState();
}

class _PrinterPickerDialogState extends State<PrinterPickerDialog> {
  final txtPrinter = TextEditingController();
  final FocusNode printerFocus = FocusNode();

  PrinterDevice? selected;
  String filter = '';
  String errorText = '';

  @override
  void initState() {
    super.initState();

    // Chon san may in dung lan truoc (neu co)
    final mac = widget.initialMacAddress;
    if (mac != null) {
      for (final d in widget.printers) {
        if (_normalizePrinterKey(d.macAddress) == _normalizePrinterKey(mac)) {
          selected = d;
          break;
        }
      }
    }

    // An ban phim ao, de may quet PDA nhap vao
    Future.delayed(const Duration(milliseconds: 150), () {
      SystemChannels.textInput.invokeMethod('TextInput.hide');
    });
  }

  @override
  void dispose() {
    txtPrinter.dispose();
    printerFocus.dispose();
    super.dispose();
  }

  /// Tim may in theo ten nhan (ID) hoac MacAddress.
  PrinterDevice? _findPrinter(String scanned) {
    final key = _normalizePrinterKey(scanned);
    if (key.isEmpty) return null;

    // 1) Khop chinh xac
    for (final d in widget.printers) {
      if (_normalizePrinterKey(d.id) == key ||
          _normalizePrinterKey(d.macAddress) == key) {
        return d;
      }
    }

    // 2) Khop mot phan nhung chi co DUY NHAT 1 may
    final partial = widget.printers
        .where((d) => _normalizePrinterKey(d.id).contains(key))
        .toList();
    return partial.length == 1 ? partial.first : null;
  }

  void _onScanPrinter(String value) {
    final found = _findPrinter(value);
    if (found != null) {
      // Scan dung => chon luon va dong popup de in
      Navigator.of(context).pop(found);
      return;
    }

    setState(() {
      errorText = 'Không tìm thấy máy in "${value.trim()}"';
      filter = '';
    });
    txtPrinter.clear();
    printerFocus.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final key = _normalizePrinterKey(filter);
    final shown = key.isEmpty
        ? widget.printers
        : widget.printers
        .where((d) =>
    _normalizePrinterKey(d.id).contains(key) ||
        _normalizePrinterKey(d.macAddress).contains(key))
        .toList();

    return AlertDialog(
      title: const Text('Chọn máy in'),
      contentPadding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (widget.subtitle.isNotEmpty)
              Text(
                widget.subtitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.blueGrey),
              ),
            const SizedBox(height: 8),
            TextField(
              controller: txtPrinter,
              focusNode: printerFocus,
              autofocus: true,
              showCursor: true,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                isDense: true,
                labelText: 'Scan tên máy in',
                hintText: 'VD: VT 003514',
                prefixIcon: const Icon(Icons.qr_code_scanner),
                errorText: errorText.isEmpty ? null : errorText,
              ),
              onChanged: (v) => setState(() {
                filter = v;
                errorText = '';
              }),
              onSubmitted: _onScanPrinter,
            ),
            const SizedBox(height: 4),
            Flexible(
              child: shown.isEmpty
                  ? const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  'Không có máy in phù hợp',
                  textAlign: TextAlign.center,
                ),
              )
                  : ListView(
                shrinkWrap: true,
                children: shown
                    .map(
                      (d) => RadioListTile<String>(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    value: d.macAddress,
                    groupValue: selected?.macAddress,
                    title: Text(
                      d.id,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(d.macAddress),
                    onChanged: (_) => setState(() => selected = d),
                  ),
                )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Đóng'),
        ),
        ElevatedButton(
          onPressed:
          selected == null ? null : () => Navigator.of(context).pop(selected),
          child: const Text('In'),
        ),
      ],
    );
  }
}
