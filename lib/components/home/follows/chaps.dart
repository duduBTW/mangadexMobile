import 'dart:math';

import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:mangadex/components/shared/chapters/index.dart';
import 'package:mangadex/pages/manga/index.dart';
import 'package:mangadex/service/chapters/model/chapter/index.dart';
import 'package:mangadex/service/manga/model/index.dart';
import 'package:mangadex/service/manga/user.dart';
import 'package:mangadex/service/scan/model/index.dart';
import 'package:provider/provider.dart';

class FollowsChapters extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var pagingController =
        Provider.of<UserMangaController>(context).chapterPageController;
    var userChaptersMangas =
        Provider.of<UserMangaController>(context).userChaptersMangas;
    var userScans = Provider.of<UserMangaController>(context).userChaptersScans;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: FollowChaptersPaginated(
        pagingController: pagingController,
        mangas: userChaptersMangas,
        scans: userScans,
      ),
    );
  }
}

class FollowChaptersPaginated extends StatelessWidget {
  final PagingController<int, ChapterModel> pagingController;
  final Map<String, MangaModel>? mangas;
  final Map<String, ScanlationGroupDataModel>? scans;
  const FollowChaptersPaginated(
      {Key? key, required this.pagingController, this.mangas, this.scans})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Theme.of(context).primaryColor,
      onRefresh: () => Future.sync(
        () {
          pagingController.refresh();
        },
      ),
      // padding: const EdgeInsets.symmetric(vertical: 30),
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: PagedListView(
          pagingController: pagingController,
          builderDelegate: PagedChildBuilderDelegate<ChapterModel>(
              itemBuilder: (context, itemChapter, i) {
                var scanId = itemChapter.relationships.firstWhere(
                    (element) => element!['type'] == "scanlation_group")!['id'];
                var mangaId = itemChapter.relationships.singleWhere(
                    (element) => element!['type'] == "manga")!['id'];

                var lastManga = pagingController
                    .itemList![max(i - 1, 0)].relationships
                    .singleWhere(
                        (element) => element!['type'] == "manga")!['id'];

                return MangaChapItem(
                  scan: scans?["$scanId"],
                  manga: mangas?["$mangaId"],
                  charItem: itemChapter,
                  showChapLabel: i == 0 ||
                      lastManga != mangaId ||
                      pagingController.itemList![i].data.attributes.chapter !=
                          pagingController
                              .itemList![i - 1].data.attributes.chapter,
                  showHeader: !(i != 0 &&
                      mangaId ==
                          pagingController.itemList![i - 1].relationships
                              .singleWhere((element) =>
                                  element!['type'] == "manga")!['id']),
                );
              },
              firstPageErrorIndicatorBuilder: (context) => Container(
                    height: 100,
                    width: 100,
                    child: Text(":( error"),
                  ),
              noItemsFoundIndicatorBuilder: (context) => Container(
                    height: 100,
                    width: 100,
                    child: Text(":("),
                  ),
              newPageProgressIndicatorBuilder: (_) => Center(
                    child: CircularProgressIndicator(
                      color: Theme.of(context).primaryColor,
                      strokeWidth: 2,
                    ),
                  )),
          physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
        ),
      ),
    );
  }
}

class ChapterList extends StatelessWidget {
  final List<ChapterModel> chapters;
  final bool shrinkWrap;
  final Map<String, MangaModel>? mangas;
  const ChapterList(
      {Key? key,
      required this.chapters,
      required this.mangas,
      this.shrinkWrap = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: shrinkWrap,
      physics: shrinkWrap
          ? NeverScrollableScrollPhysics()
          : const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics()),
      itemCount: chapters.length,
      itemBuilder: (ctx, i) {
        var mangaId = chapters[i]
            .relationships
            .singleWhere((element) => element!['type'] == "manga")!['id'];

        var lastManga = chapters[max(i - 1, 0)]
            .relationships
            .singleWhere((element) => element!['type'] == "manga")!['id'];

        return MangaChapItem(
          manga: mangas?["$mangaId"],
          charItem: chapters[i],
          showChapLabel: i == 0 ||
              lastManga != mangaId ||
              chapters[i].data.attributes.chapter !=
                  chapters[i - 1].data.attributes.chapter,
          showHeader: !(i != 0 &&
              mangaId ==
                  chapters[i - 1].relationships.singleWhere(
                      (element) => element!['type'] == "manga")!['id']),
        );
      },
    );
  }
}

class MangaChapItem extends StatelessWidget {
  final MangaModel? manga;
  final ScanlationGroupDataModel? scan;

  final ChapterModel charItem;

  final bool showHeader;
  final bool showChapLabel;

  const MangaChapItem(
      {Key? key,
      required this.showHeader,
      required this.showChapLabel,
      required this.manga,
      required this.charItem,
      this.scan})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showHeader)
          ChapterMangaHeader(
            manga: manga,
          ),
        if (showHeader)
          SizedBox(
            height: 30,
          ),
        if (showChapLabel)
          Text(
            "Chapter ${charItem.data.attributes.chapter.toString()}",
            style: Theme.of(context).textTheme.caption,
          ),
        SizedBox(
          height: 15,
        ),
        ChapItem(
          scan: scan,
          popOnOpen: false,
          charItem: charItem,
          manga: manga,
          paddingBottom: 30,
        ),
      ],
    );
  }
}

class ChapterMangaHeader extends StatelessWidget {
  final MangaModel? manga;
  const ChapterMangaHeader({Key? key, required this.manga}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return manga == null
        ? LinearProgressIndicator()
        : GestureDetector(
            onTap: () => Navigator.of(context)
                .pushNamed(MangaPage.routeName, arguments: manga),
            child: Container(
              decoration: BoxDecoration(
                  border: Border(
                      top: BorderSide(
                          width: 1.0,
                          color: Theme.of(context)
                              .primaryColor
                              .withOpacity(0.3)))),
              padding: const EdgeInsets.only(top: 30),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: manga?.data.coverLink != null
                        ? Image.network(
                            manga?.data.coverLink ??
                                "https://placewaifu.com/image/100/100",
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            width: 40,
                            height: 40,
                            color: Colors.grey,
                          ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: Text(
                      manga?.data.attributes.title['en'] ?? "",
                      style: Theme.of(context).textTheme.headline3,
                      overflow: TextOverflow.fade,
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
