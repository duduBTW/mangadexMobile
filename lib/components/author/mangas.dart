import 'package:flutter/material.dart';
import 'package:mangadex/components/shared/manga/item.dart';

class MangasAuthor extends StatelessWidget {
  const MangasAuthor({Key? key}) : super(key: key);

  void redirectMangaAll(BuildContext ctx) {
    Navigator.of(ctx).pushNamed("/manga/list");
  }

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: "manga-list",
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
            color: Theme.of(context).backgroundColor,
            borderRadius: BorderRadius.circular(30)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Mangas",
              style: Theme.of(context).textTheme.headline3,
            ),
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
            Container(
              width: double.infinity,
              child: TextButton(
                child: Text(
                  "See all",
                  style: Theme.of(context).textTheme.headline4,
                ),
                onPressed: () => redirectMangaAll(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
