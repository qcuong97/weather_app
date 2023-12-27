import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:weather_app_assignment/main.dart';
import 'package:weather_app_assignment/src/device/flavor_config.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final variables =
      await rootBundle.loadString('assets/config/config_dev.json');
  FlavorConfig(variables: jsonDecode(variables), type: FlavorType.dev);
  mainApp();
}
