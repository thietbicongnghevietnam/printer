import 'package:smart_warehouse/shared/utils/copyable.dart';

class SuggestPath implements Copyable<SuggestPath> {
  SuggestPath({
    this.x = 0,
    this.y = 0,
  });

  final double x;
  final double y;

  @override
  SuggestPath copyWith() {
    return SuggestPath(
      x: x,
      y: y,
    );
  }
}
