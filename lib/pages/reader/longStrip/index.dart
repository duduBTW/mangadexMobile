import 'package:flutter/material.dart';
import 'package:mangadex/pages/reader/standard/index.dart';
import 'package:mangadex/service/chapters/model/chapter/index.dart';
import 'package:mangadex/service/manga/item.dart';
import 'package:provider/provider.dart';

import '../index.dart';

class LongStripReader extends StatefulWidget {
  final ChapterModel chapter;
  const LongStripReader({Key? key, required this.chapter}) : super(key: key);

  @override
  _LongStripReaderState createState() => _LongStripReaderState();
}

class _LongStripReaderState extends State<LongStripReader> {
  get currentPage => null;

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
        SingleChildScrollView(
            child: GestureDetector(
          onDoubleTap: onTapScreen,
          child: Container(
            child: Column(
              children: [
                ...widget.chapter.data.attributes.data
                    .map((page) => Container(
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white,
                          child: Image.network(
                            page != null
                                ? "${Provider.of<MangaItemController>(context).serverUrl}/data/${widget.chapter.data.attributes.hash}/$page"
                                : "https://images-cdn.9gag.com/photo/awAzB6D_700b.jpg",
                            loadingBuilder: (BuildContext context, Widget child,
                                ImageChunkEvent? loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                height: MediaQuery.of(context).size.height,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    color: Theme.of(context).primaryColor,
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                  ),
                                ),
                              );
                            },
                          ),
                          alignment: Alignment(0, 0),
                        ))
                    .toList(),
                ChapFinished()
              ],
            ),
          ),
        )),
        HederMangaReader(
          open: open,
          title: title,
          chapter: widget.chapter,
        ),
      ],
    );
  }
}
