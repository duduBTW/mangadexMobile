import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mangadex/pages/configuration/reader/index.dart';
import 'package:mangadex/service/chapters/model/chapter/index.dart';
import 'package:mangadex/service/manga/item.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../index.dart';

class StandardMangaReader extends StatefulWidget {
  final ChapterModel chapter;
  const StandardMangaReader({Key? key, required this.chapter})
      : super(key: key);

  @override
  _StandardMangaReaderState createState() => _StandardMangaReaderState();
}

class _StandardMangaReaderState extends State<StandardMangaReader> {
  final PageController _pageController = PageController();
  static final storage = new FlutterSecureStorage();

  int currentPage = 0;
  bool open = false;

  final TransformationController _transformationController =
      TransformationController();

  @override
  void initState() {
    super.initState();

    Provider.of<MangaItemController>(context, listen: false).chapterReadingNow =
        widget.chapter.data.attributes.chapter!;
    _pageController.addListener(onPageChange);
  }

  void onPageChange() {
    // TODO

    // ( Ｄ
    //     　）
    // ( Ｄ

    // USE A DOUBLE AND SEE IF THE PAGE VALUE IS BIGGER THEN 50% OF THE PAGE
    if (_pageController.page?.toInt() != currentPage) {
      setState(() {
        currentPage = _pageController.page!.toInt();
      });
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onTapScreen() {
    setState(() {
      open = !open;
    });
  }

  void reset() {
    _transformationController.value = Matrix4(
      1,
      0,
      0,
      0,
      0,
      1,
      0,
      0,
      0,
      0,
      1,
      0,
      0,
      0,
      0,
      1,
    );
  }

  void _handleTapDown(TapUpDetails details) {
    print(currentPage);
    print(widget.chapter.data.attributes.data.length);
    reset();
    if (details.globalPosition.dx < MediaQuery.of(context).size.width / 2) {
      previusPage();
    } else {
      nextPage();
    }
  }

  void previusPage() {
    reset();

    if (currentPage != 0) {
      setState(() {
        currentPage = currentPage - 1;
      });
    }
  }

  void nextPage() {
    reset();
    if (currentPage < widget.chapter.data.attributes.data.length) {
      print(currentPage);
      print(widget.chapter.data.attributes.data.length);
      if (currentPage == widget.chapter.data.attributes.data.length - 2) {
        // get next charp data
        Provider.of<MangaItemController>(context, listen: false)
            .getNextChapter();
      }
      setState(() {
        currentPage = currentPage + 1;
      });

      if (currentPage == widget.chapter.data.attributes.data.length) {
        setState(() {
          open = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var zoom = Provider.of<MangaItemController>(context).zoom;
    var title = Provider.of<MangaItemController>(context)
            .manga
            ?.data
            .attributes
            .title['en'] ??
        "?";

    return Stack(
      children: [
        currentPage < widget.chapter.data.attributes.data.length
            ? GestureDetector(
                onDoubleTap: onTapScreen,
                onTapUp: _handleTapDown,
                child: InteractiveViewer(
                  scaleEnabled: zoom,
                  transformationController: _transformationController,
                  minScale: 1,
                  maxScale: 3,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    color: Colors.white,
                    child: CachedNetworkImage(
                      key: UniqueKey(),
                      imageUrl: widget
                                  .chapter.data.attributes.data[currentPage] !=
                              null
                          ? "${Provider.of<MangaItemController>(context).serverUrl}/data/${widget.chapter.data.attributes.hash}/${widget.chapter.data.attributes.data[currentPage]}"
                          : "https://images-cdn.9gag.com/photo/awAzB6D_700b.jpg",
                      width: MediaQuery.of(context).size.width,
                      progressIndicatorBuilder: (ctx, url, loadingProgress) {
                        // if (loadingProgress == null) return child;

                        return Container(
                          height: MediaQuery.of(context).size.height,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                              value: loadingProgress.progress,
                            ),
                          ),
                        );
                      },
                    ),
                    // child: Image.network(
                    //   "${Provider.of<MangaItemController>(context).serverUrl}/data/${widget.chapter.data.attributes.hash}/${widget.chapter.data.attributes.data[currentPage]}",
                    //   // loadingBuilder: (ctx, build, event) => SizedBox(
                    //   //   width: 22,
                    //   //   height: 22,
                    //   //   child: CircularProgressIndicator(),
                    //   // ),
                    //   loadingBuilder: (BuildContext context, Widget child,
                    //       ImageChunkEvent? loadingProgress) {
                    //     if (loadingProgress == null) return child;
                    //     return Center(
                    //       child: CircularProgressIndicator(
                    //         color: Theme.of(context).primaryColor,
                    //         value: loadingProgress.expectedTotalBytes != null
                    //             ? loadingProgress.cumulativeBytesLoaded /
                    //                 loadingProgress.expectedTotalBytes!
                    //             : null,
                    //       ),
                    //     );
                    //   },
                    // ),
                    alignment: Alignment(0, 0),
                  ),
                ),
              )
            : ChapFinished(),
        HederMangaReader(
          title: title,
          open: open,
          chapter: widget.chapter,
        ),
        CurrentPageMangaReader(
          open: open,
          chapter: widget.chapter,
          currentPage: currentPage,
          nextPage: nextPage,
          previusPage: previusPage,
        )
      ],
    );
  }
}

class CurrentPageMangaReader extends StatelessWidget {
  final bool open;
  final int currentPage;
  final ChapterModel chapter;
  final Function nextPage;
  final Function previusPage;

  const CurrentPageMangaReader(
      {Key? key,
      required this.open,
      required this.currentPage,
      required this.chapter,
      required this.nextPage,
      required this.previusPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 200),
      child: Container(
        // padding: EdgeInsets.symmetric(vertical: 20),
        color: Colors.white.withOpacity(0.8),
        // height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                previusPage();
              },
              icon: Icon(
                Icons.arrow_back_ios,
                size: 12,
              ),
            ),
            Text(
                "${min(currentPage + 1, chapter.data.attributes.data.length)}/${chapter.data.attributes.data.length}"),
            IconButton(
              onPressed: () {
                nextPage();
              },
              icon: Icon(
                Icons.arrow_forward_ios,
                size: 12,
              ),
            ),
          ],
        ),
      ),
      bottom: open ? 0 : -60,
      left: 0,
      right: 0,
    );
  }
}

class HederMangaReader extends StatelessWidget {
  const HederMangaReader({
    Key? key,
    required this.open,
    required this.title,
    required this.chapter,
  }) : super(key: key);

  final bool open;
  final String title;
  final ChapterModel chapter;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        top: open ? 10 : -60,
        left: 0,
        right: 0,
        height: 60,
        child: Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              color: Theme.of(context).accentColor.withOpacity(0.9),
              borderRadius: BorderRadius.circular(30)),
          alignment: Alignment(0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                padding: EdgeInsets.all(0),
                icon: Icon(
                  Icons.arrow_back,
                  color: Color(0xff3F0000),
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              Expanded(
                // width: MediaQuery.of(context).size.width / 1.75,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.subtitle2,
                    // maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Text(
                "Chap. ${chapter.data.attributes.chapter ?? "?"}",
                style: Theme.of(context).textTheme.caption,
              ),
              IconButton(
                  padding: EdgeInsets.all(0),
                  icon: Icon(
                    Icons.settings,
                    color: Color(0xff3F0000),
                    size: 20,
                  ),
                  onPressed: () => Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: MangaReaderConfiguration()))),
            ],
          ),
        ));
  }
}
