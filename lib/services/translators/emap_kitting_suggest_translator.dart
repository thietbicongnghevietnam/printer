import 'package:smart_warehouse/entities/e_map/emap_kiting_suggest.dart';
import 'package:smart_warehouse/entities/e_map/order_block.dart';
import 'package:smart_warehouse/entities/e_map/suggest_path.dart';
import 'package:smart_warehouse/services/models/response/emap_kitting_suggest_response_model.dart';
import 'package:smart_warehouse/services/models/response/order_block_response_model.dart';
import 'package:smart_warehouse/services/models/response/suggest_path_response_model.dart';
import 'package:smart_warehouse/services/translators/floor_translator.dart';

extension EMapKittingSuggestTranslator on EMapKittingSuggestResponseModel {
  EMapKittingSuggest toEntity() {
    return EMapKittingSuggest(
      layoutMap: layoutMap.toFloor(),
      orderBlock: orderBlock.map((e) => e.toEntity()).toList(),
      suggestPath: suggestPath.map((e) => e.toEntity()).toList(),
    );
  }
}

extension SuggestPathTranslator on SuggestPathResponseModel {
  SuggestPath toEntity() {
    return SuggestPath(
      x: x ?? 0,
      y: y ?? 0,
    );
  }
}

extension OrderBlockTranslator on OrderBlockResponseModel {
  OrderBlock toEntity() {
    return OrderBlock(
      name: name,
      x: x ?? 0,
      y: y ?? 0,
      width: width ?? 0,
      height: height ?? 0,
    );
  }
}