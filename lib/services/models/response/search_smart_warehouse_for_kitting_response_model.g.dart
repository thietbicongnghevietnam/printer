// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_smart_warehouse_for_kitting_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchSmartWarehouseForKittingResponseModel
    _$SearchSmartWarehouseForKittingResponseModelFromJson(
            Map<String, dynamic> json) =>
        SearchSmartWarehouseForKittingResponseModel(
          records: (json['records'] as List<dynamic>)
              .map((e) => KittingDetailResponseModel.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
          totalRecord: (json['totalRecord'] as num).toInt(),
          orderBlock: (json['orderBlock'] as List<dynamic>?)
                  ?.map((e) => OrderBlockResponseModel.fromJson(
                      e as Map<String, dynamic>))
                  .toList() ??
              const [],
          suggestPath: (json['suggestPath'] as List<dynamic>?)
                  ?.map((e) => SuggestPathResponseModel.fromJson(
                      e as Map<String, dynamic>))
                  .toList() ??
              const [],
        );

Map<String, dynamic> _$SearchSmartWarehouseForKittingResponseModelToJson(
        SearchSmartWarehouseForKittingResponseModel instance) =>
    <String, dynamic>{
      'records': instance.records,
      'totalRecord': instance.totalRecord,
      'orderBlock': instance.orderBlock,
      'suggestPath': instance.suggestPath,
    };
