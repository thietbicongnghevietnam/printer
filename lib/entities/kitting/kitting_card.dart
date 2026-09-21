import 'package:smart_warehouse/entities/qr_card.dart';
import 'package:smart_warehouse/enums/kitting_type.dart';
import 'package:smart_warehouse/shared/common/error_entity.dart';
import 'package:smart_warehouse/shared/constants.dart';
import 'package:smart_warehouse/shared/extensions/datetime_extensions.dart';
import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
import 'package:smart_warehouse/shared/utils/copyable.dart';
import 'package:smart_warehouse/shared/utils/logger.dart';
import 'package:sprintf/sprintf.dart';

class KittingCard extends QRCard implements Copyable<KittingCard> {
  KittingCard({
    this.category,
    this.receiptSloc,
    this.kittingFrom,
    this.reason,
    this.remark,
    this.pullID,
    this.status,
    this.kittingCardID,
    this.rcDetailID,
    this.rcid,
    this.kittingListDetailId,
    this.id,
    this.kittingTimeType,
    this.plant,
    this.material,
    this.model,
    this.quantity,
    this.kittingDate,
    this.kittingHour,
    this.line,
    this.sloc,
    this.pic,
    this.posMcs,
    this.posFA,
    required super.barcode,
    this.pl,
    this.qtyTotal,
    this.kittingType,
  });

  static bool validate(String barcode) {
    final arr = barcode.split(Constants.receivingCardSplitCharacter);
    if (arr.last != 'KC') {
      return arr.last.isInt;
    }
    return true;
  }

  static int getKittingCardID(String barcode) {
    final arr = barcode.split(Constants.receivingCardSplitCharacter);
    if (!validate(barcode)) {
      throw ValidationError(type: ValidationErrorType.kittingCardInvalid);
    }
    if (arr.last == 'KC') {
      return arr.first.toInt();
    } else {
      return arr.last.toInt();
    }
  }

  String getTextKittingTimeType(String type) {
    switch (type) {
      case '1':
        return 'One Time';
      case '2':
        return 'Prepare';
      case 'N1' || 'N2' || 'N3':
        return 'N Time';
    }
    return '';
  }

  final int? id;
  final String? kittingTimeType;
  final String? plant;
  final String? material;
  final String? model;
  final double? quantity;
  final DateTime? kittingDate;
  final String? kittingHour;
  final String? line;
  final String? sloc;
  final String? pic;
  final String? posMcs;
  final String? posFA;
  final int? kittingCardID;
  final String? rcDetailID;
  final String? rcid;
  final int? kittingListDetailId;
  final String? pl;
  final double? qtyTotal;
  final int? status;
  final int? kittingType;
  final String? category;
  final String? receiptSloc;
  final String? kittingFrom;
  final String? reason;
  final String? remark;
  final String? pullID;

  String get command {
    final qty = quantity?.toInt() ?? 0;
    final totalQuantity = qtyTotal?.toInt() ?? 0;

    if (kittingType == KittingType.fa.code ||
        kittingType == KittingType.dip.code) {
      return sprintf(Constants.sbplKitting, [
        barcode.length,
        barcode,
        plant,
        getTextKittingTimeType(kittingTimeType ?? ''),
        posMcs,
        pic,
        material,
        model,
        kittingDate?.toText(),
        kittingHour,
        line,
        sloc,
        if (qty < totalQuantity) '$qty/$totalQuantity' else qty.toString(),
        pl,
        posFA,
      ]);
    } else if (kittingType == KittingType.outside.code) {
      return sprintf(Constants.sbplKittingOutSide, [
        barcode.length,
        barcode,
        kittingFrom ?? '',
        category ?? '',
        kittingDate?.toText(),
        material,
        pullID ?? '',
        receiptSloc ?? '',
        pic,
        reason ?? '',
        remark ?? '',
        posMcs,
        sloc,
        line,
        if (qty < totalQuantity) '$qty/$totalQuantity' else qty.toString(),
      ]);
    } else {
      return sprintf(Constants.sbplKittingSubcon, [
        barcode.length,
        barcode,
        pic,
        posMcs,
        plant,
        posFA,
        material,
        totalQuantity,
        quantity?.toInt(),
        sloc ?? '',
        receiptSloc ?? '',
        pl,
        kittingDate?.toText(),
        kittingHour ?? '',
        line ?? '',
      ]);
    }
  }

  @override
  KittingCard copyWith() {
    return KittingCard(
      id: id,
      kittingTimeType: kittingTimeType,
      plant: plant,
      material: material,
      model: model,
      quantity: quantity,
      kittingHour: kittingHour,
      line: line,
      sloc: sloc,
      pic: pic,
      posMcs: posMcs,
      posFA: posFA,
      barcode: barcode,
      kittingCardID: kittingCardID,
      kittingListDetailId: kittingListDetailId,
      kittingDate: kittingDate,
      rcDetailID: rcDetailID,
      rcid: rcid,
      pl: pl,
      qtyTotal: qtyTotal,
    );
  }
}
