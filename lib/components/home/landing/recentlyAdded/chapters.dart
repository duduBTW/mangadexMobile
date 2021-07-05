import 'package:flutter/material.dart';
import 'package:mangadex/components/home/follows/chaps.dart';
import 'package:mangadex/service/manga/index.dart';
import 'package:provider/provider.dart';

class RecentChapters extends StatelessWidget {
  const RecentChapters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var scans = Provider.of<MangaController>(context).recentChaptersScans;
    var chapters = Provider.of<MangaController>(context).chapterPageController;
    var mangas = Provider.of<MangaController>(context).recentChaptersMangas;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: FollowChaptersPaginated(
        scans: scans,
        height: MediaQuery.of(context).size.height * 0.5,
        pagingController: chapters,
        // chapters: chapters,
        mangas: mangas,
      ),
    );
  }
}
