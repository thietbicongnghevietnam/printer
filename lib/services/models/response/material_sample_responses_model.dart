import 'package:json_annotation/json_annotation.dart';

import 'base_response_model.dart';

part 'material_sample_responses_model.g.dart';

@JsonSerializable()
class MaterialSampleResponseModel extends BaseResponseModel {
  MaterialSampleResponseModel({
    this.name,
    this.material,
    this.id,
    this.description,
    this.filePath,
    this.fileBase64,
  });

  factory MaterialSampleResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MaterialSampleResponseModelFromJson(json);

  final String? name;
  final String? material;
  final String? description;
  final String? filePath;

  @JsonKey(name: 'fileBase64')
  final String? fileBase64;

  final int? id;

  @override
  Map<String, dynamic> toJson() => _$MaterialSampleResponseModelToJson(this);
}
