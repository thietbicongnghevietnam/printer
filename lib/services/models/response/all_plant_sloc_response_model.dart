import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_response_model.dart';
import 'info_last_lot_response_model.dart';
import 'material_response_model.dart';

part 'all_plant_sloc_response_model.g.dart';

@JsonSerializable()
class AllPlantSlocResponseModel extends BaseResponseModel {
  const AllPlantSlocResponseModel({
    this.records,
  });

  factory AllPlantSlocResponseModel.fromJson(Map<String, dynamic> json) =>
      _$AllPlantSlocResponseModelFromJson(json);

  final List<PlantSlocResponseModel>? records;

  @override
  Map<String, dynamic> toJson() => _$AllPlantSlocResponseModelToJson(this);
}

@JsonSerializable()
class PlantSlocResponseModel extends BaseResponseModel {
  const PlantSlocResponseModel({
    this.plant,
    this.material,
    this.sloc,
    this.type,
    this.specialPart,
    this.frequency,
    this.category,
  });

  factory PlantSlocResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PlantSlocResponseModelFromJson(json);

  final String? plant;
  final String? material;
  final String? sloc;
  final String? type;
  final String? specialPart;
  final String? frequency;
  final String? category;

  @override
  Map<String, dynamic> toJson() => _$PlantSlocResponseModelToJson(this);
}
