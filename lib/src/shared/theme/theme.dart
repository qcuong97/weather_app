import 'package:flutter/material.dart';
import 'package:weather_app_assignment/src/shared/theme/color.dart';

final _inputBorderRadius = BorderRadius.circular(8);
final appTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: primaryColor).copyWith(
    primary: primaryColor,
    secondary: secondaryColor,
    tertiary: tertiaryColor,
    error: AccentSwatch.red.color,
  ),
  datePickerTheme: const DatePickerThemeData(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.white,
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(vertical: 9, horizontal: 24),
    enabledBorder: OutlineInputBorder(
      borderRadius: _inputBorderRadius,
      borderSide: BorderSide(
        color: neuralColor.shade100,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: _inputBorderRadius,
      borderSide: BorderSide(
        color: neuralColor.shade300,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: _inputBorderRadius,
      borderSide: BorderSide(
        color: AccentSwatch.red.color,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: _inputBorderRadius,
      borderSide: BorderSide(
        color: AccentSwatch.red.color,
      ),
    ),
    hintStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: neuralColor.shade100,
    ),
    errorStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AccentSwatch.red.color,
    ),
  ),
  appBarTheme: AppBarTheme(
    titleTextStyle: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: neuralColor,
    ),
    iconTheme: IconThemeData(color: neuralColor[0]),
    surfaceTintColor: Colors.white,
  ),
  cardTheme: const CardTheme(
    surfaceTintColor: Colors.white,
    elevation: 2,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    color: Colors.white,
  ),
  textTheme: const TextTheme(
      displaySmall: TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      bodySmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      bodyLarge: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      titleLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
      headlineSmall: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      )),
  useMaterial3: true,
);

final darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(seedColor: primaryColor).copyWith(
    primary: primaryColor,
    secondary: secondaryColor,
    tertiary: tertiaryColor,
    error: AccentSwatch.red.color,
  ),
  datePickerTheme: const DatePickerThemeData(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Colors.white,
    surfaceTintColor: Colors.white,
  ),
  scaffoldBackgroundColor: Colors.white,
  inputDecorationTheme: InputDecorationTheme(
    contentPadding: const EdgeInsets.symmetric(vertical: 9, horizontal: 24),
    enabledBorder: OutlineInputBorder(
      borderRadius: _inputBorderRadius,
      borderSide: const BorderSide(
        color: Color(0xff27282D),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: _inputBorderRadius,
      borderSide: const BorderSide(
        color: Color(0xff27282D),
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: _inputBorderRadius,
      borderSide: BorderSide(
        color: AccentSwatch.red.color,
      ),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: _inputBorderRadius,
      borderSide: BorderSide(
        color: AccentSwatch.red.color,
      ),
    ),
    hintStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: neuralColor[0]?.withAlpha(70),
    ),
    errorStyle: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      color: AccentSwatch.red.color,
    ),
  ),
  appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: neuralColor[0],
      ),
      iconTheme: IconThemeData(color: neuralColor[0]),
      surfaceTintColor: Colors.white,
      backgroundColor: purple),
  cardTheme: const CardTheme(
    surfaceTintColor: Colors.white,
    elevation: 2,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    color: Colors.white,
  ),
  textTheme: const TextTheme(
      displaySmall: TextStyle(
          fontSize: 12, fontWeight: FontWeight.w400, color: Colors.white),
      bodySmall: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
      bodyMedium: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
      bodyLarge: TextStyle(
          fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white),
      titleLarge: TextStyle(
          fontSize: 24, fontWeight: FontWeight.w700, color: Colors.white),
      headlineSmall: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
      headlineMedium: TextStyle(
          fontSize: 24, fontWeight: FontWeight.w400, color: Colors.white)),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: primaryColor,
      unselectedItemColor: neuralColor[0],
      selectedLabelStyle: TextStyle(
          fontSize: 13, fontWeight: FontWeight.w500, color: primaryColor),
      unselectedLabelStyle: TextStyle(
          fontSize: 13, fontWeight: FontWeight.w500, color: neuralColor[0])),
  useMaterial3: true,
);
