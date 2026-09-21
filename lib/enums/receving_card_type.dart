import 'package:smart_warehouse/shared/common/error_entity.dart';

enum ReceivingCardPrinterType {
  receivingCard(0),
  rcConvert(3),
  reCheckCard(4),
  revertKitting(5),
  three09Card(100);

  const ReceivingCardPrinterType(this.type);

  final int type;

  String get text => switch (this) {
        receivingCard => 'Receiving Card',
        rcConvert => 'RC Convert',
        reCheckCard => 'ReCheck Card',
        revertKitting => 'Revert Kitting Card',
        three09Card => '309 Card',
      };

  static ReceivingCardPrinterType fromCode(int code) {
    return switch (code) {
      0 => receivingCard,
      3 => rcConvert,
      4 => reCheckCard,
      5 => revertKitting,
      100 => three09Card,
      _ => throw ErrorEntity(message: 'Receiving Type in valid')
    };
  }
}
