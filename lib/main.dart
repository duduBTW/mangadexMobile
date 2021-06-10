import 'package:flutter/material.dart';
import 'package:mangadex/pages/author/index.dart';
import 'package:mangadex/pages/home/index.dart';
import 'package:mangadex/pages/login/index.dart';
import 'package:mangadex/pages/manga/index.dart';
import 'package:mangadex/pages/mangaList/index.dart';
import 'package:mangadex/pages/reader/index.dart';
import 'package:mangadex/pages/scan/index.dart';
import 'package:mangadex/pages/search/filters/manga.dart';
import 'package:mangadex/pages/search/index.dart';
import 'package:mangadex/providers/login.dart';
import 'package:mangadex/utils/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ChangeNotifierProvider(
      create: (_) => new UserLogin(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: getTheme(textTheme),
        home: HomePage(),
        routes: {
          '/manga/list': (ctx) => MangaList(),
          '/search': (ctx) => SearchPage(),
          '/search/filters/manga': (ctx) => MangaFilters(),
        },
      ),
    );
  }
}
