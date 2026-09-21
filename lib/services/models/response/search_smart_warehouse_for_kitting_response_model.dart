import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/services/models/response/kitting_detail_response_model.dart';
import 'package:smart_warehouse/services/models/response/order_block_response_model.dart';
import 'package:smart_warehouse/services/models/response/suggest_path_response_model.dart';

part 'search_smart_warehouse_for_kitting_response_model.g.dart';

@JsonSerializable()
class SearchSmartWarehouseForKittingResponseModel {
  const SearchSmartWarehouseForKittingResponseModel({
    required this.records,
    required this.totalRecord,
    this.orderBlock = const [],
    this.suggestPath = const [],
  });

  factory SearchSmartWarehouseForKittingResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$SearchSmartWarehouseForKittingResponseModelFromJson(json);

  final List<KittingDetailResponseModel> records;
  final int totalRecord;
  final List<OrderBlockResponseModel> orderBlock;
  final List<SuggestPathResponseModel> suggestPath;

  Map<String, dynamic> toJson() =>
      _$SearchSmartWarehouseForKittingResponseModelToJson(this);
}
