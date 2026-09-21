import 'package:smart_warehouse/shared/common/error_entity.dart';

enum RackType {
  bigPart('Big part'),
  smallPart('Small part'),
  pallet('Pallet');

  const RackType(this.rackType);

  final String rackType;

  static RackType fromRackType(String rackType) {
    return switch (rackType) {
      'Big part' => bigPart,
      'Small part' => smallPart,
      'Pallet' => pallet,
      _ => throw ErrorEntity(message: 'RackType in valid'),
    };
  }
}
