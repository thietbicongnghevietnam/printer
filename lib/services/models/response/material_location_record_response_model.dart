import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/services/models/response/base_response_model.dart';

part 'material_location_record_response_model.g.dart';

@JsonSerializable()
class MaterialLocationRecordResponseModel extends BaseResponseModel {
  const MaterialLocationRecordResponseModel({
    this.currentQuantity,
    this.totalQuantity,
    this.blockName,
    this.zoneName,
    this.rackCode,
    this.floorName,
  });

  factory MaterialLocationRecordResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$MaterialLocationRecordResponseModelFromJson(json);

  final int? currentQuantity;
  final int? totalQuantity;

  final String? blockName;
  final String? zoneName;
  final String? rackCode;
  final String? floorName;

  @override
  Map<String, dynamic> toJson() =>
      _$MaterialLocationRecordResponseModelToJson(this);
}
