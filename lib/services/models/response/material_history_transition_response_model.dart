import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/services/models/response/base_response_model.dart';

import 'history_information_response_model.dart';

part 'material_history_transition_response_model.g.dart';

@JsonSerializable()
class MaterialHistoryTransitionResponseModel extends BaseResponseModel {
  const MaterialHistoryTransitionResponseModel({
    this.slocs,
    this.frequency,
    this.type,
    this.material,
    this.kind,
    this.totalStock,
    this.recordDetail,
  });

  factory MaterialHistoryTransitionResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$MaterialHistoryTransitionResponseModelFromJson(json);

  final String? material;
  final List<String>? slocs;
  final String? frequency;
  final String? type;
  final String? kind;

  final int? totalStock;

  final List<HistoryInformationResponseModel>? recordDetail;

  @override
  Map<String, dynamic> toJson() =>
      _$MaterialHistoryTransitionResponseModelToJson(this);
}
