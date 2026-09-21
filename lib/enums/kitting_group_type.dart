import 'package:smart_warehouse/shared/common/error_entity.dart';

enum KittingGroupType {
  part(0),
  model(1);

  final int code;

  const KittingGroupType(this.code);

  static KittingGroupType fromCode(int code) {
    return switch(code) {
      0 => part,
      1 => model,
      _ => throw ErrorEntity(message: 'Kitting Group in valid')
    };
  }

  String get text =>
      switch(this) {
        part => 'part',
        model => 'model',
      };
}
