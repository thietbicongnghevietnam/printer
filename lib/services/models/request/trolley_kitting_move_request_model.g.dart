// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trolley_kitting_move_request_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrolleyKittingMoveRequestModel _$TrolleyKittingMoveRequestModelFromJson(
        Map<String, dynamic> json) =>
    TrolleyKittingMoveRequestModel(
      trolleyOld: json['barCodeTrolleyOld'] as String?,
      trolleyNew: json['barCodeTrolleyNew'] as String?,
      barCodeKittingList: (json['barCodeKittingList'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$TrolleyKittingMoveRequestModelToJson(
        TrolleyKittingMoveRequestModel instance) =>
    <String, dynamic>{
      'barCodeTrolleyOld': instance.trolleyOld,
      'barCodeTrolleyNew': instance.trolleyNew,
      'barCodeKittingList': instance.barCodeKittingList,
    };
