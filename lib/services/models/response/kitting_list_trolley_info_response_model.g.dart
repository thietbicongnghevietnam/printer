// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kitting_list_trolley_info_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KittingListTrolleyInfoResponsesModel
    _$KittingListTrolleyInfoResponsesModelFromJson(Map<String, dynamic> json) =>
        KittingListTrolleyInfoResponsesModel(
          trolleyCodeList: (json['codeTrolleys'] as List<dynamic>?)
                  ?.map((e) => e as String)
                  .toList() ??
              const [],
          kittingList: json['kittingList'] == null
              ? null
              : KittingResponseModel.fromJson(
                  json['kittingList'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$KittingListTrolleyInfoResponsesModelToJson(
        KittingListTrolleyInfoResponsesModel instance) =>
    <String, dynamic>{
      'codeTrolleys': instance.trolleyCodeList,
      'kittingList': instance.kittingList,
    };
