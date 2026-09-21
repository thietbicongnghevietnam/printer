import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/services/models/response/base_response_model.dart';


part 'qty_by_location_response_model.g.dart';

@JsonSerializable()
class QtyByLocationResponseModel extends BaseResponseModel {
  const QtyByLocationResponseModel( {
    this.name, this.totalQty,
  });

  factory QtyByLocationResponseModel.fromJson(
      Map<String, dynamic> json) =>
      _$QtyByLocationResponseModelFromJson(json);

  final String? name;
  final double? totalQty;


  @override
  Map<String, dynamic> toJson() =>
      _$QtyByLocationResponseModelToJson(this);
}
