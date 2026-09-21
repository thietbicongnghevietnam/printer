import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:smart_warehouse/entities/barcode/barcode.dart';
import 'package:smart_warehouse/entities/barcode/local_barcode.dart';
import 'package:smart_warehouse/entities/barcode/oversea_barcode.dart';
import 'package:smart_warehouse/entities/barcode/pmd_barcode.dart';
import 'package:smart_warehouse/entities/barcode/simple_barcode.dart';

void main() {
  setUpAll(() {
    initializeDateFormatting();
  });
  group('Create instance from barcode', () {
    test('Standard barcode', () {
      // Arrange
      const barcode = '4500194999;16;EEE0JA221WP;10000;;';

      // Act
      final partCard = Barcode.fromBarcode(barcode);

      // Assert
      expect(partCard.runtimeType, OverseaBarcode);
    });
    test('Oversea barcode', () {
      // Arrange
      const barcode = '4500187577;122;D1BB6813A012;35000;35000;1;;00001';

      // Act
      final partCard = Barcode.fromBarcode(barcode);

      // Assert
      expect(partCard.runtimeType, OverseaBarcode);
    });
    test('Local barcode', () {
      // Arrange
      const barcode = '21024209;2000000056;1;08/04/2020;4500161012;10;PNJS021152ZB-UZ;300;300;1;VE008-AA;00001';

      // Act
      final partCard = Barcode.fromBarcode(barcode);

      // Assert
      expect(partCard.runtimeType, LocalBarcode);
    });
    test('PMD barcode', () {
      // Arrange
      const barcode = '20231106;PNKM1188ZA1/AS;Dect;7;120;Dect;1112468;11/30/2023 10:11:24 AM';

      // Act
      final partCard = Barcode.fromBarcode(barcode);

      // Assert
      expect(partCard.runtimeType, PMDBarcode);
    });
    test('Standard barcode', () {
      // Arrange
      const barcode = r"PSNV;c1c9da9f-3af4-4ed5-b0bf-be9e6b74283c;D1BB6813A012;35000;2023-11-30;Indo;D1BB6813A012NBSP;'@@12345;$321!!@#$%^&";

      // Act
      final partCard = Barcode.fromBarcode(barcode);

      // Assert
      expect(partCard.runtimeType, SimpleBarcode);
    });
  });
}