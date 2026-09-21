import 'package:json_annotation/json_annotation.dart';
import 'package:smart_warehouse/services/models/response/block_detail_response_model.dart';

import 'base_response_model.dart';
import 'column_rack_response_model.dart';

part 'rack_detail_response_model.g.dart';

@JsonSerializable()
class RackDetailResponseModel extends BaseResponseModel {
  RackDetailResponseModel({
    this.rackId,
    this.rackCode,
    this.columnRackData,
    this.numberOfLayer,
    this.numberOfUnit,
    this.numberOfRow,
    this.numberOfColumn,
    this.blockList,
    this.rackType,
    int? offsetX,
    int? offsetY,
    int? height,
    int? width,
    this.isSuggested,
    this.zoneID,
    this.lastLot,
  })  : offsetX = offsetX?.toDouble(),
        offsetY = offsetY?.toDouble(),
        height = height?.toDouble(),
        width = width?.toDouble();

  factory RackDetailResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RackDetailResponseModelFromJson(json);

  final String? rackCode;
  final String? rackType;

  @JsonKey(name: 'rackID')
  final int? rackId;
  @JsonKey(name: 'zoneID')
  final int? zoneID;
  @JsonKey(name: 'numberOfLayer')
  final int? numberOfLayer;
  @JsonKey(name: 'numberOfUnit')
  final int? numberOfUnit;
  @JsonKey(name: 'numberOfRow')
  final int? numberOfRow;
  @JsonKey(name: 'numberOfColumn')
  final int? numberOfColumn;
  final int? lastLot;

  @JsonKey(name: 'x')
  final double? offsetX;
  @JsonKey(name: 'y')
  final double? offsetY;
  final double? height;
  final double? width;

  final bool? isSuggested;

  @JsonKey(name: 'blocks')
  final List<BlockDetailResponseModel>? blockList;

  final List<ColumnRackResponseModel>? columnRackData;

  @override
  Map<String, dynamic> toJson() => _$RackDetailResponseModelToJson(this);
}
