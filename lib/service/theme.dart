import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData getTheme(TextTheme textTheme) {
  return ThemeData(
    primaryColor: Color(0xffFF7D7D),
    accentColor: Color(0xffFFF5F5),
    backgroundColor: Color(0xffFFFEFE),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
          primary: Color(0xffFF7D7D),
          side: BorderSide(color: Color(0xffE866A7)),
          textStyle: TextStyle(color: Colors.black)),
    ),
    colorScheme: ColorScheme.light(
        secondary: Color(0xffFFF0F1), primary: Color(0xffF3F4FE)),
    scaffoldBackgroundColor: Color(0xffFFFEFE),
    primarySwatch: Colors.pink,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: GoogleFonts.robotoTextTheme(textTheme).copyWith(
      headline1: GoogleFonts.rubik(
        textStyle: textTheme.headline1,
        color: Color(0xff3F0000),
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      headline3: GoogleFonts.rubik(
        textStyle: textTheme.headline3,
        color: Color(0xff3F0000),
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      headline4: GoogleFonts.rubik(
        textStyle: textTheme.headline4,
        color: Color(0xff3F0000),
        fontSize: 18,
        fontWeight: FontWeight.normal,
      ),
      bodyText1: GoogleFonts.rubik(
          textStyle: textTheme.bodyText1,
          color: Colors.black,
          fontSize: 14,
          fontWeight: FontWeight.normal,
          height: 1.5),
    ),
  );
}
