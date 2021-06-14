import 'package:flutter/material.dart';
import 'package:mangadex/pages/home/index.dart';
import 'package:mangadex/pages/manga/index.dart';
import 'package:mangadex/pages/mangaList/index.dart';
import 'package:mangadex/pages/reader/index.dart';
import 'package:mangadex/pages/search/filters/manga.dart';
import 'package:mangadex/pages/search/index.dart';
import 'package:mangadex/service/http.dart';
import 'package:mangadex/service/login/index.dart';
import 'package:mangadex/service/manga/model/index.dart';
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
                return MangaPage(manga: manga);
              },
            );
          }
          // The code only supports
          // PassArgumentsScreen.routeName right now.
          // Other values need to be implemented if we
          // add them. The assertion here will help remind
          // us of that higher up in the call stack, since
          // this assertion would otherwise fire somewhere
          // in the framework.
          assert(false, 'Need to implement ${settings.name}');
          return null;
        },
      ),
    );
  }
}
