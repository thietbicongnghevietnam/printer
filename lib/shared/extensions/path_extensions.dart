import 'dart:ui';

extension PathExtensions on String {
  Path toPath() {
    final path = Path();
    final commands = split(RegExp(r'(?=[MmLlZz])'));

    Offset currentPoint = const Offset(0, 0);

    for (String command in commands) {
      if (command.isEmpty) continue;

      final commandType = command[0];
      final values = command.substring(1).trim().split(RegExp(r'[ ,]+')).where((v) => v.isNotEmpty).map((v) => double.parse(v)).toList();

      switch (commandType) {
        case 'M':
          currentPoint = Offset(values[0], values[1]);
          path.moveTo(currentPoint.dx, currentPoint.dy);
          break;
        case 'L':
          currentPoint = Offset(values[0], values[1]);
          path.lineTo(currentPoint.dx, currentPoint.dy);
          break;
        case 'Z':
          path.close();
          break;
        default:
          throw Exception('Unsupported SVG command: $commandType');
      }
    }

    return path;
  }
}