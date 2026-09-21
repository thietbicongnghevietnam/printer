// import 'package:smart_warehouse/entities/qr_card.dart';
// import 'package:smart_warehouse/shared/common/error_entity.dart';
// import 'package:smart_warehouse/shared/constants.dart';
// import 'package:smart_warehouse/shared/extensions/datetime_extensions.dart';
// import 'package:smart_warehouse/shared/extensions/string_extensions.dart';
// import 'package:smart_warehouse/shared/utils/copyable.dart';
// import 'package:sprintf/sprintf.dart';
//
// class KittingCard extends QRCard implements Copyable<KittingCard> {
//   KittingCard({
//     this.kittingCardID,
//     this.rcDetailID,
//     this.rcid,
//     this.kittingListDetailId,
//     this.id,
//     this.kittingTimeType,
//     this.plant,
//     this.material,
//     this.model,
//     this.quantity,
//     this.kittingDate,
//     this.kittingHour,
//     this.line,
//     this.sloc,
//     this.pic,
//     this.posMcs,
//     this.posFA,
//     required super.barcode,
//     this.pl,
//   });
//
//   static bool validate(String barcode) {
//     final arr = barcode.split(Constants.receivingCardSplitCharacter);
//     if (arr.length != 17 && arr.last != 'KC') {
//       return false;
//     }
//
//     return true;
//   }
//
//   static int getKittingCardID(String barcode) {
//     final arr = barcode.split(Constants.receivingCardSplitCharacter);
//
//     if (validate(barcode)) {
//       throw ValidationError(type: ValidationErrorType.kittingCardInvalid);
//     }
//     return arr.first.toInt();
//   }
//
//   String getTextKittingTimeType(String type) {
//     switch (type) {
//       case '1':
//         return 'One Time';
//       case '2':
//         return 'Prepare';
//       case 'N1' || 'N2' || 'N3':
//         return 'N Time';
//     }
//     return '';
//   }
//
//   final int? id;
//   final String? kittingTimeType;
//   final String? plant;
//   final String? material;
//   final String? model;
//   final int? quantity;
//   final DateTime? kittingDate;
//   final String? kittingHour;
//   final String? line;
//   final String? sloc;
//   final String? pic;
//   final String? posMcs;
//   final String? posFA;
//   final int? kittingCardID;
//   final String? rcDetailID;
//   final String? rcid;
//   final int? kittingListDetailId;
//   final String? pl;
//
//   String get command {
//     return sprintf(Constants.sbplKitting, [
//       barcode?.length,
//       barcode,
//       plant,
//       getTextKittingTimeType(kittingTimeType ?? ''),
//       posMcs,
//       pic,
//       material,
//       model,
//       quantity,
//       kittingDate?.toText(),
//       kittingHour,
//       line,
//       sloc,
//       pl,
//     ]);
//   }
//
//   @override
//   KittingCard copyWith() {
//     return KittingCard(
//       id: id,
//       kittingTimeType: kittingTimeType,
//       plant: plant,
//       material: material,
//       model: model,
//       quantity: quantity,
//       kittingHour: kittingHour,
//       line: line,
//       sloc: sloc,
//       pic: pic,
//       posMcs: posMcs,
//       posFA: posFA,
//       barcode: barcode,
//       kittingCardID: kittingCardID,
//       kittingListDetailId: kittingListDetailId,
//       kittingDate: kittingDate,
//       rcDetailID: rcDetailID,
//       rcid: rcid,
//     );
//   }
// }
