import 'package:json_annotation/json_annotation.dart';

import 'base_response_model.dart';
import 'block_detail_response_model.dart';

part 'column_rack_response_model.g.dart';

@JsonSerializable()
class ColumnRackResponseModel extends BaseResponseModel {
  ColumnRackResponseModel({
    this.listBlockData,
  });

  factory ColumnRackResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ColumnRackResponseModelFromJson(json);

  final List<BlockDetailResponseModel>? listBlockData;

  @override
  Map<String, dynamic> toJson() => _$ColumnRackResponseModelToJson(this);
}
