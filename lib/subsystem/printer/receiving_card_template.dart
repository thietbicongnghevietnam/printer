// lib/subsystem/printer/receiving_card_template.dart
//
// Template Receiving Card (SBPL - SATO) da co san ky tu ESC (\x1B),
// STX (\x02), ETX (\x03). Cac o du lieu dat dang {tenBien}.
// Ham build() chi viec thay {tenBien} bang du lieu that.

class ReceivingCardTemplate {
  ReceivingCardTemplate._();

  //tuan anh PMD
  //static const receivingCard = 'AA3V+00000H+0000CS4#F5A1V00639H0440ZAPSWKreceivingcard%0H0013V00022FW0202V0594H0377%0H0063V00195FW02V00421%0H0102V00195FW02V00421%0H0171V00024FW02V00590%0H0208V00024FW02V00590%0H0013V00458FW02H0051%1H0030V00606P02RH0,SATO0.ttf,0,020,020,Time value%1H0019V00434P02RH0,SATO0.ttf,1,033,034,Receiving Card%1H0019V001832D30,L,02,1,0DNQRLEN,QRCode%0H0137V00024FW02V00590%0H0063V00488FW02H0325%1H0073V00609P02RH0,SATO0.ttf,0,020,020,Plan value%1H0112V00609P02RH0,SATO0.ttf,0,020,020,Material%1H0146V00609P02RH0,SATO0.ttf,0,020,020,type%1H0181V00609P02RH0,SATO0.ttf,0,020,020,frequency%0H0240V00278FW02V00336%1H0216V00609P02RH0,SATO0.ttf,0,020,020,Sloc%1H0247V00609P02RH0,SATO0.ttf,0,020,020,Code date%0H0272V00024FW02V00590%0H0303V00024FW02V00590%1H0280V00609P02RH0,SATO0.ttf,0,020,020,Quantity%0H0333V00024FW02V00590%1H0311V00609P02RH0,SATO0.ttf,0,020,020,Invoice%1H0352V00609P02RH0,SATO0.ttf,0,020,020,IQC%0H0361V00024FW02V00464%1H0311V00483P02RH0,SATO0.ttf,0,020,020,Invoice value%1H0311V00270P02RH0,SATO0.ttf,0,020,020,vendor value%0H0305V00276FW02H0083%1H0146V00197P02RH0,SATO0.ttf,0,020,020,IQCCheck/IQC%0H0173V00153FW02H0099%1H0181V00241P02RH0,SATO0.ttf,0,020,020,Sample%1H0181V00110P02RH0,SATO0.ttf,0,020,020,ROHS%1H0228V00265P02RH0,SATO0.ttf,0,020,020,Sample Value%1H0228V00131P02RH0,SATO0.ttf,0,020,020,ROHS Value%0H0137V00277FW02H0135%1H0280V00483P02RH0,SATO0.ttf,0,020,020,Quantity value%1H0339V00409P02RH0,SATO0.ttf,0,020,020,IQC/PL%1H0339V00172P02RH0,SATO0.ttf,0,020,020,ROHS%1H0367V00428P02RH0,SATO0.ttf,0,020,020,IQC/PL value%1H0367V00199P02RH0,SATO0.ttf,0,020,020,ROHSBottom%1H0249V00483P02RH0,SATO0.ttf,0,020,020,Code date value%1H0216V00483P02RH0,SATO0.ttf,0,020,020,Sloc value%1H0112V00483P02RH0,SATO0.ttf,0,020,020,Material value%1H0146V00483P02RH0,SATO0.ttf,0,020,020,Type value%1H0181V00483P02RH0,SATO0.ttf,0,020,020,frequency value%1H0073V00483P02RH0,SATO0.ttf,0,020,020,Date value%0H0014V00192FW02H0122Q1Z';


// dang truyen theo bien {txt}
  static const receivingCard =
      '\x02\x1BA\x1BA3V+00000H+0000\x1BCS4\x1B#F5\x1BA1V00639H0440\x1BZ\x03\x02\x1BA\x1BPS\x1BW'
      'Kreceivingcard\x1B%0\x1BH0013\x1BV00022\x1BFW0202V0594H0377\x1B%0\x1BH0063\x1BV00195\x1B'
      'FW02V0421\x1B%0\x1BH0102\x1BV00195\x1BFW02V0421\x1B%0\x1BH0171\x1BV00024\x1BFW02V0590'
      '\x1B%0\x1BH0208\x1BV00024\x1BFW02V0590\x1B%0\x1BH0013\x1BV00458\x1BFW02H0051\x1B%1\x1BH0'
      '030\x1BV00606\x1BP02\x1BRH0,SATO0.ttf,0,020,020,{txtTime}\x1B%1\x1BH0019\x1BV00434\x1BP0'
      '2\x1BRH0,SATO0.ttf,1,033,034,Receiving Card\x1B%1\x1BH0019\x1BV00183\x1B2D30,L,02,1,0'
      '\x1BDN{txtQRCode_len},{txtQRCode}\x1B%0\x1BH0137\x1BV00024\x1BFW02V0590\x1B%0\x1BH0063'
      '\x1BV00488\x1BFW02H0325\x1B%1\x1BH0073\x1BV00609\x1BP02\x1BRH0,SATO0.ttf,0,020,020,{txtP'
      'lan}\x1B%1\x1BH0112\x1BV00609\x1BP02\x1BRH0,SATO0.ttf,0,020,020,Material\x1B%1\x1BH0146'
      '\x1BV00609\x1BP02\x1BRH0,SATO0.ttf,0,020,020,type\x1B%1\x1BH0181\x1BV00609\x1BP02\x1BRH0'
      ',SATO0.ttf,0,020,020,frequency\x1B%0\x1BH0240\x1BV00278\x1BFW02V0336\x1B%1\x1BH0216\x1BV'
      '00609\x1BP02\x1BRH0,SATO0.ttf,0,020,020,Sloc\x1B%1\x1BH0247\x1BV00609\x1BP02\x1BRH0,SATO'
      '0.ttf,0,020,020,Code date\x1B%0\x1BH0272\x1BV00024\x1BFW02V0590\x1B%0\x1BH0303\x1BV00024'
      '\x1BFW02V0590\x1B%1\x1BH0280\x1BV00609\x1BP02\x1BRH0,SATO0.ttf,0,020,020,Quantity\x1B%0'
      '\x1BH0333\x1BV00024\x1BFW02V0590\x1B%1\x1BH0311\x1BV00609\x1BP02\x1BRH0,SATO0.ttf,0,020,'
      '020,Invoice\x1B%1\x1BH0352\x1BV00609\x1BP02\x1BRH0,SATO0.ttf,0,020,020,IQC\x1B%0\x1BH036'
      '1\x1BV00024\x1BFW02V0464\x1B%1\x1BH0312\x1BV00484\x1BP02\x1BRH0,SATO0.ttf,0,020,020,{txt'
      'Invoice}\x1B%1\x1BH0311\x1BV00270\x1BP02\x1BRH0,SATO0.ttf,0,020,020,{txtVendor}\x1B%0'
      '\x1BH0305\x1BV00276\x1BFW02H0083\x1B%1\x1BH0146\x1BV00197\x1BP02\x1BRH0,SATO0.ttf,0,020,'
      '020,IQCCheck/IQC\x1B%0\x1BH0173\x1BV00153\x1BFW02H0099\x1B%1\x1BH0181\x1BV00241\x1BP02'
      '\x1BRH0,SATO0.ttf,0,020,020,Sample\x1B%1\x1BH0181\x1BV00110\x1BP02\x1BRH0,SATO0.ttf,0,02'
      '0,020,ROHS\x1B%1\x1BH0228\x1BV00265\x1BP02\x1BRH0,SATO0.ttf,0,020,020,{txtSample}\x1B%1'
      '\x1BH0228\x1BV00131\x1BP02\x1BRH0,SATO0.ttf,0,020,020,{txtRohs}\x1B%0\x1BH0137\x1BV00277'
      '\x1BFW02H0135\x1B%1\x1BH0280\x1BV00483\x1BP02\x1BRH0,SATO0.ttf,0,020,020,{txtQuantity}'
      '\x1B%1\x1BH0339\x1BV00409\x1BP02\x1BRH0,SATO0.ttf,0,020,020,IQC/PL\x1B%1\x1BH0339\x1BV00'
      '172\x1BP02\x1BRH0,SATO0.ttf,0,020,020,ROHS\x1B%1\x1BH0367\x1BV00428\x1BP02\x1BRH0,SATO0.'
      'ttf,0,020,020,{txtIQCPL}\x1B%1\x1BH0368\x1BV00200\x1BP02\x1BRH0,SATO0.ttf,0,020,020,{txtRohsBottom'
      '}\x1B%1\x1BH0249\x1BV00483\x1BP02\x1BRH0,SATO0.ttf,0,020,020,{trxtCodedate}\x1B%1\x1BH0'
      '216\x1BV00483\x1BP02\x1BRH0,SATO0.ttf,0,020,020,{txtSloc}\x1B%1\x1BH0112\x1BV00484\x1BP0'
      '2\x1BRH0,SATO0.ttf,0,020,020,{txtMaterial}\x1B%1\x1BH0146\x1BV00483\x1BP02\x1BRH0,SATO0.'
      'ttf,0,020,020,{TypeMaterial}\x1B%1\x1BH0180\x1BV00484\x1BP02\x1BRH0,SATO0.ttf,0,020,020,'
      '{Typefrequency}\x1B%1\x1BH0073\x1BV00483\x1BP02\x1BRH0,SATO0.ttf,0,020,020,{txtDelivery'
      'date}\x1B%0\x1BH0014\x1BV00192\x1BFW02H0122\x1BQ1\x1BZ\x03';

