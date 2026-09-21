import 'package:flutter_test/flutter_test.dart';
import 'package:smart_warehouse/shared/extensions/iterable_extensions.dart';

void main() {
  group('leftOuterJoin', () {
    test('leftOuterJoin', () {
      final a = [1, 2, 3, 4];
      final b = [3, 4, 5, 6];

      final c = a.leftOuterJoin(b);

      expect(c, [1, 2]);
    });
  });
}
