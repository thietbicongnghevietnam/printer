// class Get_Recheck {
//   String NameRecheck;
//   Get_Recheck({required this.NameRecheck });
//   factory Get_Recheck.fromJson(Map<String, dynamic> json) {
//     return Get_Recheck(
//       NameRecheck: json['NameRecheck'] ?? '',
//     );
//   }
// }

//2026
class Get_Recheck {
  String NameRecheck;

  Get_Recheck({required this.NameRecheck});

  factory Get_Recheck.fromJson(Map<String, dynamic> json) {
    return Get_Recheck(
      NameRecheck: json['NameRecheck']?.toString() ?? '',
    );
  }
}

/// Mot dong cua bang DM_Tcode (store Query_List_Tcode chi tra ve cot [Tcode]).
class TcodeIQC {
  const TcodeIQC({required this.tcode});

  final String tcode; // Tcode

  factory TcodeIQC.fromMap(Map<String, dynamic> map) =>
      TcodeIQC(tcode: _cellValue(map, const ['tcode']));

  /// Doc ca danh sach: bo dong rong va dong trung ma.
  static List<TcodeIQC> listFrom(List<Map<String, dynamic>> rows) {
    final result = <TcodeIQC>[];
    final seen = <String>{};
    for (final row in rows) {
      final item = TcodeIQC.fromMap(row);
      if (item.tcode.isEmpty) continue;
      if (seen.add(item.tcode.toUpperCase())) result.add(item);
    }
    return result;
  }

  /// Danh sach chuoi de do thang vao DropdownButtonFormField.
  static List<String> codesFrom(List<Map<String, dynamic>> rows) =>
      listFrom(rows).map((e) => e.tcode).toList();
}

/// Mot dong cua bang DM_lydo311 (store Query_List_Lydo311 chi tra ve cot [Lydo]).
class Lydo311IQC {
  const Lydo311IQC({required this.lydo});

  final String lydo; // Lydo

  factory Lydo311IQC.fromMap(Map<String, dynamic> map) =>
      Lydo311IQC(lydo: _cellValue(map, const ['lydo', 'lydo311', 'reason']));

  static List<Lydo311IQC> listFrom(List<Map<String, dynamic>> rows) {
    final result = <Lydo311IQC>[];
    final seen = <String>{};
    for (final row in rows) {
      final item = Lydo311IQC.fromMap(row);
      if (item.lydo.isEmpty) continue;
      if (seen.add(item.lydo.toUpperCase())) result.add(item);
    }
    return result;
  }

  static List<String> codesFrom(List<Map<String, dynamic>> rows) =>
      listFrom(rows).map((e) => e.lydo).toList();
}

/// Lay gia tri 1 o: uu tien dung ten cot trong [keys] (khong phan biet hoa/thuong),
/// khong thay thi lay cot dau tien - store chi select 1 cot nen van dung.
String _cellValue(Map<String, dynamic> map, List<String> keys) {
  final lower = <String, dynamic>{
    for (final e in map.entries) e.key.toLowerCase(): e.value,
  };

  String clean(dynamic v) {
    if (v == null) return '';
    final s = v.toString().trim();
    return s.toLowerCase() == 'null' ? '' : s;
  }

  for (final k in keys) {
    final s = clean(lower[k]);
    if (s.isNotEmpty) return s;
  }
  return map.isEmpty ? '' : clean(map.values.first);
}

/// Thong tin Receiving Card dung de IN LAI (man hinh IQC).
/// Map theo cot cua bang [SWMS_DEV].[dbo].[tblReceivingCard].
class ReceivingCardIQC {
  ReceivingCardIQC({
    required this.result,
    required this.receivingCardId,
    required this.barcode,
    required this.receivingType,
    required this.receivingCardTime,
    required this.receivingCardDate,
    required this.material,
    required this.materialType,
    required this.materialFrequency,
    required this.plant,
    required this.sloc,
    required this.codeDate,
    required this.totalQuantity,
    required this.currentQuantity,
    required this.boxQuantity,
    required this.samplingCheck,
    required this.rohsCheck,
    required this.rohs,
    required this.daInvNo,
    required this.vendorCode,
    required this.vendorName,
    required this.pl,
    required this.status,
    required this.planOrderNumber,
    required this.category,
  });

