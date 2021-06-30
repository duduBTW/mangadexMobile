import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mangadex/components/shared/chapters/index.dart';
import 'package:mangadex/components/shared/manga/tags.dart';
import 'package:mangadex/pages/manga/index.dart';
import 'package:mangadex/service/manga/item.dart';
import 'package:mangadex/service/manga/model/index.dart';
import 'package:provider/provider.dart';

class MangaShow extends StatefulWidget {
  final MangaModel manga;
  const MangaShow(this.manga, {Key? key}) : super(key: key);

  @override
  _MangaShowState createState() => _MangaShowState();
}

class _MangaShowState extends State<MangaShow> {
  void _redirectToManga(context) {
    Navigator.of(context)
        .pushNamed(MangaPage.routeName, arguments: widget.manga);
  }

  bool open = false;

  void openChap() async {
    if (open) {
      setState(() {
        open = false;
      });
      return;
    }

    setState(() {
      open = true;
    });
    Provider.of<MangaItemController>(context, listen: false).manga =
        widget.manga;
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Column(
        children: [
          GestureDetector(
            onTap: () => _redirectToManga(context),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.circular(30),
                boxShadow: open
                    ? [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.15),
                          spreadRadius: 0,
                          blurRadius: 12,
                          offset: Offset(4, 4), // changes position of shadow
                        ),
                      ]
                    : null,
              ),
              padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.manga.data.attributes.title['en']!,
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
                              widget.manga.data.coverLink == "" ||
                                      widget.manga.data.coverLink == null
                                  ? "https://placewaifu.com/image/200/300"
                                  : widget.manga.data.coverLink,
                              fit: BoxFit.cover,
                              width: 120,
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
                                      child: MangaTags(manga: widget.manga),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  widget
                                      .manga.data.attributes.description['en']!,
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
                          border:
                              Border.all(color: Color(0xffDCFFDD), width: 2),
                        ),
                        width: 125,
                        child: Text(
                          widget.manga.data.attributes.status!,
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
                              Spacer(),
                              IconButton(
                                icon: open
                                    ? Icon(Icons.expand_less)
                                    : Icon(Icons.expand_more),
                                onPressed: openChap,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (open) ChaptersMangaItem(open: open),
        ],
      ),
    );
  }
}

class ChaptersMangaItem extends StatelessWidget {
  const ChaptersMangaItem({
    Key? key,
    required this.open,
  }) : super(key: key);

  final bool open;

  @override
  Widget build(BuildContext context) {
    var chapters = Provider.of<MangaItemController>(context).chaptersList;

    return Container(
      margin: EdgeInsets.all(15),
      child: chapters != null
          ? ListView.builder(
              primary: false,
              itemBuilder: (ctx, index) => Container(
                child: ChapManga(
                    label: chapters[index], compact: true, popOnOpen: false),
              ),
              itemCount: chapters.length,
            )
          : Center(child: CircularProgressIndicator()),
      height: 200,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(30),
              bottomLeft: Radius.circular(30))),
    );
  }
}
