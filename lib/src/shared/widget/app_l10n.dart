import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather_app_assignment/src/device/l10n.dart';
import 'package:weather_app_assignment/src/shared/base/do_action.dart';

class AppL10n extends StatefulWidget {
  final Widget child;

  const AppL10n({super.key, required this.child});

  @override
  createState() => _State();
}

class _State extends State<AppL10n> with ActionMixin {
  AppLocale? _appLocale;
  bool _listened = false;
  late StreamSubscription subscription;

  @override
  initState() {
    subscription = localeUpdateStream.listen((event) {
      _listened = true;
      if (!mounted) return;
      if (_appLocale == event) return;
      setState(() {
        _appLocale = event;
      });
    });
    doInit(() async {
      final locale = await getAppLocale();
      if (!mounted) return;
      if (_listened) return;
      setState(() {
        _appLocale = locale;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
  }

  @override
  build(context) {
    final systemLocale = Localizations.localeOf(context);
    return Localizations.override(
        context: context,
        locale: _appLocale?.locale ?? systemLocale,
        child: widget.child);
  }
}
