import 'package:flutter/cupertino.dart';

class GlobalData {
  static final GlobalData _inst = GlobalData._internal();

  GlobalData._internal();

  static GlobalData get instance => _inst;

  factory GlobalData() {
    return _inst;
  }

  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  bool _isLoading = false;

  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  BuildContext get context => _navigatorKey.currentContext!;

  bool get isLoading => _isLoading;

  set isLoading(value) => _isLoading = value;
}