  final String result; // cot kq neu co ('0' = khong tim thay)
  final String receivingCardId; // ReceivingCardID
  final String barcode; // Barcode
  final String receivingType; // ReceivingType
  final String receivingCardTime; // ReceivingCardTime
  final String receivingCardDate; // ReceivingCardDate
  final String material; // Material
  final String materialType; // MaterialType
  final String materialFrequency; // MaterialFrequency
  final String plant; // Plant
  final String sloc; // Sloc
  final String codeDate; // CodeDate
  final String totalQuantity; // TotalQuantity
  final String currentQuantity; // CurrentQuantity
  final String boxQuantity; // BoxQuantity
  final String samplingCheck; // SamplingCheck
  final String rohsCheck; // RohsCheck
  final String rohs; // Rohs
  final String daInvNo; // DAInvNo
  final String vendorCode; // VendorCode
  final String vendorName; // VendorName
  final String pl; // PL
  final String status; // Status
  final String planOrderNumber; // PlanOrderNumber
  final String category; // Category

  /// So luong in tren tem: uu tien CurrentQuantity, khong co thi TotalQuantity.
  String get quantity =>
      currentQuantity.isNotEmpty ? currentQuantity : totalQuantity;

  bool get isFound =>
      result != '0' && (material.isNotEmpty || barcode.isNotEmpty);

  factory ReceivingCardIQC.fromMap(Map<String, dynamic> map) {
    // Khong phan biet hoa/thuong ten cot
    final lower = <String, dynamic>{
      for (final e in map.entries) e.key.toLowerCase(): e.value,
    };

    String v(String key) {
      final val = lower[key.toLowerCase()];
      if (val == null || val.toString().toLowerCase() == 'null') return '';
      return val.toString().trim();
    }

    /// So: 4800.0 / 4800.000 => 4800
    String n(String key) {
      final s = v(key);
      final d = double.tryParse(s);
      if (d == null) return s;
      return d == d.truncateToDouble() ? d.toInt().toString() : d.toString();
    }

    /// Ngay: 2025-01-15T00:00:00 => 2025-01-15
    String d(String key) {
      final s = v(key);
      if (s.length >= 10 && s.contains('T') && DateTime.tryParse(s) != null) {
        return s.substring(0, 10);
      }
      return s;
    }

    /// Gio: 08:30:15.1234567 hoac 2025-01-15T08:30:15 => 08:30
    String t(String key) {
      final s = v(key);
      final dt = DateTime.tryParse(s);
      if (dt != null && s.contains('T')) {
        return '${dt.hour.toString().padLeft(2, '0')}:'
            '${dt.minute.toString().padLeft(2, '0')}';
      }
      final m = RegExp(r'^(\d{1,2}:\d{2})').firstMatch(s);
      return m != null ? m.group(1)! : s;
    }

    return ReceivingCardIQC(
      result: v('kq'),
      receivingCardId: v('ReceivingCardID'),
      barcode: v('Barcode'),
      receivingType: v('ReceivingType'),
      receivingCardTime: t('ReceivingCardTime'),
      receivingCardDate: d('ReceivingCardDate'),
      material: v('Material'),
      materialType: v('MaterialType'),
      materialFrequency: v('MaterialFrequency'),
      plant: v('Plant'),
      sloc: v('Sloc'),
      codeDate: d('CodeDate'),
      totalQuantity: n('TotalQuantity'),
      currentQuantity: n('CurrentQuantity'),
      boxQuantity: n('BoxQuantity'),
      samplingCheck: v('SamplingCheck'),
      rohsCheck: v('RohsCheck'),
      rohs: v('Rohs'),
      daInvNo: v('DAInvNo'),
      vendorCode: v('VendorCode'),
      vendorName: v('VendorName'),
      pl: v('PL'),
      status: v('Status'),
      planOrderNumber: v('PlanOrderNumber'),
      category: v('Category'),
    );
  }

