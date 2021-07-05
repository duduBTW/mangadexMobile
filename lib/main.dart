import 'package:flutter/material.dart';
import 'package:mangadex/pages/author/index.dart';
import 'package:mangadex/pages/configuration/count/index.dart';
import 'package:mangadex/pages/configuration/index.dart';
import 'package:mangadex/pages/home/index.dart';
import 'package:mangadex/pages/manga/index.dart';
import 'package:mangadex/pages/mangaList/index.dart';
import 'package:mangadex/pages/reader/index.dart';
import 'package:mangadex/pages/scan/index.dart';
import 'package:mangadex/pages/search/filters/manga.dart';
import 'package:mangadex/service/author/model/index.dart';
import 'package:mangadex/service/chapters/model/chapter/index.dart';
import 'package:mangadex/service/http.dart';
import 'package:mangadex/service/login/index.dart';
import 'package:mangadex/service/manga/item.dart';
import 'package:mangadex/service/manga/model/index.dart';
import 'package:mangadex/service/manga/search.dart';
import 'package:mangadex/service/manga/user.dart';
import 'package:mangadex/service/scan/model/index.dart';
import 'package:mangadex/service/theme.dart';
import 'package:page_transition/page_transition.dart';
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
        ChangeNotifierProvider<UserMangaController>(
            create: (_) => UserMangaController(http)),
        ChangeNotifierProvider<MangaItemController>(
            create: (_) => MangaItemController(http)),
        ChangeNotifierProvider<SearchController>(
            create: (_) => SearchController(http)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: getTheme(textTheme),
        home: HomePage(http),
        routes: {
          '/manga/list': (ctx) => MangaList(),
          '/configuration': (ctx) => ConfigurationPage(),
          '/configuration/count': (ctx) => ConfigurationCount(),
        },
        onGenerateRoute: (settings) {
          if (settings.name == MangaPage.routeName) {
            final manga = settings.arguments as MangaModel;

            return MaterialPageRoute(
              builder: (context) {
                return MangaPage(
                  manga: manga,
                );
              },
            );
          }

          if (settings.name == MangaReaderPage.routeName) {
            final chapter = settings.arguments as ChapterModel;

            return MaterialPageRoute(
              builder: (context) {
                return MangaReaderPage(
                  chapter: chapter,
                );
              },
            );
          }

          if (settings.name == AuthorPage.routeName) {
            final author = settings.arguments as AuthorModel;

            return PageTransition(
              child: AuthorPage(author: author),
              type: PageTransitionType.bottomToTop,
              settings: settings,
            );
          }

          if (settings.name == '/search/filters/manga') {
            return PageTransition(
              child: MangaFilters(),
              type: PageTransitionType.leftToRight,
              settings: settings,
            );
          }

          if (settings.name == ScanPage.routeName) {
            final scan = settings.arguments as ScanlationGroupDataModel;

            return PageTransition(
              child: ScanPage(
                scan: scan,
              ),
              type: PageTransitionType.bottomToTop,
              settings: settings,
            );
          }
          assert(false, 'Need to implement ${settings.name}');
          return null;
        },
      ),
    );
  }
}
