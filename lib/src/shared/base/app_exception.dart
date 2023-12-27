class AppException implements Exception {
  final String message;
  final int? code;

  AppException(this.message, {this.code = 300});
}

AppException convertException(e, {noReport = false, dynamic stackTrace}) {
  if (e is AppException) return e;
  return AppException('Internal Error', code: 300);
}

void reportIfException(dynamic anything) {
  () async {
    try {
      await anything;
    } catch (e) {}
  }();
}
