import 'package:flutter/material.dart';
import 'package:mangadex/pages/home.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangadex/pages/manga.dart';

ThemeData getTheme(TextTheme textTheme) {
  return ThemeData(
    primaryColor: Color(0xff00614F),
    accentColor: Color(0xff00DCB4),
    // backgroundColor: Color(0xff00171C),
    colorScheme: ColorScheme.light(
        secondary: Color(0xffFFF0F1), primary: Color(0xffF3F4FE)),
    scaffoldBackgroundColor: Color(0xff00171C),
    primarySwatch: Colors.blue,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    textTheme: GoogleFonts.robotoTextTheme(textTheme).copyWith(
      headline1: GoogleFonts.rubik(
        textStyle: textTheme.headline1,
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      headline2: GoogleFonts.rubik(
        textStyle: textTheme.headline2,
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w500,
      ),
      headline3: GoogleFonts.rubik(
        textStyle: textTheme.headline3,
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      headline4: GoogleFonts.rubik(
        textStyle: textTheme.headline4,
        color: Colors.white,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      bodyText1: GoogleFonts.roboto(
        // textStyle: textTheme.bodyText1,
        color: Colors.white,
        fontSize: 12,
      ),
      bodyText2: GoogleFonts.rubik(
        textStyle: textTheme.bodyText2,
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      subtitle2: GoogleFonts.roboto(
        color: Colors.white,
        fontSize: 8,
        fontWeight: FontWeight.w400,
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
      home: HomeScreen(),
      routes: {
        '/title': (ctx) => MangaPage(),
      },
    );
  }
}
