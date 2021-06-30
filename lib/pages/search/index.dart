import 'package:flutter/material.dart';
import 'package:mangadex/components/scan/members/item.dart';
import 'package:mangadex/components/shared/manga/index.dart';
import 'package:mangadex/components/shared/manga/item.dart';
import 'package:mangadex/service/manga/search.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        // body: MangaSearch(),
        appBar: TabBar(
          tabs: [
            Tab(
              text: "Manga",
            ),
            Tab(
              text: "Author",
            ),
            Tab(
              text: "Users",
            ),
            Tab(
              text: "Scans",
            ),
          ],
        ),
        body: TabBarView(
          children: [
            MangaSearch(),
            AuthorSearch(),
            ScanSearch(),
            ScanSearch(),
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
    return ListView.builder(
        itemCount: 10,
        itemBuilder: (ctx, index) => Container(
              width: double.infinity,
              padding: EdgeInsets.all(30),
              child: Text("Author $index"),
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
                  "Filters",
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
