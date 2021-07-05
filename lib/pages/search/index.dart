import 'package:flutter/material.dart';
import 'package:mangadex/components/scan/members/item.dart';
import 'package:mangadex/components/shared/manga/index.dart';
import 'package:mangadex/components/shared/manga/item.dart';
import 'package:mangadex/pages/author/index.dart';
import 'package:mangadex/service/manga/search.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabChange);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  void _handleTabChange() {
    Provider.of<SearchController>(context, listen: false).currentPage =
        PagesSearch.values[_tabController.index];
    // if (_tabController.index == 1) {
    //   var searchProvider =
    //       Provider.of<SearchController>(context, listen: false);
    //   searchProvider.getAuthors();
    // }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        // body: MangaSearch(),
        appBar: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              text: "Manga",
            ),
            Tab(
              text: "Author",
            ),
            // Tab(
            //   text: "Users",
            // ),
            // Tab(
            //   text: "Scans",
            // ),
          ],
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            MangaSearch(),
            AuthorSearch(),
            // ScanSearch(),
            // ScanSearch(),
          ],
        ),
      ),
    );
  }
}

class AuthorSearch extends StatelessWidget {
  const AuthorSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var authors = Provider.of<SearchController>(context).authors;
    var loadingAuthor = Provider.of<SearchController>(context).loadingAuthor;

    if (loadingAuthor) return Center(child: CircularProgressIndicator());

    if (authors == null || authors.length <= 0)
      return Expanded(
        child: Column(
          children: [
            Spacer(),
            Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  top: -2,
                  right: -2,
                  child: Icon(Icons.person,
                      size: 52,
                      color: Theme.of(context).primaryColor.withOpacity(0.5)),
                ),
                Icon(Icons.person, size: 52, color: Colors.grey),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "Empty",
              style: TextStyle(color: Colors.grey, fontSize: 22),
            ),
            Spacer(),
          ],
        ),
      );

    return ListView.builder(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        itemCount: authors.length,
        itemBuilder: (ctx, index) => ListTile(
              onTap: () => Navigator.of(context)
                  .pushNamed(AuthorPage.routeName, arguments: authors[index]),
              leading: authors[index].data.attributes.imageUrl != null
                  ? Image.network(
                      "${authors[index].data.attributes.imageUrl}",
                      width: 32,
                    )
                  : Image.asset(
                      "assets/noPfp.png",
                      width: 32,
                    ),
              title: Text("${authors[index].data.attributes.name}"),
            ));
  }
}

class ScanSearch extends StatelessWidget {
  const ScanSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).accentColor,
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (ctx, index) => Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: MemberScan("Author $index",
              "https://pbs.twimg.com/media/E4u6jUyVoAoM_fw?format=jpg&name=4096x4096"),
        ),
      ),
    );
  }
}

class MangaSearch extends StatelessWidget {
  const MangaSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mangas = Provider.of<SearchController>(context).mangas;
    var loading = Provider.of<SearchController>(context).loading;
    var total = Provider.of<SearchController>(context).excludedTags.length +
        Provider.of<SearchController>(context).includedTags.length;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(15),
          height: 60,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              OutlinedButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed("/search/filters/manga");
                },
                icon: Icon(Icons.filter_list),
                label: Text(
                  "Filters ($total)",
                  style: TextStyle(color: Colors.black),
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: Theme.of(context).primaryColor))),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              OutlinedButton.icon(
                onPressed: () {
                  print("a");
                },
                icon: Icon(Icons.expand_more),
                label: Text(
                  "Order by",
                  style: TextStyle(color: Colors.black),
                ),
                style: ButtonStyle(
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                      side: BorderSide(color: Theme.of(context).primaryColor))),
                ),
              ),
            ],
          ),
        ),
        loading
            ? Expanded(
                child: Center(
                  child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              )
            : mangas != null && mangas.length > 0
                ? Expanded(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(
                          parent: AlwaysScrollableScrollPhysics()),
                      itemBuilder: (ctx, index) => MangaShow(mangas[index]),
                      itemCount: mangas.length,
                    ),
                  )
                : Expanded(
                    child: Column(
                      children: [
                        Spacer(),
                        Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Positioned(
                              top: -2,
                              right: -2,
                              child: Icon(Icons.chrome_reader_mode_rounded,
                                  size: 52,
                                  color: Theme.of(context)
                                      .primaryColor
                                      .withOpacity(0.5)),
                            ),
                            Icon(Icons.chrome_reader_mode_rounded,
                                size: 52, color: Colors.grey),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Empty",
                          style: TextStyle(color: Colors.grey, fontSize: 22),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
        // child: Column(
        //   children: [
        //     MangaMainItem(),
        //     SizedBox(
        //       height: 30,
        //     ),
        //     MangaMainItem(),
        //     SizedBox(
        //       height: 30,
        //     ),
        //     MangaMainItem(),
        //     SizedBox(
        //       height: 30,
        //     ),
        //     MangaMainItem(),
        //     SizedBox(
        //       height: 30,
        //     ),
        //     MangaMainItem(),
        //     SizedBox(
        //       height: 30,
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
