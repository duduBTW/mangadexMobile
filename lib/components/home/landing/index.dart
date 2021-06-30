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
  final GlobalKey<ScaffoldState> _scaffoldKey;

  const Landing(this._scaffoldKey);

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  @override
  void initState() {
    super.initState();

    Provider.of<MangaController>(context, listen: false).getRecentMangas();
    Provider.of<MangaController>(context, listen: false).fetchRecentChapters();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        SingleChildScrollView(
            physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics()),
            child:
                // SliverAppBar(
                //   actions: [Container()],
                //   automaticallyImplyLeading: false,
                //   // Provide a standard title.
                //   title: Row(
                //     children: [
                //       GestureDetector(
                //         onTap: () => widget._scaffoldKey.currentState?.openDrawer(),
                //         child: CircleAvatar(
                //           backgroundImage: NetworkImage(
                //               "https://pbs.twimg.com/profile_images/1381972907375480833/JoCT-Skd_400x400.jpg"),
                //           backgroundColor: Colors.transparent,
                //           radius: 15.0,
                //         ),
                //       ),
                //     ],
                //   ),
                //   floating: true,
                //   elevation: 0,
                //   backgroundColor: Theme.of(context).backgroundColor,
                // ),
                Container(
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
              color: Theme.of(context).backgroundColor,
            ),
          ),
        );
      },
    );
  }
}
