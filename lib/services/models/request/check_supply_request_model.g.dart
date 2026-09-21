// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'check_supply_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CheckSupplyRequestModel _$CheckSupplyRequestModelFromJson(
        Map<String, dynamic> json) =>
    CheckSupplyRequestModel(
      kittingListId: (json['kittingListId'] as num?)?.toInt(),
      isSupplyLack: json['isSupplyLack'] as bool?,
    );

Map<String, dynamic> _$CheckSupplyRequestModelToJson(
        CheckSupplyRequestModel instance) =>
    <String, dynamic>{
      'kittingListId': instance.kittingListId,
      'isSupplyLack': instance.isSupplyLack,
    };
