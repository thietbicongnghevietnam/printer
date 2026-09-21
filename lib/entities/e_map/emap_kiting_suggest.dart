import 'package:smart_warehouse/entities/e_map/emap_floor.dart';
import 'package:smart_warehouse/shared/utils/copyable.dart';

import 'order_block.dart';
import 'suggest_path.dart';

class EMapKittingSuggest implements Copyable<EMapKittingSuggest> {
  EMapKittingSuggest({
    required this.layoutMap,
    this.orderBlock,
    this.suggestPath,
  });

  EMapFloor layoutMap;
  List<OrderBlock>? orderBlock;
  List<SuggestPath>? suggestPath;

  @override
  EMapKittingSuggest copyWith() {
    return EMapKittingSuggest(
      orderBlock: orderBlock,
      suggestPath: suggestPath,
      layoutMap: layoutMap,
    );
  }
}
