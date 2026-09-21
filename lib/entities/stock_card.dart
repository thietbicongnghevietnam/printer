import 'package:intl/intl.dart';
import 'package:smart_warehouse/entities/barcode/barcode.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/constants.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';

import 'barcode/box_card_barcode.dart';
import 'barcode/local_barcode.dart';
import 'barcode/oversea_barcode.dart';
import 'barcode/pmd_barcode.dart';
import 'barcode/simple_barcode.dart';
import 'barcode/standard_barcode.dart';

class StockCard {
  StockCard({
    required this.daInv,
    required this.vendorCode,
    required this.material,
    required this.plant,
    required this.sloc,
    this.quantity,
    this.deliveryDate,
    this.lastItem,
    this.barcode,
  });

  String daInv;
  String? vendorCode;
  String? material;
  String? plant;
  String? sloc;
  String? quantity;
  String? deliveryDate;
  String? lastItem;
  String? barcode;

  /// StockCard format
  // DA/Invoice No;vendor code;material;plant;sloc;quantity;date;cái cuối cùng không biết
  static String getStockCardDAInv(String stockBarcode) {
    final arr = stockBarcode.split(Constants.barcodeSplitCharacter);
    if (arr.length != 8 && arr.length != 12) {
      throw ValidationError(type: ValidationErrorType.stockInValid);
    }

    if (LocalBarcode.validate(stockBarcode) ||
        OverseaBarcode.validate(stockBarcode)) {
      throw ValidationError(type: ValidationErrorType.stockInValid);
    }

    return arr.first;
  }

  static StockCard getStockCardFormat(String stockBarcode) {
    final arr = stockBarcode.split(Constants.barcodeSplitCharacter);
    // final barcodeFormatted = stockBarcode.trim();
    // if (PMDBarcode.validate(barcodeFormatted) ||
    //     StandardBarcode.validate(barcodeFormatted) ||
    //     BoxCardBarcode.validate(barcodeFormatted) ||
    //     LocalBarcode.validate(barcodeFormatted) ||
    //     OverseaBarcode.validate(barcodeFormatted) ||
    //     SimpleBarcode.validate(barcodeFormatted)) {
    //   throw ValidationError(type: ValidationErrorType.stockInValid);
    // }

    if (arr.length != 8 && arr.length != 12) {
      throw ValidationError(type: ValidationErrorType.stockInValid);
    }

    if(arr[1][0] != 'K') {
      if ( LocalBarcode.validate(stockBarcode) ||
          OverseaBarcode.validate(stockBarcode)) {
        throw ValidationError(type: ValidationErrorType.stockInValid);
      }
    }

    /// Thêm API check vị trí Plant có phải Plant không => chuẩn thì là StockCard

    String dAInvoiceNo = '';
    String vendorCode = '';
    String material = '';
    String plant = '';
    String sloc = '';
    String quantity = '';
    String deliveryDate = '';
    String lastItem = '';

    if (arr.length == 8) {
      dAInvoiceNo = arr[0];
      vendorCode = arr[1];
      material = arr[2];
      plant = arr[3];
      sloc = arr[4];
      quantity = arr[5];
      deliveryDate = arr[6];
      lastItem = arr[7];
    } else if (arr.length == 12) {
      // final splitPDAValue = value.split(';');
      // final vendorCode = splitPDAValue[0];
      // final dAInvoiceNo = splitPDAValue[10];
      // final material = splitPDAValue[6];
      // final deliveryDate = splitPDAValue[3];
      dAInvoiceNo = arr[10];
      vendorCode = arr[0];
      material = arr[6];
      quantity = arr[7];
      deliveryDate = arr[3];
      lastItem = '';

      //???
      plant = '';
      sloc = '';
    }

    if (deliveryDate.contains('-')) {
      DateTime parsedDate = DateTime.parse(deliveryDate);

      String formattedDate = DateFormat('MM/dd/yyyy').format(parsedDate);
      deliveryDate = formattedDate;
    }
    return StockCard(
      daInv: dAInvoiceNo,
      vendorCode: vendorCode,
      material: material,
      plant: plant,
      sloc: sloc,
      quantity: quantity,
      deliveryDate: deliveryDate,
      lastItem: lastItem,
      barcode: stockBarcode,
    );
  }
}
