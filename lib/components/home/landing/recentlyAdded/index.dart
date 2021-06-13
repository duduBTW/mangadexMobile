import 'package:flutter/material.dart';
import 'package:mangadex/service/manga/index.dart';
import 'package:mangadex/service/manga/model/index.dart';
import 'package:provider/provider.dart';

class RecentlyAdded extends StatelessWidget {
  const RecentlyAdded({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mangas = Provider.of<MangaController>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 15),
          child: Text(
            "Recently Added",
            style: Theme.of(context).textTheme.headline3,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        mangas.recentMangas != null
            ? Padding(
                padding: const EdgeInsets.only(left: 15),
                child: RecentlyAddedList(mangas.recentMangas!),
              )
            : LinearProgressIndicator(),
      ],
    );
  }
}

var gradiant = new LinearGradient(
    colors: [
      Colors.black.withOpacity(0.6),
      Colors.transparent,
      Colors.transparent,
    ],
    begin: Alignment.bottomCenter,
    end: Alignment.topCenter,
    stops: [0.0, 0.3, 1.0],
    tileMode: TileMode.clamp);

class RecentlyAddedList extends StatelessWidget {
  final List<MangaModel> mangas;

  const RecentlyAddedList(this.mangas);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 215,
      child: ListView.separated(
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
          scrollDirection: Axis.horizontal,
          itemBuilder: (ctx, index) {
            return CardManga(mangas[index]);
          },
          separatorBuilder: (_, __) => SizedBox(
                width: 30,
              ),
          itemCount: mangas.length),
    );
  }
}

class CardManga extends StatelessWidget {
  final MangaModel manga;

  const CardManga(this.manga);

  @override
  Widget build(BuildContext context) {
    print(manga.data.coverLink);
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 120,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              height: 170,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(manga.data.coverLink)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: Text(
                manga.data.attributes.title['en']!,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
