import 'package:flutter/material.dart';
import 'package:shop/theme/input_decoration_theme.dart';

import '../constants.dart';
import 'button_theme.dart';
import 'checkbox_themedata.dart';
import 'theme_data.dart';

ThemeData darkTheme(BuildContext context) {
  return ThemeData(
    brightness: Brightness.dark,
    fontFamily: "Plus Jakarta",
    primarySwatch: primaryMaterialColor,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: blackColor,
    iconTheme: const IconThemeData(color: Colors.white),
    textTheme: const TextTheme(
      bodyText2: TextStyle(color: blackColor60),
    ),
    elevatedButtonTheme: elevatedButtonThemeData,
    outlinedButtonTheme: outlinedButtonTheme(borderColor: whileColor20),
    textButtonTheme: textButtonThemeData,
    inputDecorationTheme: darkInputDecorationTheme,
    checkboxTheme: checkboxThemeData,
    appBarTheme: appBarDarkTheme,
    scrollbarTheme: scrollbarThemeData,
    dataTableTheme: dataTableDarkThemeData,
  );
}
