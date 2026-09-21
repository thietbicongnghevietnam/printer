import 'package:json_annotation/json_annotation.dart';

part 'map_suggest_widget_response_model.g.dart';

@JsonSerializable()
class MapSuggestWidgetResponseModel {
  MapSuggestWidgetResponseModel({
    this.floorId,
    this.swmsZones,
    this.isSuggested = false,
    this.totalStoredQty,
    this.floorName,
    this.lastLotName,
    this.totalTemp,
    this.floorCode,
  });

  factory MapSuggestWidgetResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MapSuggestWidgetResponseModelFromJson(json);

  int? floorId;
  final int? totalStoredQty;
  final int? totalTemp;

  bool? isSuggested;

  String? floorName;
  String? floorCode;
  final String? lastLotName;

  final List<ZoneSuggestWidgetResponseModel>? swmsZones;

  @override
  Map<String, dynamic> toJson() => _$MapSuggestWidgetResponseModelToJson(this);
}

@JsonSerializable()
class ZoneSuggestWidgetResponseModel {
  ZoneSuggestWidgetResponseModel({
    this.zoneId,
    this.isSuggested,
    this.totalStoredQty,
    this.totalTemp,
    this.lastLotName,
    this.isJIT,
    this.swmsRacks,
    this.isDIP,
  });

  factory ZoneSuggestWidgetResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ZoneSuggestWidgetResponseModelFromJson(json);

  final int? zoneId;
  final int? totalStoredQty;
  final int? totalTemp;

  final bool? isJIT;
  final bool? isSuggested;
  final bool? isDIP;

  final String? lastLotName;

  final List<RackSuggestWidgetResponseModel>? swmsRacks;

  @override
  Map<String, dynamic> toJson() => _$ZoneSuggestWidgetResponseModelToJson(this);
}

@JsonSerializable()
class RackSuggestWidgetResponseModel {
  RackSuggestWidgetResponseModel({
    this.rackId,
    this.rackDetailType,
    this.isSuggested,
    this.lastLotName,
    this.isJIT,
  });

  factory RackSuggestWidgetResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RackSuggestWidgetResponseModelFromJson(json);

  final int? rackId;

  final bool? isSuggested;
  final bool? isJIT;

  final String? lastLotName;
  final String? rackDetailType;

  @override
  Map<String, dynamic> toJson() => _$RackSuggestWidgetResponseModelToJson(this);
}
