import 'package:flutter/material.dart';
import 'package:mangadex/components/shared/chapters/index.dart';
import 'package:mangadex/pages/manga/index.dart';
import 'package:mangadex/service/chapters/model/chapter/index.dart';
import 'package:mangadex/service/manga/model/index.dart';
import 'package:mangadex/service/manga/user.dart';
import 'package:provider/provider.dart';

class FollowsChapters extends StatefulWidget {
  const FollowsChapters({Key? key}) : super(key: key);

  @override
  _FollowsChaptersState createState() => _FollowsChaptersState();
}

class _FollowsChaptersState extends State<FollowsChapters> {
  @override
  void initState() {
    super.initState();

    Provider.of<UserMangaController>(context, listen: false).fetchChapters();
  }

  @override
  Widget build(BuildContext context) {
    var chapters = Provider.of<UserMangaController>(context).userChapters;
    var userChaptersMangas =
        Provider.of<UserMangaController>(context).userChaptersMangas;

    return chapters == null
        ? Center(
            child: SizedBox(
            height: 22,
            width: 22,
            child: CircularProgressIndicator(),
          ))
        : Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: ChapterList(
              chapters: chapters,
              mangas: userChaptersMangas,
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
        var manga = chapters[i]
            .relationships
            .singleWhere((element) => element!['type'] == "manga")!['id'];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!(i != 0 &&
                manga ==
                    chapters[i - 1].relationships.singleWhere(
                        (element) => element!['type'] == "manga")!['id']))
              GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(
                    MangaPage.routeName,
                    arguments: mangas?["$manga"]),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                              width: 1.0,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.5)))),
                  padding: const EdgeInsets.only(top: 30),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.network(
                          mangas?["$manga"]?.data.coverLink ??
                              "https://placewaifu.com/image/100/100",
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Text(
                          mangas?["$manga"]?.data.attributes.title['en'] ?? "",
                          style: Theme.of(context).textTheme.headline3,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            if (!(i != 0 &&
                manga ==
                    chapters[i - 1].relationships.singleWhere(
                        (element) => element!['type'] == "manga")!['id']))
              SizedBox(
                height: 30,
              ),
            if (i == 0 ||
                chapters[i].data.attributes.chapter !=
                    chapters[i - 1].data.attributes.chapter)
              Text(
                "Chapter ${chapters[i].data.attributes.chapter.toString()}",
                style: Theme.of(context).textTheme.caption,
              ),
            SizedBox(
              height: 15,
            ),
            ChapItem(
              popOnOpen: false,
              charItem: chapters[i],
              manga: mangas?["$manga"],
            ),
          ],
        );
      },
    );
  }
}
