import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:smart_warehouse/shared/extensions/datetime_extensions.dart';

void main() {
  setUpAll(() {
    initializeDateFormatting();
  });
  group('To Text', () {
    test('date: dd/MM/yyyy', () {
      // Arrange
      final date = DateTime(2023, 1, 2, 3, 4, 5, 6);

      // Act
      final text = date.toText();

      // Assert
      expect(text, '02/01/2023');
    });
    test('time: hh:mm:ss', () {
      // Arrange
      final date = DateTime(2023, 1, 2, 3, 4, 5, 6);

      // Act
      final text = date.toText(DateTimeType.time);

      // Assert
      expect(text, '03:04:05');
    });
    test('dateSimplify: yyyyMMdd', () {
      // Arrange
      final date = DateTime(2023, 1, 2, 3, 4, 5, 6);

      // Act
      final text = date.toText(DateTimeType.dateSimplify);

      // Assert
      expect(text, '20230102');
    });
    test('dateFull: MM/dd/yyyy hh:mm:ss a', () {
      // Arrange
      final date = DateTime(2023, 1, 2, 3, 4, 5, 6);

      // Act
      final text = date.toText(DateTimeType.dateFull);

      // Assert
      expect(text, '01/02/2023 03:04:05 AM');
    });
  });

  group('To Date', () {
    test('date: dd/MM/yyyy', () {
      // Arrange
      const text = '02/01/2023';

      // Act
      final date = text.toDate();

      // Assert
      expect(date?.year, 2023);
      expect(date?.month, 1);
      expect(date?.day, 2);
    });
    test('dateSimplify: yyyyMMdd', () {
      // Arrange
      const text = '20230102';

      // Act
      final date = text.toDate(DateTimeType.dateSimplify);

      // Assert
      expect(date?.year, 2023);
      expect(date?.month, 1);
      expect(date?.day, 2);
    });
    test('dateFull: MM/dd/yyyy hh:mm:ss a', () {
      // Arrange
      const text = '01/02/2023 03:04:05 AM';

      // Act
      final date = text.toDate(DateTimeType.dateFull);

      // Assert
      expect(date?.year, 2023);
      expect(date?.month, 1);
      expect(date?.day, 2);
      expect(date?.hour, 3);
      expect(date?.minute, 4);
      expect(date?.second, 5);
    });
  });
}
