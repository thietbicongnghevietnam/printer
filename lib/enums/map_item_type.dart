import 'package:smart_warehouse/shared/common/error_entity.dart';

enum WidgetMapType {
  group(0),
  floor(1),
  zone(2),
  rack(3),
  zoneSingleDoor(4),
  zoneDoubleDoor(5),
  zoneNoDoor(6),
  rectangle(7),
  circle(8),
  line(9),
  arrow(10),
  arrowFill(11),
  text(12),
  door(13),
  singleDoor(14),
  doubleDoor(15),
  noDoor(16),
  trolley(17),
  robotLine(18),
  ladder(19),
  wall(20),
  folklift(100),
  folkliftWorking(101),
  container(102),
  forklift2(103),
  container2(104);

  const WidgetMapType(this.code);

  final int code;

  static WidgetMapType fromCode(int code) {
    return switch (code) {
      0 => group,
      1 => floor,
      2 => zone,
      3 => rack,
      4 => zoneSingleDoor,
      5 => zoneDoubleDoor,
      6 => zoneNoDoor,
      7 => rectangle,
      8 => circle,
      9 => line,
      10 => arrow,
      11 => arrowFill,
      12 => text,
      13 => door,
      14 => singleDoor,
      15 => doubleDoor,
      16 => noDoor,
      17 => trolley,
      18 => robotLine,
      19 => ladder,
      20 => wall,
      100 => folklift,
      101 => folkliftWorking,
      102 => container,
      103 => forklift2,
      104 => container2,
      _ => throw ErrorEntity(message: 'Widget Map Type in valid')
    };
  }
}
