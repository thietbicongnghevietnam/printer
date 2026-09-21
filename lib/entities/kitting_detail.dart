import 'dart:math';

import 'package:smart_warehouse/shared/utils/copyable.dart';

class KittingDetail implements Copyable<KittingDetail> {
  KittingDetail({
    this.kittingType,
    this.kittingTimeType,
    this.id,
    this.kittingListID,
    required this.quantity,
    this.unit,
    this.locationName,
    this.picUser,
    this.barcode,
    this.kittingStatus,
    this.supplyStatus,
    required this.material,
    this.sloc,
    this.descriptions,
    required this.model,
    this.location,
    this.time,
    required this.pickedQuantity,
    this.frequency,
  });

  final int? id;
  final int? kittingListID;
  final int quantity;
  final String? unit;
  final String? locationName;
  final String? picUser;
  final String? barcode;
  final int? kittingStatus;
  final int? supplyStatus;
  final String material;
  final String? sloc;
  final String? descriptions;
  final String? kittingTimeType;
  final int? kittingType;
  final String model;
  final String? location;
  final String? time;
  final int pickedQuantity;
  final String? frequency;

  @override
  KittingDetail copyWith({int? pickedQuantity}) {
    return KittingDetail(
      id: id,
      kittingListID: kittingListID,
      unit: unit,
      locationName: locationName,
      picUser: picUser,
      barcode: barcode,
      kittingStatus: kittingStatus,
      sloc: sloc,
      descriptions: descriptions,
      kittingTimeType: kittingTimeType,
      kittingType: kittingType,
      location: location,
      time: time,
      quantity: quantity,
      material: material,
      model: model,
      pickedQuantity: pickedQuantity ?? 0,
      frequency: frequency,
    );
  }
}
