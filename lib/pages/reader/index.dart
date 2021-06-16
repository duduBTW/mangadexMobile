import 'package:flutter/material.dart';
import 'package:mangadex/service/chapters/model/chapter/index.dart';
import 'package:mangadex/service/manga/item.dart';
import 'package:provider/provider.dart';

class MangaReaderPage extends StatefulWidget {
  static const routeName = '/manga/item/chapter';

  final ChapterModel chapter;
  const MangaReaderPage({Key? key, required this.chapter}) : super(key: key);

  @override
  _MangaReaderPageState createState() => _MangaReaderPageState();
}

class _MangaReaderPageState extends State<MangaReaderPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<MangaItemController>(context, listen: false)
        .updateServer(widget.chapter.id);
  }

  @override
  Widget build(BuildContext context) {
    var server = Provider.of<MangaItemController>(context).serverUrl;
    return server != null
        ? MangaReader(
            chapter: widget.chapter,
          )
        : SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(),
          );
  }
}

class MangaReader extends StatefulWidget {
  final ChapterModel chapter;
  const MangaReader({Key? key, required this.chapter}) : super(key: key);

  @override
  _MangaReaderState createState() => _MangaReaderState();
}

class _MangaReaderState extends State<MangaReader> {
  // final List<String> _images = [
  //   "https://images.catmanga.org/series/tawawa/chapters/1/001.jpg",
  //   "https://images.catmanga.org/series/tawawa/chapters/1/002.jpg",
  //   "https://images.catmanga.org/series/tawawa/chapters/1/003.png",
  //   "https://images.catmanga.org/series/tawawa/chapters/1/004.png",
  //   "https://images.catmanga.org/series/tawawa/chapters/1/005.png",
  //   "https://images.catmanga.org/series/tawawa/chapters/1/006.png",
  //   "https://images.catmanga.org/series/tawawa/chapters/1/007.png",
  //   "https://images.catmanga.org/series/tawawa/chapters/1/008.png",
  //   "https://images.catmanga.org/series/tawawa/chapters/1/009.png",
  //   "https://images.catmanga.org/series/tawawa/chapters/1/010.png",
  //   "https://images.catmanga.org/series/tawawa/chapters/1/011.png",
  //   "https://images.catmanga.org/series/tawawa/chapters/1/012.png",
  // ];
  final PageController _pageController = PageController();
  int currentPage = 0;
  bool open = false;
  final TransformationController _transformationController =
      TransformationController();
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

  /// Did Change Dependencies
  @override
  void didChangeDependencies() {
    try {
      for (var page in widget.chapter.attributes.data) {
        print(
            "${Provider.of<MangaItemController>(context, listen: false).serverUrl}/data/${widget.chapter.attributes.hash}/$page");
        if (page != null)
          precacheImage(
              new NetworkImage(
                  "${Provider.of<MangaItemController>(context, listen: false).serverUrl}/data/${widget.chapter.attributes.hash}/$page"),
              context);
      }
    } catch (e) {
      print(e);
    }
    super.didChangeDependencies();
  }

  @override
  void initState() {
    super.initState();

    _pageController.addListener(onPageChange);
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

    // Future.delayed(const Duration(milliseconds: 3000), () {
    //   setState(() {
    //     open = false;
    //   });
    // });
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
    print(widget.chapter.attributes.data.length);
    reset();
    if (details.globalPosition.dx < MediaQuery.of(context).size.width / 2) {
      if (currentPage != 0) {
        setState(() {
          currentPage = currentPage - 1;
        });
      }
    } else {
      if (currentPage + 1 < widget.chapter.attributes.data.length) {
        setState(() {
          currentPage = currentPage + 1;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var title = Provider.of<MangaItemController>(context)
            .manga
            ?.data
            .attributes
            .title['en'] ??
        "?";
    return GestureDetector(
      onDoubleTap: onTapScreen,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              // Container(
              //     height: MediaQuery.of(context).size.height,
              //     child: Container(
              //       child: PageView(
              //         controller: _pageController,
              //         children: [
              //           ..._images
              //               .map(
              //                 (page) => Container(
              //                   color: Colors.white,
              //                   child: Image.network(page),
              //                   alignment: Alignment(0, 0),
              //                 ),
              //               )
              //               .toList()

              //           // Container(
              //           //   color: Colors.blue,
              //           //   child: Image.asset("/manga/2.jpg"),
              //           // ),
              //         ],
              //       ),
              //     )),
              GestureDetector(
                onTapUp: _handleTapDown,
                child: InteractiveViewer(
                  transformationController: _transformationController,
                  minScale: 1,
                  maxScale: 3,
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    color: Colors.white,
                    child: Image.network(
                      "${Provider.of<MangaItemController>(context).serverUrl}/data/${widget.chapter.attributes.hash}/${widget.chapter.attributes.data[currentPage]}",
                      // loadingBuilder: (ctx, build, event) => SizedBox(
                      //   width: 22,
                      //   height: 22,
                      //   child: CircularProgressIndicator(),
                      // ),
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                    ),
                    alignment: Alignment(0, 0),
                  ),
                ),
              ),
              AnimatedPositioned(
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
                    child: Expanded(
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                title,
                                style: Theme.of(context).textTheme.subtitle2,
                                // maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                          Text(
                            "Chap. ${widget.chapter.attributes.chapter ?? "?"}",
                            style: Theme.of(context).textTheme.caption,
                          ),
                        ],
                      ),
                    ),
                  )),
              AnimatedPositioned(
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
                          reset();
                          if (currentPage != 0) {
                            setState(() {
                              currentPage = currentPage - 1;
                            });
                          }
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 12,
                        ),
                      ),
                      Text(
                          "${currentPage + 1}/${widget.chapter.attributes.data.length}"),
                      IconButton(
                        onPressed: () {
                          reset();
                          if (currentPage <
                              widget.chapter.attributes.data.length) {
                            setState(() {
                              currentPage = currentPage + 1;
                            });
                          }
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
