import 'package:flutter/material.dart';

class AppColors {
  static Color backgroundColor = const Color.fromARGB(255, 249, 245, 245);
  static Color cardColor = Colors.white;

  static Color appBackgroundColor = const Color.fromRGBO(232, 236, 240, 1.0);
  static Color loginCustomShapeColor =
      const Color.fromRGBO(165, 174, 188, 0.17);
  static Color mainColor = const Color.fromRGBO(34, 40, 50, 1.0);
  static Color appBlue = const Color.fromRGBO(12, 84, 206, 1.0);
  static Color appGreen = const Color.fromRGBO(25, 176, 0, 1.0);

  static Color dimBlack = const Color.fromRGBO(92, 92, 92, 1.0);
  static Color safeColor = const Color.fromRGBO(12, 206, 136, 1.0);
  static Color dangerColor = const Color.fromARGB(255, 206, 44, 12);

  static Color headlineTextColor = const Color.fromRGBO(47, 54, 66, 1.0);
  static Color bodyTextColor = const Color.fromRGBO(47, 54, 66, 1.0);
  static Color labelTextColor = const Color.fromRGBO(92, 92, 92, 1.0);

  static Color dividerColor = const Color.fromRGBO(0, 0, 0, 0.2);
  static Color iconColor1 = const Color.fromRGBO(0, 0, 0, 0.6);

  static LinearGradient appBarColor = LinearGradient(
      colors: [mainColor, mainColor],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);

  static LinearGradient alarmedAppBarColor =  LinearGradient(
      colors: [dangerColor, const Color.fromARGB(255, 198, 79, 55)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter);

  static LinearGradient blueRedGradient = const LinearGradient(
      colors: [Colors.blue, Colors.red],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight);
}
