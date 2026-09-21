// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kitting_detail_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KittingDetailResponseModel _$KittingDetailResponseModelFromJson(
        Map<String, dynamic> json) =>
    KittingDetailResponseModel(
      uploadNo: json['uploadNo'] as String?,
      reason: json['reason'] as String?,
      kittingTimeType: json['kittingTimeType'] as String?,
      id: (json['id'] as num?)?.toInt(),
      kittingListID: (json['kittingListID'] as num?)?.toInt(),
      quantity: (json['quantity'] as num).toDouble(),
      unit: json['unit'] as String?,
      locationName: json['locationName'] as String?,
      picUser: json['picUser'] as String?,
      barcode: json['barcode'] as String?,
      kittingStatus: (json['kittingStatus'] as num?)?.toInt(),
      supplyStatus: (json['supplyStatus'] as num?)?.toInt(),
      material: json['material'] as String,
      sloc: json['sloc'] as String?,
      descriptions: json['descriptions'] as String?,
      kittingType: (json['kittingType'] as num?)?.toInt(),
      model: json['model'] as String,
      location: json['location'] as String?,
      time: json['time'] as String?,
      pickedQuantity: (json['pickedQuantity'] as num).toDouble(),
      frequency: json['frequency'] as String?,
      plant: json['plant'] as String?,
      line: json['line'] as String?,
      category: json['category'] as String?,
      countQtyKittingEnough: (json['countQtyKittingEnough'] as num?)?.toInt(),
      deliveryDate: json['deliveryDate'] == null
          ? null
          : DateTime.parse(json['deliveryDate'] as String),
      pl: json['pl'] as String?,
      isOverdue: json['isOverdue'] as bool,
      missingItem: json['missingItem'] as String?,
      materialReplace: json['materialReplace'] as String?,
      quantityReplace: (json['quantityReplace'] as num?)?.toInt(),
      sameMaterial: json['sameMaterial'] as bool,
    );

Map<String, dynamic> _$KittingDetailResponseModelToJson(
        KittingDetailResponseModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'kittingListID': instance.kittingListID,
      'quantity': instance.quantity,
      'unit': instance.unit,
      'locationName': instance.locationName,
      'picUser': instance.picUser,
      'barcode': instance.barcode,
      'kittingStatus': instance.kittingStatus,
      'supplyStatus': instance.supplyStatus,
      'material': instance.material,
      'sloc': instance.sloc,
      'descriptions': instance.descriptions,
      'kittingTimeType': instance.kittingTimeType,
      'kittingType': instance.kittingType,
      'model': instance.model,
      'location': instance.location,
      'time': instance.time,
      'line': instance.line,
      'pickedQuantity': instance.pickedQuantity,
      'frequency': instance.frequency,
      'plant': instance.plant,
      'category': instance.category,
      'countQtyKittingEnough': instance.countQtyKittingEnough,
      'deliveryDate': instance.deliveryDate?.toIso8601String(),
      'pl': instance.pl,
      'uploadNo': instance.uploadNo,
      'reason': instance.reason,
      'isOverdue': instance.isOverdue,
      'missingItem': instance.missingItem,
      'materialReplace': instance.materialReplace,
      'quantityReplace': instance.quantityReplace,
      'sameMaterial': instance.sameMaterial,
    };
