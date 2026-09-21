import 'package:json_annotation/json_annotation.dart';

import 'base_response_model.dart';

part 'stock_to_recard_response_model.g.dart';

@JsonSerializable()
class StockToReCardResponseModel extends BaseResponseModel  {
  StockToReCardResponseModel({
    this.samplingCheck,
    this.slocs,
    this.plant,
    this.rohs,
    this.iqcpl,
    this.rohsCheck,
  });

  factory StockToReCardResponseModel.fromJson(Map<String, dynamic> json) =>
      _$StockToReCardResponseModelFromJson(json);

  final int? samplingCheck;
  final int? rohsCheck;

  @JsonKey(name: 'sloc')
  final String? slocs;
  final String? plant;
  final String? rohs;
  final String? iqcpl;

  @override
  Map<String, dynamic> toJson() => _$StockToReCardResponseModelToJson(this);
}
