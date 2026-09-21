import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/constants.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';

class KittingList {
  KittingList({
    this.id,
    this.createdDate,
    this.createdBy,
    this.updatedDate,
    this.updateBy,
    this.plant,
    this.reservationNo,
    this.line,
    this.time,
    this.model,
    this.modelQuantity,
    this.deliveryDate,
    this.category,
    this.barcode,
    this.quantity,
    this.kittingType,
    this.kittingTimeType,
    this.status,
  });

  static int getKittingListId(String barcode) {
    final arr = barcode.split(Constants.receivingCardSplitCharacter);
    if (!arr.last.isInt  || arr[arr.length - 2]  != 'KittingList') {
      throw ValidationError(type: ValidationErrorType.kittingListNotExist);
    }
    return arr.last.toInt();
  }

  final int? id;
  final DateTime? createdDate;
  final String? createdBy;
  final DateTime? updatedDate;
  final String? updateBy;
  final String? plant;
  final String? reservationNo;
  final String? line;
  final String? time;
  final String? model;
  final int? modelQuantity;
  final DateTime? deliveryDate;
  final String? category;
  final String? barcode;
  final int? quantity;
  final int? kittingType;
  final String? kittingTimeType;
  final int? status;
}
