import 'dart:math';

import 'package:smart_warehouse/shared/utils/copyable.dart';

class KittingDetail implements Copyable<KittingDetail> {
  KittingDetail({this.uploadNo, this.reason,
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
    this.line,
    required this.pickedQuantity,
    this.frequency,
    this.plant,
    this.category,
    this.countQtyKittingEnough,
    this.deliveryDate,
    this.pl,
    required this.isOverdue,
    this.missingItem,
    //Tuấn Anh thêm
    required this.sameMaterial
  });

  final int? id;
  final int? kittingListID;
  final double quantity;
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
  final String? line;
  final double pickedQuantity;
  final String? frequency;
  final String? plant;
  final String? category;
  final int? countQtyKittingEnough;
  final DateTime? deliveryDate;
  final String? pl;
  final String? uploadNo;
  final String? reason;
  final bool isOverdue;
  final String? missingItem;
  //Tuấn Anh thêm
  final bool sameMaterial;

  @override
  KittingDetail copyWith() {
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
      pickedQuantity: pickedQuantity,
      frequency: frequency,
      plant: plant,
      countQtyKittingEnough: countQtyKittingEnough,
      deliveryDate: deliveryDate,
      pl: pl,
      isOverdue: isOverdue,
      missingItem: missingItem,
        sameMaterial:sameMaterial,
    );
  }
}
