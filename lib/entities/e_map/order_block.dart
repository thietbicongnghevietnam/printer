import 'package:smart_warehouse/shared/utils/copyable.dart';

class OrderBlock implements Copyable<OrderBlock> {
  OrderBlock({
    this.name,
    this.x = 0,
    this.y = 0,
    this.width = 0,
    this.height = 0,
  });

  final String? name;

  final double x;
  final double y;
  final double width;
  final double height;

  @override
  OrderBlock copyWith() {
    return OrderBlock(
      name: name,
      x: x,
      y: y,
      width: width,
      height: height,
    );
  }
}
