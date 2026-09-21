import 'package:json_annotation/json_annotation.dart';

import 'base_response_model.dart';

part 'location_response_model.g.dart';

@JsonSerializable()
class LocationResponseModel extends BaseResponseModel {
  LocationResponseModel({
    this.location,
    this.material,
    this.currentQuantity,
  });

  factory LocationResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LocationResponseModelFromJson(json);

  final String? location;
  final String? material;

  final int? currentQuantity;

  @override
  Map<String, dynamic> toJson() => _$LocationResponseModelToJson(this);
}
