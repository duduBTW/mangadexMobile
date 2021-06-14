import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mangadex/pages/manga/index.dart';
import 'package:mangadex/service/manga/model/index.dart';

class MangaShow extends StatelessWidget {
  final MangaModel manga;
  const MangaShow(this.manga, {Key? key}) : super(key: key);

  void _redirectToManga(context) {
    Navigator.of(context).pushNamed(MangaPage.routeName, arguments: manga);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _redirectToManga(context),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).accentColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(30),
        ),
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
        margin: EdgeInsets.only(bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              manga.data.attributes.title['en']!,
              style: Theme.of(context).textTheme.headline3,
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 175,
              child: Row(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      clipBehavior: Clip.antiAlias,
                      child: Image.network(
                        manga.data.coverLink == "" ||
                                manga.data.coverLink == null
                            ? "https://placewaifu.com/image/200/300"
                            : manga.data.coverLink,
                        fit: BoxFit.cover,
                        width: 125,
                        height: 200,
                      )),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Container(
                                height: 22,
                                child: MangaTags(manga: manga),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            manga.data.attributes.description['en']!,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 14, height: 1.25),
                          ),
                          Spacer(),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.star_outline,
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.5),
                                    size: 18,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("N\A"),
                                ],
                              ),
                              Spacer(),
                              Row(
                                children: [
                                  Icon(
                                    Icons.bookmark_outline,
                                    color: Theme.of(context)
                                        .primaryColor
                                        .withOpacity(0.5),
                                    size: 18,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text("N\A"),
                                ],
                              ),
                              Spacer()
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(vertical: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                    border: Border.all(color: Color(0xffDCFFDD), width: 2),
                  ),
                  width: 125,
                  child: Text(
                    manga.data.attributes.status!,
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                        fontSize: 12),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.remove_red_eye_outlined,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.5),
                              size: 18,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text("N\A"),
                          ],
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Icon(
                              Icons.mode_comment_outlined,
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.5),
                              size: 18,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "N\A",
                            ),
                          ],
                        ),
                        Spacer()
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MangaTags extends StatelessWidget {
  const MangaTags({
    Key? key,
    required this.manga,
  }) : super(key: key);

  final MangaModel manga;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: manga.data.attributes.tags.length,
      physics:
          const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      scrollDirection: Axis.horizontal,
      itemBuilder: (ctx, index) {
        return Container(
            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 15),
            child: Text(
                manga.data.attributes.tags[index]['attributes']['name']['en'],
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1,
                    fontSize: 12)),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                    color: Theme.of(context).primaryColor.withOpacity(0.5))));
      },
      separatorBuilder: (ctx, index) => SizedBox(
        width: 5,
      ),
    );
  }
}
