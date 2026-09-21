import 'package:smart_warehouse/shared/common/error_entity.dart';

enum EMapNavigateFunction {
  storing(0),
  kitting(1);

  const EMapNavigateFunction(this.code);

  final int code;

  static EMapNavigateFunction fromCode(int code) {
    return switch (code) {
      0 => storing,
      1 => kitting,
      _ => throw ErrorEntity(message: 'EMap function invalid')
    };
  }

  String get text => switch (this) {
    storing => 'Store Map from Storage Case',
        kitting => 'Kitting Normal Case',
      };
}
