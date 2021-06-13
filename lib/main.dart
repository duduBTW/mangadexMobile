import 'package:flutter/material.dart';
import 'package:mangadex/pages/home/index.dart';
import 'package:mangadex/pages/mangaList/index.dart';
import 'package:mangadex/pages/reader/index.dart';
import 'package:mangadex/pages/search/filters/manga.dart';
import 'package:mangadex/pages/search/index.dart';
import 'package:mangadex/service/http.dart';
import 'package:mangadex/service/login/index.dart';
import 'package:mangadex/service/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static MangadexService http = new MangadexService();

  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginController>(
            create: (_) => LoginController(http)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: getTheme(textTheme),
        home: HomePage(http),
        routes: {
          '/manga/list': (ctx) => MangaList(),
          '/search': (ctx) => SearchPage(),
          '/search/filters/manga': (ctx) => MangaFilters(),
          '/reader': (ctx) => MangaReader(),
        },
      ),
    );
  }
}
