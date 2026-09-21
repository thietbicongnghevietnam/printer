import 'dart:math';

import 'package:easy_localization/easy_localization.dart';

extension DoubleExt on double {
  double toPrecision(int fractionDigits) {
    final mod = pow(10, fractionDigits.toDouble()).toDouble();
    return (this * mod).round().toDouble() / mod;
  }

  Duration get milliseconds => Duration(microseconds: (this * 1000).round());

  Duration get ms => milliseconds;

  Duration get seconds => Duration(milliseconds: (this * 1000).round());

  Duration get minutes =>
      Duration(seconds: (this * Duration.secondsPerMinute).round());

  Duration get hours =>
      Duration(minutes: (this * Duration.minutesPerHour).round());

  Duration get days => Duration(hours: (this * Duration.hoursPerDay).round());

  String formatWithComma() {
    final numberFormat = NumberFormat('###,###.##', 'vi_VN');
    return numberFormat.format(this);
  }

  bool isBetween(num min, num max) {
    return this >= min && this <= max;
  }
}


