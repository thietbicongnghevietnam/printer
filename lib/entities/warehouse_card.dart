import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/constants.dart';

class WareHouseCard {
  WareHouseCard({
    this.material,
    this.plant,
    this.sloc,
    this.position,
  });

  final String? material;
  final String? plant;
  final String? sloc;
  final String? position;

  static WareHouseCard getWareHouseCardFormat(String stockBarcode) {
    final arr = stockBarcode.split(Constants.barcodeSplitCharacter);
    if (arr.length != 5) {
      throw ValidationError(type: ValidationErrorType.wareHouseCardInvalid);
    }

    String material = '';
    String plant = '';
    String sloc = '';
    String position = '';

    material = arr[0];
    plant = arr[1];
    sloc = arr[2];
    position = arr[3];

    return WareHouseCard(
      material: material,
      plant: plant,
      sloc: sloc,
      position: position,
    );
  }
}
