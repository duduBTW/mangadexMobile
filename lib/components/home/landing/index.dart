import 'package:flutter/material.dart';
import 'package:mangadex/components/home/landing/recentlyAdded/chapters.dart';
import 'package:mangadex/components/home/landing/recentlyAdded/index.dart';
import 'package:mangadex/components/home/search/index.dart';
import 'package:mangadex/pages/search/index.dart';
import 'package:mangadex/service/manga/index.dart';
import 'package:mangadex/service/manga/search.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:provider/provider.dart';

class Landing extends StatefulWidget {
  const Landing();

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  void initState() {
    super.initState();

    loadStuff();
  }

  void loadStuff() {
    Provider.of<MangaController>(context, listen: false).getRecentMangas();
    Provider.of<MangaController>(context, listen: false).fetchRecentChapters();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        RefreshIndicator(
            color: Theme.of(context).primaryColor,
            onRefresh: () => Future.sync(
                  () => loadStuff(),
                ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 110,
                    ),
                    RecentlyAdded(),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Text(
                        "Last Updated",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    RecentChapters(),
                  ],
                ),
              ),
            )),
        buildFloatingSearchBar()
      ],
    );
  }

  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: 'Search...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 400),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (searchValue) {
        Provider.of<SearchController>(context, listen: false).title =
            searchValue;
      },
      transition: CircularFloatingSearchBarTransition(),
      builder: (context, transition) {
        return Container(
          height: MediaQuery.of(context).size.height - 165,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Material(
              child: MangaSearch(),
              // child: SearchPage(),
              color: Theme.of(context).backgroundColor,
            ),
          ),
        );
      },
    );
  }
}
