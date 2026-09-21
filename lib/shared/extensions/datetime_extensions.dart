import 'package:easy_localization/easy_localization.dart';

enum DateTimeType {
  date('dd/MM/yyyy'),
  MMddyyyy('MM/dd/yyyy'),
  yyyyMMdd('yyyy-MM-dd'),
  time('hh:mm:ss'),
  dateSimplify('yyyyMMdd'),
  dateFull('MM/dd/yyyy hh:mm:ss a'),
  dateFUll2('yyyy-MM-dd HH:mm:ss'),
  dateFUll3('yyyy-MM-ddTHH:mm:ss');

  const DateTimeType(this.dateFormat);

  final String dateFormat;
}

extension DateToStringExtensions on DateTime {
  String toText([DateTimeType type = DateTimeType.date]) {
    return DateFormat(type.dateFormat).format(this);
  }
}

extension StringToDateExtensions on String {
  DateTime? toDate([DateTimeType type = DateTimeType.date]) {
    try {
      if (type == DateTimeType.dateSimplify) {
        return DateTime.parse(this);
      }
      return DateFormat(type.dateFormat, 'en').parse(this);
    } catch (e) {
      return null;
    }
  }

  bool isDate([DateTimeType type = DateTimeType.date]) {
    return toDate(type) != null;
  }
}
