import 'package:flutter/material.dart';
import 'package:mangadex/pages/home/index.dart';
import 'package:mangadex/pages/manga/index.dart';
import 'package:mangadex/pages/mangaList/index.dart';
import 'package:mangadex/pages/reader/index.dart';
import 'package:mangadex/pages/search/filters/manga.dart';
import 'package:mangadex/pages/search/index.dart';
import 'package:mangadex/service/chapters/model/chapter/index.dart';
import 'package:mangadex/service/http.dart';
import 'package:mangadex/service/login/index.dart';
import 'package:mangadex/service/manga/item.dart';
import 'package:mangadex/service/manga/model/index.dart';
import 'package:mangadex/service/manga/search.dart';
import 'package:mangadex/service/manga/user.dart';
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
          '/search/filters/manga': (ctx) => MangaFilters(),
          // '/reader': (ctx) => MangaReader(),
        },
        onGenerateRoute: (settings) {
          // If you push the PassArguments route
          if (settings.name == MangaPage.routeName) {
            // Cast the arguments to the correct
            // type: ScreenArguments.
            final manga = settings.arguments as MangaModel;

            // Then, extract the required data from
            // the arguments and pass the data to the
            // correct screen.
            return MaterialPageRoute(
              builder: (context) {
                return MangaPage(
                  manga: manga,
                  http: http,
                );
              },
            );
          }

          if (settings.name == MangaReaderPage.routeName) {
            // Cast the arguments to the correct
            // type: ScreenArguments.
            final chapter = settings.arguments as ChapterModel;

            // Then, extract the required data from
            // the arguments and pass the data to the
            // correct screen.
            return MaterialPageRoute(
              builder: (context) {
                return MangaReaderPage(
                  chapter: chapter,
                );
              },
            );
          }
          assert(false, 'Need to implement ${settings.name}');
          return null;
        },
      ),
    );
  }
}
