import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangadex/pages/manga/index.dart';
import 'package:mangadex/pages/scan/index.dart';

ThemeData getTheme(TextTheme textTheme) {
  return ThemeData(
    primaryColor: Color(0xffFF7D7D),
    accentColor: Color(0xffFFF5F5),
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
        textStyle: textTheme.headline1,
        color: Color(0xff3F0000),
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      headline4: GoogleFonts.rubik(
        textStyle: textTheme.headline1,
        color: Color(0xff3F0000),
        fontSize: 18,
        fontWeight: FontWeight.normal,
      ),
    ),
  );
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: getTheme(textTheme),
      home: ScanPage(),
      routes: {},
    );
  }
}
