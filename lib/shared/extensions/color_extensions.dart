import 'dart:ui';

extension ColorsExtension on String? {
  Color _hexToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  Color _rgbaToColor(String rgbaString) {
    final rgba = rgbaString.replaceAll(RegExp(r'[^\d,\.]'), '').split(',');
    return Color.fromRGBO(
      int.parse(rgba[0]),
      int.parse(rgba[1]),
      int.parse(rgba[2]),
      double.parse(rgba[3]),
    );
  }

  Color _rgbToColor(String rgbString) {
    final rgb = rgbString.replaceAll(RegExp(r'[^\d,]'), '').split(',');
    return Color.fromRGBO(
      int.parse(rgb[0]),
      int.parse(rgb[1]),
      int.parse(rgb[2]),
      1.0,
    );
  }

  Color toColor() {
    final colorString = this;
    if (colorString == null || colorString == 'null') {
      return const Color(0x00000000);
    }

    if (colorString.startsWith('#')) {
      // Xử lý định dạng hex
      return _hexToColor(colorString);
    } else if (colorString.startsWith('rgba')) {
      // Xử lý định dạng rgba
      return _rgbaToColor(colorString);
    } else if (colorString.startsWith('rgb')) {
      // Xử lý định dạng rgb
      return _rgbToColor(colorString);
    } else {
      //Tuấn Anh check lỗi map
      print('JJJJ ${colorString ?? ''}');
      throw const FormatException('Invalid color format');
    }
  }
}
