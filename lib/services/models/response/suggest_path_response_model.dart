import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/services/models/response/base_response_model.dart';

part 'suggest_path_response_model.g.dart';

@JsonSerializable()
class SuggestPathResponseModel extends BaseResponseModel {
  const SuggestPathResponseModel({
    this.x,
    this.y,
  });

  factory SuggestPathResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SuggestPathResponseModelFromJson(json);

  final double? x;
  final double? y;

  @override
  Map<String, dynamic> toJson() => _$SuggestPathResponseModelToJson(this);
}
