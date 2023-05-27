import 'package:flutter/material.dart';
import 'package:secarity/constants/app_colors.dart';
import 'package:secarity/constants/app_textstyles.dart';

ThemeData lightTheme(Size size) => ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.mainColor,
      // cardTheme: CardTheme(
      //   shape: RoundedRectangleBorder(
      //       borderRadius: BorderRadius.circular(size.shortestSide * 0.04)),
      // ),
      // elevatedButtonTheme: ElevatedButtonThemeData(
      //     style: ElevatedButton.styleFrom(
      //         backgroundColor: Colors.indigo,
      //         shape: RoundedRectangleBorder(
      //             borderRadius:
      //                 BorderRadius.circular(size.shortestSide * 0.03)),
      //         textStyle: TextStyle(
      //             fontSize: size.shortestSide * 0.06,
      //             fontWeight: FontWeight.bold))),
      // inputDecorationTheme: InputDecorationTheme(
      //   focusedBorder: _outlineInputBorder(size, Colors.indigo),
      //   border: _outlineInputBorder(size, Colors.black45),
      //   contentPadding: EdgeInsets.symmetric(
      //       horizontal: size.shortestSide * 0.03,
      //       vertical: size.shortestSide * 0.04),
      // ),
      textTheme: TextTheme(
        bodyLarge: BODY_LARGE_LIGHT,
        bodyMedium: BODY_MEDIUM_LIGHT,
        bodySmall: BODY_SMALL_LIGHT,
        displayLarge: DISPLAY_LARGE_LIGHT,
        displayMedium: DISPLAY_MEDIUM_LIGHT, //
        displaySmall: DISPLAY_SMALL_LIGHT,
        headlineLarge: HEADLINE_LARGE_LIGHT,
        headlineMedium: HEADLINE_MEDIUM_LIGHT, //
        headlineSmall: HEADLINE_SMALL_LIGHT,
        labelLarge: LABEL_LARGE_LIGHT,
        labelMedium: LABEL_MEDIUM_LIGHT, //
        labelSmall: LABEL_SMALL_LIGHT,
        titleLarge: TITLE_LARGE_LIGHT,
        titleMedium: TITLE_MEDIUM_LIGHT, //
        titleSmall: TITLE_SMALL_LIGHT,
      ),
    );

OutlineInputBorder _outlineInputBorder(Size size, Color color) =>
    OutlineInputBorder(
        borderSide: BorderSide(width: size.shortestSide * 0.005, color: color));

// ThemeData darkTheme = ThemeData(
//   brightness: Brightness.dark,
//   primaryColor: darkPrimary,
//   textTheme: TextTheme(
//     bodyLarge: BODY_LARGE_DARK,
//     bodyMedium: BODY_MEDIUM_DARK,
//     bodySmall: BODY_SMALL_DARK,
//     displayLarge: DISPLAY_LARGE_DARK,
//     displayMedium: DISPLAY_MEDIUM_DARK,
//     displaySmall: DISPLAY_SMALL_DARK,
//     headlineLarge: HEADLINE_LARGE_DARK,
//     headlineMedium: HEADLINE_MEDIUM_DARK,
//     headlineSmall: HEADLINE_SMALL_DARK,
//     labelLarge: LABEL_LARGE_DARK,
//     labelMedium: LABEL_MEDIUM_DARK,
//     labelSmall: LABEL_SMALL_DARK,
//     titleLarge: TITLE_LARGE_DARK,
//     titleMedium: TITLE_MEDIUM_DARK,
//     titleSmall: TITLE_SMALL_DARK,
//   ),
// );