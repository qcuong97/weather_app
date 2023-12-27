import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:weather_app_assignment/src/device/global_data.dart';
import 'package:weather_app_assignment/src/device/l10n.dart';
import 'package:weather_app_assignment/src/service/service.dart';
import 'package:weather_app_assignment/src/shared/theme/theme.dart';
import 'package:weather_app_assignment/src/shared/widget/app_l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:weather_app_assignment/src/uis/home_screen/home_screen.dart';
import 'package:weather_app_assignment/src/uis/splash_screen/splash_screen.dart';

Future<void> mainApp() async {
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  APIService();
  GlobalData();
  runApp(MaterialApp(
      navigatorKey: GlobalData.instance.navigatorKey,
      builder: (context, child) =>
          child != null ? AppL10n(child: child) : const SizedBox.shrink(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        for (final appLocale in AppLocale.values) appLocale.locale
      ],
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.light,
      initialRoute: SplashScreen.routeName,
      onGenerateRoute: _routerConfig));
}

Route<dynamic>? _routerConfig(RouteSettings settings) =>
    switch (settings.name) {
      SplashScreen.routeName =>
        MaterialPageRoute(builder: (ctx) => const SplashScreen()),
      HomeScreen.routeName =>
        MaterialPageRoute(builder: (ctx) => const HomeScreen()),
      _ => MaterialPageRoute(builder: (ctx) => const SizedBox.shrink())
    };
