import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:smart_warehouse/services/models/response/base_response_model.dart';
import 'package:smart_warehouse/services/models/response/new_map_widget_response_model.dart';
import 'package:smart_warehouse/services/models/response/order_block_response_model.dart';
import 'package:smart_warehouse/services/models/response/suggest_path_response_model.dart';

part 'emap_kitting_suggest_response_model.g.dart';

@JsonSerializable()
class EMapKittingSuggestResponseModel extends BaseResponseModel {
  const EMapKittingSuggestResponseModel ({
  required this.layoutMap,
    this.orderBlock = const [],
    this.suggestPath = const [],
  });

  factory EMapKittingSuggestResponseModel.fromJson(Map<String, dynamic> json) =>
      _$EMapKittingSuggestResponseModelFromJson(json);

  final NewMapWidgetResponseModel layoutMap;
  final List<OrderBlockResponseModel> orderBlock;
  final List<SuggestPathResponseModel> suggestPath;

  @override
  Map<String, dynamic> toJson() =>
      _$EMapKittingSuggestResponseModelToJson(this);
}
