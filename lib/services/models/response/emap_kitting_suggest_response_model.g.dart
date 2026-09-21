// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'emap_kitting_suggest_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EMapKittingSuggestResponseModel _$EMapKittingSuggestResponseModelFromJson(
        Map<String, dynamic> json) =>
    EMapKittingSuggestResponseModel(
      layoutMap: NewMapWidgetResponseModel.fromJson(
          json['layoutMap'] as Map<String, dynamic>),
      orderBlock: (json['orderBlock'] as List<dynamic>?)
              ?.map((e) =>
                  OrderBlockResponseModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      suggestPath: (json['suggestPath'] as List<dynamic>?)
              ?.map((e) =>
                  SuggestPathResponseModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$EMapKittingSuggestResponseModelToJson(
        EMapKittingSuggestResponseModel instance) =>
    <String, dynamic>{
      'layoutMap': instance.layoutMap,
      'orderBlock': instance.orderBlock,
      'suggestPath': instance.suggestPath,
    };
