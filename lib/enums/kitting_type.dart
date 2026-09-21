import 'package:smart_warehouse/shared/common/error_entity.dart';

enum KittingType {
  fa(0),
  dip(1),
  subcon(2),
  outside(3);

  const KittingType(this.code);

  final int code;

  static KittingType fromCode(int code) {
    return switch (code) {
      0 => fa,
      1 => dip,
      2 => subcon,
      3 => outside,
      _ => throw ErrorEntity(message: 'Kitting Type in valid')
    };
  }

  String get text => switch (this) {
        fa => 'FA',
        dip => 'DIP',
        subcon => 'SUBCON',
        outside => 'OUTSIDE',
      };
}
