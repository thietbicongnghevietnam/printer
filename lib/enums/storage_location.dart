import 'package:collection/collection.dart';

enum StorageLocation {
  asti('ASTI'),
  dip('DIP'),
  fa('FA'),
  jpt('JPT'),
  ng('NG'),
  nippon('NIPPON'),
  outside('OUTSIDE'),
  smt('SMT'),
  sub('SUB');

  const StorageLocation(this.code);

  static StorageLocation? fromCode(String? code) {
    return values.firstWhereOrNull((element) => element.code == code);
  }

  final String code;
}
