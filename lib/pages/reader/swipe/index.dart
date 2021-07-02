import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mangadex/pages/reader/standard/index.dart';
import 'package:mangadex/service/chapters/model/chapter/index.dart';
import 'package:mangadex/service/manga/item.dart';
import 'package:provider/provider.dart';

import '../index.dart';

class SwipeStripReader extends StatefulWidget {
  final ChapterModel chapter;
  const SwipeStripReader({Key? key, required this.chapter}) : super(key: key);

  @override
  _SwipeStripReaderState createState() => _SwipeStripReaderState();
}

class _SwipeStripReaderState extends State<SwipeStripReader> {
  int currentPage = 0;
  final PageController _pageController = PageController();

  bool open = false;

  void onTapScreen() {
    setState(() {
      open = !open;
    });
  }

  @override
  void initState() {
    super.initState();
    // _pageController.addListener(onPageChange);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var title = Provider.of<MangaItemController>(context)
            .manga
            ?.data
            .attributes
            .title['en'] ??
        "?";

    return Stack(
      children: [
        GestureDetector(
          onDoubleTap: onTapScreen,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (newPge) {
                setState(() {
                  currentPage = newPge;
                });
              },
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemCount: widget.chapter.data.attributes.data.length,
              itemBuilder: (ctx, i) => CachedNetworkImage(
                key: UniqueKey(),
                imageUrl: widget.chapter.data.attributes.data[i] != null
                    ? "${Provider.of<MangaItemController>(context).serverUrl}/data/${widget.chapter.data.attributes.hash}/${widget.chapter.data.attributes.data[i]}"
                    : "https://images-cdn.9gag.com/photo/awAzB6D_700b.jpg",
                width: MediaQuery.of(context).size.width,
                progressIndicatorBuilder: (ctx, url, loadingProgress) {
                  // if (loadingProgress.totalSize == loadingProgress.downloaded)
                  //   return Container(
                  //     height: MediaQuery.of(context).size.height,
                  //     child: Center(
                  //       child: Icon(Icons.done),
                  //     ),
                  //   );

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
            ),
          ),
        ),
        HederMangaReader(
          open: open,
          title: title,
          chapter: widget.chapter,
        ),
        CurrentPageMangaReader(
          open: open,
          chapter: widget.chapter,
          currentPage: currentPage,
          nextPage: () {
            _pageController.jumpTo(10);
            // setState(() {
            //   currentPage = currentPage + 1;
            // });
          },
          previusPage: () {},
        )
      ],
    );
  }
}
