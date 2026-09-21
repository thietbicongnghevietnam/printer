// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'combine_pallet_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CombinePalletRequestModel _$CombinePalletRequestModelFromJson(
        Map<String, dynamic> json) =>
    CombinePalletRequestModel(
      temporaryAreaCodeOld: json['temporaryAreaCodeOld'] as String?,
      temporaryAreaCodeNew: json['temporaryAreaCodeNew'] as String,
      receivingCardIds: (json['receivingCardIds'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
    );

Map<String, dynamic> _$CombinePalletRequestModelToJson(
        CombinePalletRequestModel instance) =>
    <String, dynamic>{
      'temporaryAreaCodeOld': instance.temporaryAreaCodeOld,
      'temporaryAreaCodeNew': instance.temporaryAreaCodeNew,
      'receivingCardIds': instance.receivingCardIds,
    };
