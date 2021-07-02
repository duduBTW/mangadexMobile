import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mangadex/pages/reader/index.dart';
import 'package:mangadex/service/chapters/model/chapter/index.dart';
import 'package:mangadex/service/manga/item.dart';
import 'package:mangadex/service/manga/model/index.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class Chapters extends StatefulWidget {
  final ScrollController controller;
  const Chapters({Key? key, required this.controller}) : super(key: key);

  @override
  _ChaptersState createState() => _ChaptersState();
}

class _ChaptersState extends State<Chapters> {
  @override
  void initState() {
    super.initState();
    // Provider.of<MangaItemController>(context, listen: false).getChapters();
  }

  @override
  Widget build(BuildContext context) {
    final controller = widget.controller;
    var chaptersList = Provider.of<MangaItemController>(context).chaptersList;
    print(chaptersList);

    return Container(
      height: MediaQuery.of(context).size.height,
      child: NotificationListener<OverscrollNotification>(
        onNotification: (OverscrollNotification value) {
          print(value);
          if (value.overscroll < 0 &&
              controller.offset + value.overscroll <= 0) {
            if (controller.offset != 0)
              controller
                ..animateTo(
                  0.0,
                  curve: Curves.easeOut,
                  duration: const Duration(milliseconds: 100),
                );
            return true;
          }
          if (controller.offset + value.overscroll >=
              controller.position.maxScrollExtent) {
            if (controller.offset != controller.position.maxScrollExtent)
              controller
                ..animateTo(
                  controller.position.maxScrollExtent,
                  curve: Curves.easeOut,
                  duration: const Duration(milliseconds: 100),
                );
            return true;
          }
          if (!value.metrics.atEdge || value.metrics.pixels != 0) return true;

          controller
            ..animateTo(
              0,
              curve: Curves.easeOut,
              duration: const Duration(milliseconds: 400),
            );
          return true;
        },
        child: chaptersList.length == 0
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "((´д｀))",
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text("No chapters found"),
                ],
              )
            : chaptersList.length > 0
                ? ListView.builder(
                    primary: false,
                    // physics: const BouncingScrollPhysics(
                    //     parent: AlwaysScrollableScrollPhysics()),
                    itemBuilder: (ctx, index) => Container(
                      margin: EdgeInsets.only(
                          top: index == 0 ? 30 : 0,
                          bottom: index == chaptersList.length - 1
                              ? AppBar().preferredSize.height
                              : 0),
                      child: ChapManga(
                        label: chaptersList[index],
                      ),
                    ),
                    itemCount: chaptersList.length,
                  )
                : CircularProgressIndicator(),
      ),
    );
  }
}

class ChapManga extends StatelessWidget {
  final String label;
  final bool popOnOpen;
  final bool compact;
  const ChapManga(
      {Key? key,
      required this.label,
      this.popOnOpen = true,
      this.compact = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var charItems = Provider.of<MangaItemController>(context).chapter[label];
    return Container(
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.symmetric(
        horizontal: compact ? 15 : 30,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Theme.of(context).backgroundColor,
      ),
      child: Theme(
        data: ThemeData().copyWith(
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
            onExpansionChanged: (open) => {
                  if (open)
                    {
                      Provider.of<MangaItemController>(context, listen: false)
                          .getChapter(label)
                    }
                },
            tilePadding: EdgeInsets.all(0),
            iconColor: Theme.of(context).primaryColor,
            title: Container(
              child: Text(
                "Chapter $label",
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            backgroundColor: Theme.of(context).backgroundColor,
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              if (charItems != null)
                ...charItems
                    .map((charItem) => ChapItem(
                          popOnOpen: popOnOpen,
                          charItem: charItem,
                        ))
                    .toList()
              else
                LinearProgressIndicator(
                  minHeight: 2,
                  color: Theme.of(context).primaryColor,
                  backgroundColor: Colors.white,
                )
            ]),
      ),
    );
  }
}

class ChapItem extends StatelessWidget {
  final ChapterModel charItem;
  final MangaModel? manga;
  final double paddingBottom;
  const ChapItem({
    Key? key,
    required this.popOnOpen,
    required this.charItem,
    this.manga,
    this.paddingBottom = 30,
  }) : super(key: key);

  final bool popOnOpen;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (manga != null)
          Provider.of<MangaItemController>(context, listen: false).manga =
              manga;

        if (popOnOpen) {
          Navigator.of(context)
              .popAndPushNamed(MangaReaderPage.routeName, arguments: charItem);
        } else {
          Navigator.of(context)
              .pushNamed(MangaReaderPage.routeName, arguments: charItem);
        }
      },
      child: Container(
        color: Colors.transparent,
        padding: EdgeInsets.only(bottom: paddingBottom),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(
              "https://www.countryflags.io/${charItem.data.attributes.translatedLanguage!.split("-")[0] == "en" ? "gb" : charItem.data.attributes.translatedLanguage!.split("-")[0]}/flat/24.png",
              errorBuilder: (ctx, obj, err) => SizedBox(
                width: 20,
                child: Text(
                  charItem.data.attributes.translatedLanguage!.split("-")[0],
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
              width: 20,
            ),
            SizedBox(
              width: 15,
            ),
            // Image.network(
            //   "https://flagcdn.com/16x12/${charItem.attributes.translatedLanguage!.split("-")[0]}.png",
            //   width: 20,
            // ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Text(
                        charItem.data.attributes.title == null ||
                                charItem.data.attributes.title == ""
                            ? charItem.data.attributes.chapter ?? ""
                            : charItem.data.attributes.title ?? "",
                        style: GoogleFonts.rubik(
                            fontSize: 14, fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Scan Grup Name",
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              timeago
                  .format(DateTime.parse(charItem.data.attributes.publishAt)),
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      ),
    );
  }
}