  /// 1 / true / Y => YES ; 0 / false / N => NO ; con lai giu nguyen
  static String yesNo(String value) {
    final x = value.trim().toLowerCase();
    if (x == '1' || x == 'true' || x == 'y' || x == 'yes') return 'YES';
    if (x == '0' || x == 'false' || x == 'n' || x == 'no') return 'NO';
    return value;
  }

  /// Du lieu do vao cac o {tenBien} cua template SATO.
  /// Key = DUNG ten trong ngoac nhon cua template (phan biet hoa/thuong).
  /// => Neu tem in ra sai o nao, chi can sua dung dong do o day.
  Map<String, String> toTemplateValues() {
    final now = DateTime.now();
    final String gioIn = '${now.hour.toString().padLeft(2, '0')}:'
        '${now.minute.toString().padLeft(2, '0')}';

    return {
      'txtTime': receivingCardTime.isNotEmpty ? receivingCardTime : gioIn,
      'txtQRCode': barcode, // Barcode -> QR code
      'txtPlan': plant, // Plant
      'txtDelieverydate': receivingCardDate, // ReceivingCardDate (ten bien go sai 'Delievery')
      'txtDeliverydate': receivingCardDate, // phong khi sua lai ten bien cho dung
      'txtMaterial': material, // Material
      'TypeMaterial': materialType, // MaterialType
      'Typefrequency': materialFrequency, // MaterialFrequency
      'txtSloc': sloc, // Sloc
      'trxtCodedate': codeDate, // CodeDate (ten bien go sai 'trxt')
      'txtCodedate': codeDate, // phong khi sua lai ten bien cho dung
      'txtQuantity': quantity, // CurrentQuantity / TotalQuantity
      'txtInvoice': daInvNo, // DAInvNo
      'txtvendor': vendorCode, // VendorCode
      //'txtSample': yesNo(samplingCheck), // SamplingCheck
      'txtSample': 'YES', // luon in YES tren tem (khong phu thuoc SamplingCheck)   ==> IQC luon kiem tra =>yes  ****
      'txtRohs': yesNo(rohsCheck), // RohsCheck (template dung o 2 cho)
      'txtRohsBottom': yesNo(rohs), // Rohs - dung neu doi o ROHS duoi thanh {txtRohsBottom}
      'txtIQCPL': pl, // PL
    };
  }
}

/// Thong tin Kitting Card cho man Supply Kitting Outside.
class KittingCardOutside {
  KittingCardOutside({
    required this.result,
    required this.barcode,
    required this.material,
    required this.line,
    required this.deliveryDate,
    required this.quantity,
  });

  final String result;       // cot kq neu co ('0' = khong tim thay)
  final String barcode;      // Barcode
  final String material;     // Material
  final String line;         // Line
  final String deliveryDate; // DeliveryDate
  final String quantity;     // Quantity

  bool get isFound => result != '0' && (material.isNotEmpty || barcode.isNotEmpty);

  factory KittingCardOutside.fromMap(Map<String, dynamic> map) {
    final lower = <String, dynamic>{
      for (final e in map.entries) e.key.toLowerCase(): e.value,
    };

    String v(String key) {
      final val = lower[key.toLowerCase()];
      if (val == null || val.toString().toLowerCase() == 'null') return '';
      return val.toString().trim();
    }

    String n(String key) {                       // 4800.000 => 4800
      final s = v(key);
      final d = double.tryParse(s);
      if (d == null) return s;
      return d == d.truncateToDouble() ? d.toInt().toString() : d.toString();
    }

    String d(String key) {                       // 2025-01-15T00:00:00 => 2025-01-15
      final s = v(key);
      if (s.length >= 10 && s.contains('T') && DateTime.tryParse(s) != null) {
        return s.substring(0, 10);
      }
      return s;
    }

    return KittingCardOutside(
      result: v('kq'),
      barcode: v('Barcode'),
      material: v('Material'),
      line: v('Line'),
      deliveryDate: d('DeliveryDate'),
      quantity: n('Quantity'),
    );
  }
}
