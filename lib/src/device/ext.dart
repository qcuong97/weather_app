import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:weather_app_assignment/src/shared/base/app_exception.dart';

extension AppExceptionExt on AppException {
  String messageError(BuildContext context) => switch (code) {
        401 => 'Unable to authenticate user\nPlease try again',
        404 => 'Not found',
        _ => 'Have a error\nPlease try again'
      };
}

extension StringExt on String {
  String toHourMinute() {
    final date = DateFormat('yyyy-MM-ddTHH:mm').parse(this);
    return DateFormat('HH:mm').format(date);
  }
}
