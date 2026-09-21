// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kitting_card_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KittingCardRequestItemModel _$KittingCardRequestItemModelFromJson(
        Map<String, dynamic> json) =>
    KittingCardRequestItemModel(
      index: (json['index'] as num).toInt(),
      id: (json['id'] as num).toInt(),
    );

Map<String, dynamic> _$KittingCardRequestItemModelToJson(
        KittingCardRequestItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'index': instance.index,
    };

KittingCardRequestModel _$KittingCardRequestModelFromJson(
        Map<String, dynamic> json) =>
    KittingCardRequestModel(
      rcDetailIDs: (json['rcDetailIDs'] as List<dynamic>?)
          ?.map((e) =>
              KittingCardRequestItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      rciDs: (json['rciDs'] as List<dynamic>?)
          ?.map((e) =>
              KittingCardRequestItemModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      kittingListDetailId: (json['kittingListDetailId'] as num?)?.toInt(),
      quantity: (json['quantity'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$KittingCardRequestModelToJson(
        KittingCardRequestModel instance) =>
    <String, dynamic>{
      'rcDetailIDs': instance.rcDetailIDs,
      'rciDs': instance.rciDs,
      'kittingListDetailId': instance.kittingListDetailId,
      'quantity': instance.quantity,
    };
