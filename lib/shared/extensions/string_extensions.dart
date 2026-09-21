extension StringExt on String {
  (String, String) splitString(int length) {
    final arr = split(' ');

    var s1 = '';
    var s2 = '';

    var isBreakLine = false;

    for (final element in arr) {
      if (!isBreakLine && s1.length + element.length + 1 <= length) {
        s1 += '$element ';
      } else {
        isBreakLine = true;
        s2 += '$element ';
      }
    }

    return (s1, s2);
  }

  bool isPo() {
    final regex = RegExp(r'^45.*$');
    return regex.hasMatch(this);
  }
}

extension StringNullableExt on String? {
  bool isEmpty() => (this ?? '').isEmpty;

  bool isNotEmpty() => (this ?? '').isNotEmpty;

  int toInt({int defaultValue = 0}) {
    return num.tryParse(this ?? '')?.toInt() ?? defaultValue;
  }

  bool toBool({bool defaultValue = false}) {
    return this == 'true';
  }

  double toDouble({double defaultValue = 0.0}) {
    return double.tryParse(this ?? '') ?? defaultValue;
  }

  bool get isInt => int.tryParse(this ?? '') != null;

  bool materialCompare(String? other) {
    return (_formatString()?.contains(other._formatString() ?? '') ?? false) ||
        (other._formatString()?.contains(_formatString() ?? '') ?? false);
  }

  String? _formatString() {
    return this?.toUpperCase().replaceAll('0', 'O').replaceAll('1', 'I');
  }
}

extension MacAddressFormatting on String {
  String? formatMacAddress() {
    final formattedMacAddress = replaceAll(RegExp(r'[^0-9A-Fa-f]'), '');

    if (formattedMacAddress.length != 12) {
      return null;
    }

    return List.generate(
      6,
      (index) => formattedMacAddress.substring(2 * index, 2 * index + 2),
    ).join(':');
  }
}
