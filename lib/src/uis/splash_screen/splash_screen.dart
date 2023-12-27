import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:weather_app_assignment/src/device/l10n.dart';
import 'package:weather_app_assignment/src/shared/theme/color.dart';
import 'package:weather_app_assignment/src/uis/home_screen/home_screen.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/';

  const SplashScreen({super.key});

  @override
  createState() => _State();
}

class _State extends State<SplashScreen> {
  @override
  build(_) => Scaffold(
        body: Container(
            decoration: const BoxDecoration(gradient: backgroundDecoration),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(32.0),
                    child: Image.asset(
                      'assets/icon/ic_sun.png',
                    ),
                  ),
                ),
                Expanded(
                    flex: 1,
                    child: Image.asset(
                      'assets/icon/ic_weather_forecat.png',
                    )),
                Flexible(
                  child: OutlinedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, HomeScreen.routeName),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(yellow)),
                    child: Text(
                      L(context).get_start,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium
                          ?.copyWith(color: purple),
                    ),
                  ),
                )
              ],
            )),
      );
}
