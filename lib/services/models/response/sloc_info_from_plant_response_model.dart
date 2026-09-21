import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/services/models/response/base_response_model.dart';

import 'history_information_response_model.dart';

part 'sloc_info_from_plant_response_model.g.dart';

@JsonSerializable()
class SlocInfoFromPlantResponseModel extends BaseResponseModel {
  SlocInfoFromPlantResponseModel({
    this.sloc,
    this.type,
    this.frequency,
    this.category,
    this.specialPart,
  });

  factory SlocInfoFromPlantResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SlocInfoFromPlantResponseModelFromJson(json);

  String? sloc;
  String? type;
  String? frequency;
  String? specialPart;
  List<String>? category;

  @override
  Map<String, dynamic> toJson() => _$SlocInfoFromPlantResponseModelToJson(this);
}
