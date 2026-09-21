// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_trolleykitting_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateTrolleyKittingRequestModel _$CreateTrolleyKittingRequestModelFromJson(
        Map<String, dynamic> json) =>
    CreateTrolleyKittingRequestModel(
      kittingList: (json['barCodeKittingList'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      trolley: json['barCodeTrolley'] as String,
    );

Map<String, dynamic> _$CreateTrolleyKittingRequestModelToJson(
        CreateTrolleyKittingRequestModel instance) =>
    <String, dynamic>{
      'barCodeKittingList': instance.kittingList,
      'barCodeTrolley': instance.trolley,
    };
