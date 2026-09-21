// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kitting_card_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KittingCardRequest _$KittingCardRequestFromJson(Map<String, dynamic> json) =>
    KittingCardRequest(
      kittingCardsRequests: (json['kittingCardsRequests'] as List<dynamic>?)
          ?.map((e) =>
              KittingCardRequestModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      isPreview: json['isPreview'] as bool?,
      material: json['material'] as String?,
      isSub: json['isSub'] as bool?,
    );

Map<String, dynamic> _$KittingCardRequestToJson(KittingCardRequest instance) =>
    <String, dynamic>{
      'kittingCardsRequests': instance.kittingCardsRequests,
      'isPreview': instance.isPreview,
      'material': instance.material,
      'isSub': instance.isSub,
    };
