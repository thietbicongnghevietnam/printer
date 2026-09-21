import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_response_model.dart';

part 'plant_category_response_model.g.dart';

@JsonSerializable()
class PlantCategoryResponseModel extends BaseResponseModel {
  const PlantCategoryResponseModel({
    this.plant,
    this.sloc,
    this.category,
    this.specialPart,
  });

  factory PlantCategoryResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PlantCategoryResponseModelFromJson(json);

  final String? plant;
  final String? sloc;
  final String? category;
  final String? specialPart;

  @override
  Map<String, dynamic> toJson() => _$PlantCategoryResponseModelToJson(this);
}
