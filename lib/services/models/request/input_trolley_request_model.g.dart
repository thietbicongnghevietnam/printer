// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'input_trolley_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InputTrolleyRequestModel _$InputTrolleyRequestModelFromJson(
        Map<String, dynamic> json) =>
    InputTrolleyRequestModel(
      kittingList: (json['barCodeKittingList'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      trolley: (json['barCodeTrolley'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$InputTrolleyRequestModelToJson(
        InputTrolleyRequestModel instance) =>
    <String, dynamic>{
      'barCodeKittingList': instance.kittingList,
      'barCodeTrolley': instance.trolley,
    };
