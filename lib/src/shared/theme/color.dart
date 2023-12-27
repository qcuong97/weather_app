import 'package:flutter/material.dart';

final primaryColor = MaterialColor(const Color(0xff18223f).value, const {});

final neuralColor = MaterialColor(const Color(0xff000000).value, const {
  0: Color(0xffffffff),
  50: Color(0xffe6e6e6),
  100: Color(0xffd3d3d3),
  200: Color(0xffF9F9F9),
  300: Color(0xff7a7a7a),
  400: Color(0xff4e4e4e),
  500: Color(0xff222222),
  800: Color(0xff222326)
});

final secondaryColor = MaterialColor(const Color(0xffd9665b).value, const {
  200: Color(0xfff0c2bd),
  300: Color(0xffe8a39d),
  400: Color(0xffe1857c),
  500: Color(0xffd9665b)
});

final tertiaryColor = MaterialColor(const Color(0xffa6786d).value, const {
  200: Color(0xffdbc9c5),
  300: Color(0xffcaaea7),
  400: Color(0xffb8938a),
  500: Color(0xffa6786d),
});

final quaternaryColor = MaterialColor(const Color(0xfff2d98d).value, const {
  200: Color(0xfffaf0d1),
  300: Color(0xfff7e8bb),
  400: Color(0xfff5e1a4),
  500: Color(0xfff2d98d),
});

enum AccentSwatch {
  green(Color(0xff189315)),
  orange(Color(0xffffba52)),
  red(Color(0xffdc3704)),
  blue(Color(0xff4b95eb));

  const AccentSwatch(this.color);

  final Color color;
}

const Color purple = Color(0xff18223f);
const Color pink = Color(0xff9a38ab);
const Color yellow = Color(0xffDDB130);

const backgroundDecoration = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [purple, pink]);
