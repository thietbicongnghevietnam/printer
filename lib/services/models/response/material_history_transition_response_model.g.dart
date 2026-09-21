// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material_history_transition_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MaterialHistoryTransitionResponseModel
    _$MaterialHistoryTransitionResponseModelFromJson(
            Map<String, dynamic> json) =>
        MaterialHistoryTransitionResponseModel(
          slocs: (json['slocs'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList(),
          frequency: json['frequency'] as String?,
          type: json['type'] as String?,
          material: json['material'] as String?,
          kind: json['kind'] as String?,
          totalStock: (json['totalStock'] as num?)?.toInt(),
          recordDetail: (json['recordDetail'] as List<dynamic>?)
              ?.map((e) => HistoryInformationResponseModel.fromJson(
                  e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$MaterialHistoryTransitionResponseModelToJson(
        MaterialHistoryTransitionResponseModel instance) =>
    <String, dynamic>{
      'material': instance.material,
      'slocs': instance.slocs,
      'frequency': instance.frequency,
      'type': instance.type,
      'kind': instance.kind,
      'totalStock': instance.totalStock,
      'recordDetail': instance.recordDetail,
    };
