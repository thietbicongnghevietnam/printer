import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/services/models/response/base_response_model.dart';

import 'history_information_response_model.dart';
import 'sloc_info_from_plant_response_model.dart';

part 'plant_type_freqquency_response_model.g.dart';

@JsonSerializable()
class PlantTypeFrequencyResponseModel extends BaseResponseModel {
  const PlantTypeFrequencyResponseModel({
    this.plant,
    this.slocs,
  });

  factory PlantTypeFrequencyResponseModel.fromJson(
      Map<String, dynamic> json) =>
      _$PlantTypeFrequencyResponseModelFromJson(json);

  final String? plant;
  final List<SlocInfoFromPlantResponseModel>? slocs;


  @override
  Map<String, dynamic> toJson() =>
      _$PlantTypeFrequencyResponseModelToJson(this);
}
