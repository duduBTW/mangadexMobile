import 'package:flutter/material.dart';
import 'package:mangadex/components/shared/manga/index.dart';
import 'package:mangadex/components/shared/manga/item.dart';
import 'package:mangadex/service/manga/search.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: TabBar(
          tabs: [
            Tab(
              text: "Manga",
            ),
            Tab(
              text: "Author",
            ),
            Tab(
              text: "Scan",
            ),
          ],
        ),
        body: TabBarView(
          children: [
            MangaSearch(),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
          ],
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
    return Container(
      child: Column(
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
                        side:
                            BorderSide(color: Theme.of(context).primaryColor))),
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
                        side:
                            BorderSide(color: Theme.of(context).primaryColor))),
                  ),
                ),
              ],
            ),
          ),
          mangas != null
              ? Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics()),
                    itemBuilder: (ctx, index) => MangaShow(mangas[index]),
                    itemCount: mangas.length,
                  ),
                )
              : Container(),
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
      ),
    );
  }
}
