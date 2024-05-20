import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/colors.dart';
final ThemeData theme = ThemeData();
class MyTheme {
  static ThemeData lightTheme(BuildContext context) => ThemeData(
      colorScheme: theme.colorScheme.copyWith(secondary: MyTheme.darkBlusihColor,primary: Colors.black),
      fontFamily: GoogleFonts.poppins().fontFamily,
      cardColor: Colors.white,
      canvasColor: creamColor,
      buttonTheme: ButtonThemeData(
          buttonColor: lightBlusihColor
      ),
      appBarTheme: const AppBarTheme(
          color: Colors.white,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle:
              TextStyle(color: Colors.black, fontWeight: FontWeight.bold)));

  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      cardColor: Colors.black,
        colorScheme: theme.colorScheme.copyWith(primary: creamColor,secondary: Colors.white, brightness: Brightness.dark),
        canvasColor: darkcreamColor,
        fontFamily: GoogleFonts.lato().fontFamily,
        buttonTheme: ButtonThemeData(
          buttonColor: darkBlusihColor
        ),
        appBarTheme: const AppBarTheme(
            color: Colors.black,
            elevation: 0.0,
            iconTheme: IconThemeData(color: Colors.black),
            titleTextStyle:
                TextStyle(color: Colors.white, fontWeight: FontWeight.bold)));
  }

  static bool getThemeName(BuildContext context) {
    ThemeData theme = Theme.of(context);
    bool isDarkTheme = theme.brightness == Brightness.dark;
    return isDarkTheme;
  }
  static Color creamColor= yellowColor;
  static Color darkcreamColor= yellowColor;
  static Color  darkBlusihColor= yellowColor;
  static Color  lightBlusihColor= yellowColor;
}
