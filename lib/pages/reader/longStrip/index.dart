import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:mangadex/pages/reader/standard/index.dart';
import 'package:mangadex/service/chapters/model/chapter/index.dart';
import 'package:mangadex/service/manga/item.dart';
import 'package:provider/provider.dart';

import 'package:visibility_detector/visibility_detector.dart';

class LongStripReader extends StatefulWidget {
  final ChapterModel chapter;
  const LongStripReader({Key? key, required this.chapter}) : super(key: key);

  @override
  _LongStripReaderState createState() => _LongStripReaderState();
}

class _LongStripReaderState extends State<LongStripReader> {
  // get currentPage => 1;
  // static final customCache = CacheManager(Config(
  //   '',

  // ));
  int currentPage = 0;

  bool open = false;

  void onTapScreen() {
    setState(() {
      open = !open;
    });
  }

  @override
  void initState() {
    super.initState();
    Provider.of<MangaItemController>(context, listen: false).getNextChapter();
  }

  void onVisibilityChanged(VisibilityInfo visibilityInfo, int i) {
    var visiblePercentage = visibilityInfo.visibleFraction * 100;
    // print(visibilityInfo.visibleBounds);

    // print(int.parse(visibilityInfo.key.toString()));

    if (visiblePercentage == 100 && currentPage != i) {
      //the magic is done here
      //
      setState(() {
        currentPage = i;
      });
    }
    debugPrint('Widget ${visibilityInfo.key} is ${visiblePercentage}% visible');
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
        GestureDetector(
          onDoubleTap: onTapScreen,
          child: InteractiveViewer(
            scaleEnabled: zoom,
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                itemCount: widget.chapter.data.attributes.data.length,
                itemBuilder: (ctx, i) => VisibilityDetector(
                  key: Key(i.toString()),
                  onVisibilityChanged: (v) => onVisibilityChanged(v, i),
                  child: CachedNetworkImage(
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.red, BlendMode.colorBurn)),
                      ),
                    ),
                    key: UniqueKey(),
                    imageUrl: widget.chapter.data.attributes.data[i] != null
                        ? "${Provider.of<MangaItemController>(context).serverUrl}/data/${widget.chapter.data.attributes.hash}/${widget.chapter.data.attributes.data[i]}"
                        : "https://images-cdn.9gag.com/photo/awAzB6D_700b.jpg",
                    width: MediaQuery.of(context).size.width,
                    progressIndicatorBuilder: (ctx, url, loadingProgress) {
                      if (loadingProgress.totalSize ==
                          loadingProgress.downloaded) print(i);

                      return Container(
                        height: MediaQuery.of(context).size.height * 0.75,
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
          nextPage: () {},
          previusPage: () {},
        )
      ],
    );
  }
}
