import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_response_model.dart';

part 'kitting_detail_response_model.g.dart';

@JsonSerializable()
class KittingDetailResponseModel extends BaseResponseModel {
  KittingDetailResponseModel( {
    this.uploadNo, this.reason,
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
    this.kittingType,
    required this.model,
    this.location,
    this.time,
    required this.pickedQuantity,
    this.frequency,
    this.plant,
    this.line,
    this.category,
    this.countQtyKittingEnough,
    this.deliveryDate,
    this.pl,
    required this.isOverdue,
    this.missingItem,
    this.materialReplace,
    this.quantityReplace,
    //Tuấn Anh thêm
    required this.sameMaterial
  });
  factory KittingDetailResponseModel.fromJson(Map<String, dynamic> json) =>
      _$KittingDetailResponseModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$KittingDetailResponseModelToJson(this);

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
  final String? materialReplace;
  final int? quantityReplace;
  //Tuấn Anh thêm
  final bool sameMaterial;
}
