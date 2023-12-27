import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

enum AppLocale {
  en(Locale('en')),
  vi(Locale('vi'));

  const AppLocale(this.locale);

  final Locale locale;

  get json => switch (this) {
        AppLocale.en => 'en',
        AppLocale.vi => 'vi',
      };

  static AppLocale? _fromJson(String json) => switch (json) {
        'en' => AppLocale.en,
        'vi' => AppLocale.vi,
        String() => null,
      };

  static AppLocale? _fromLocale(Locale locale) => switch (locale) {
        Locale(languageCode: 'en') => AppLocale.en,
        Locale(languageCode: 'vi') => AppLocale.vi,
        _ => null,
      };

  static AppLocale of(BuildContext context) =>
      _fromLocale(Localizations.localeOf(context)) ?? AppLocale.en;
}

AppLocalizations L(BuildContext context) => AppLocalizations.of(context)!;

const _keyName = 'l10n_locale';
StreamController<AppLocale?> _localeUpdateStreamController =
    StreamController<AppLocale?>.broadcast();
Stream<AppLocale?> localeUpdateStream = _localeUpdateStreamController.stream;

Future<AppLocale?> getAppLocale() async {
  final prefs = await SharedPreferences.getInstance();
  final locale = prefs.getString(_keyName);
  if (locale == null) {
    return null;
  }
  return AppLocale._fromJson(locale);
}

Future<void> setAppLocale(AppLocale locale) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(_keyName, locale.json);
  _localeUpdateStreamController.add(locale);
}

Future<void> clearAppLocale() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove(_keyName);
  _localeUpdateStreamController.add(null);
}

// ignore AppLocalization context, always return non-null
Future<AppLocale> getAppLocaleNonNull() async {
  // https://stackoverflow.com/a/62825776/1398479
  final appLocale = await getAppLocale();
  if (appLocale != null) return appLocale;

  final String defaultLocale = Platform.localeName;
  return defaultLocale.startsWith('vi') ? AppLocale.vi : AppLocale.en;
}
