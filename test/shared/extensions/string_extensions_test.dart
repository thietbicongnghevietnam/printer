import 'package:flutter_test/flutter_test.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';

void main() {
  group('isInt', () {
    test('empty', () {
      final result = ''.isInt;

      expect(result, false);
    });
    test('int', () {
      final result = '1'.isInt;

      expect(result, true);
    });
    test('double', () {
      final result = '1.1'.isInt;

      expect(result, false);
    });
    test('String and number', () {
      final result = 'a2'.isInt;

      expect(result, false);
    });
  });
}