  /// Tim cac o {tenBien} trong template.
  static final RegExp _placeholder = RegExp(r'\{(\w+)\}');

  /// Tao lenh in hoan chinh.
  /// [values]: tenBien -> du lieu that (khong can dau ngoac nhon).
  /// Rieng {xxx_len} tu tinh = do dai du lieu cua {xxx}, dang 4 so (VD 0044)
  /// dung cho lenh QR: \x1BDN{txtQRCode_len},{txtQRCode}
  static String build(Map<String, String> values,
      {String template = receivingCard}) {
    return template.replaceAllMapped(_placeholder, (m) {
      final String key = m.group(1)!;

      if (key.endsWith('_len')) {
        final baseKey = key.substring(0, key.length - 4);
        final data = toAscii(values[baseKey] ?? '');
        return data.length.toString().padLeft(4, '0');
      }

      return toAscii(values[key] ?? '');
    });
  }

  /// Liet ke cac o {tenBien} co trong template nhung chua duoc gan du lieu.
  /// Dung de kiem tra khi doi mau tem.
  static List<String> missingKeys(Map<String, String> values,
      {String template = receivingCard}) {
    final keys = _placeholder
        .allMatches(template)
        .map((m) => m.group(1)!)
        .where((k) => !k.endsWith('_len'))
        .toSet();
    return keys.where((k) => !values.containsKey(k)).toList();
  }

  static const String _viFrom =
      'àáảãạăằắẳẵặâầấẩẫậèéẻẽẹêềếểễệìíỉĩịòóỏõọôồốổỗộơờớởỡợùúủũụưừứửữựỳýỷỹỵđ';
  static final String _viTo = '${'a' * 17}${'e' * 11}${'i' * 5}'
      '${'o' * 17}${'u' * 11}${'y' * 5}d';

  /// May in chi nhan ASCII: bo dau tieng Viet, bo ky tu dieu khien / ky tu la
  /// (tranh du lieu lam hong lenh in, vd ky tu ESC nam trong du lieu).
  static String toAscii(String input) {
    final sb = StringBuffer();
    for (final ch in input.split('')) {
      final lower = ch.toLowerCase();
      final idx = _viFrom.indexOf(lower);
      if (idx >= 0) {
        final base = _viTo[idx];
        sb.write(ch == lower ? base : base.toUpperCase());
      } else {
        sb.write(ch);
      }
    }
    return sb.toString().replaceAll(RegExp(r'[^\x20-\x7E]'), '');
  }
}
