import 'package:flutter/material.dart';

class MangaReader extends StatefulWidget {
  const MangaReader({Key? key}) : super(key: key);

  @override
  _MangaReaderState createState() => _MangaReaderState();
}

class _MangaReaderState extends State<MangaReader> {
  final List<String> _images = [
    "https://images.catmanga.org/series/tawawa/chapters/1/001.jpg",
    "https://images.catmanga.org/series/tawawa/chapters/1/002.jpg",
    "https://images.catmanga.org/series/tawawa/chapters/1/003.png",
    "https://images.catmanga.org/series/tawawa/chapters/1/004.png",
    "https://images.catmanga.org/series/tawawa/chapters/1/005.png",
    "https://images.catmanga.org/series/tawawa/chapters/1/006.png",
    "https://images.catmanga.org/series/tawawa/chapters/1/007.png",
    "https://images.catmanga.org/series/tawawa/chapters/1/008.png",
    "https://images.catmanga.org/series/tawawa/chapters/1/009.png",
    "https://images.catmanga.org/series/tawawa/chapters/1/010.png",
    "https://images.catmanga.org/series/tawawa/chapters/1/011.png",
    "https://images.catmanga.org/series/tawawa/chapters/1/012.png",
  ];
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

  @override
  void initState() {
    super.initState();

    _pageController.addListener(onPageChange);
    load();
  }

  void load() {
    try {
      for (var page in _images) {
        precacheImage(new NetworkImage(page), context);
      }
    } catch (e) {
      print(e);
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

  @override
  Widget build(BuildContext context) {
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

              InteractiveViewer(
                transformationController: _transformationController,
                minScale: 1,
                maxScale: 3,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  color: Colors.white,
                  child: Image.network(_images[currentPage]),
                  alignment: Alignment(0, 0),
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
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    decoration: BoxDecoration(
                        color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(30)),
                    alignment: Alignment(0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Color(0xff3F0000),
                          ),
                          onPressed: () {},
                        ),
                        Text(
                          "Getsuyoubi no Tawawa (Blue)",
                          // style: Theme.of(context).textTheme.headline3,
                        ),
                      ],
                    ),
                  )),
              AnimatedPositioned(
                duration: Duration(milliseconds: 200),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  color: Colors.white.withOpacity(0.8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          reset();
                          setState(() {
                            currentPage = currentPage - 1;
                          });
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 12,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text("${currentPage + 1}/${_images.length}"),
                      SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          reset();
                          setState(() {
                            currentPage = currentPage + 1;
                          });
                        },
                        child: Icon(
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
