import 'package:smart_warehouse/shared/common/error_entity.dart';

enum KittingTimeType {
  oneTime('1'),
  prepare('2'),
  nTime('N1'),
  total(null);

  static KittingTimeType fromCode(String? code) {
    return KittingTimeType.values.firstWhere((element) => code == element.code);
  }

  final String? code;
  const KittingTimeType(this.code);

  String? get text {
    switch (this) {
      case KittingTimeType.oneTime:
        return '1';
      case KittingTimeType.prepare:
        return '2';
      case KittingTimeType.nTime:
        return 'N1';
      case KittingTimeType.total:
        return null;
    }
  }

  @override
  String toString() {
    switch (this) {
      case KittingTimeType.oneTime:
        return '1 Lần';
      case KittingTimeType.prepare:
        return 'Chuẩn bị';
      case KittingTimeType.nTime:
        return 'N Lần';
      case KittingTimeType.total:
        return 'Tất cả';
    }
  }
}
