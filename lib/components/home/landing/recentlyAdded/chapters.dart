import 'package:flutter/material.dart';
import 'package:mangadex/components/home/follows/chaps.dart';
import 'package:mangadex/service/manga/index.dart';
import 'package:provider/provider.dart';

class RecentChapters extends StatelessWidget {
  const RecentChapters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var chapters = Provider.of<MangaController>(context).recentChapters;
    var mangas = Provider.of<MangaController>(context).recentChaptersMangas;

    return chapters == null
        ? Center(
            child: SizedBox(
            height: 22,
            width: 22,
            child: CircularProgressIndicator(),
          ))
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: ChapterList(
              chapters: chapters,
              shrinkWrap: true,
              mangas: mangas,
            ),
          );
  }
}
