import 'package:flutter/material.dart';
import 'package:mangadex/components/shared/manga/item.dart';

class MangaList extends StatelessWidget {
  const MangaList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "manga-list",
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "Mangas",
            style: Theme.of(context).textTheme.headline3,
          ),
          backgroundColor: Colors.white,
          actions: [
            IconButton(
              icon: Icon(
                Icons.favorite_border_rounded,
                color: Theme.of(context).accentColor,
              ),
              onPressed: () {},
            )
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MangaMainItem(),
                SizedBox(
                  height: 30,
                ),
                MangaMainItem(),
                SizedBox(
                  height: 30,
                ),
                MangaMainItem(),
                SizedBox(
                  height: 30,
                ),
                MangaMainItem(),
                SizedBox(
                  height: 30,
                ),
                MangaMainItem(),
                SizedBox(
                  height: 30,
                ),
                MangaMainItem(),
                SizedBox(
                  height: 30,
                ),
                MangaMainItem(),
                SizedBox(
                  height: 30,
                ),
                MangaMainItem(),
                SizedBox(
                  height: 30,
                ),
                MangaMainItem(),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
