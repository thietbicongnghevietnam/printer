import 'package:collection/collection.dart';

enum ReceivingCardReason {
  ocs('OCS'), faReturn('FA'), jupiter('JPT');

  const ReceivingCardReason(this.code);

  static ReceivingCardReason? fromCode(String? code){
    return values.firstWhereOrNull((element) => element.code == code);
  }

  final String code;
}