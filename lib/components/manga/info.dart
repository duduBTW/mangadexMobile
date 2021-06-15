import 'dart:math';

import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:mangadex/service/cover/model/index.dart';
import 'package:mangadex/service/manga/item.dart';
import 'package:mangadex/service/manga/model/index.dart';
import 'package:flutter/gestures.dart';
import 'package:provider/provider.dart';

class MangaInfo extends StatefulWidget {
  final MangaModel manga;

  const MangaInfo({Key? key, required this.manga}) : super(key: key);

  @override
  _MangaInfoState createState() => _MangaInfoState();
}

class _MangaInfoState extends State<MangaInfo> {
  static const int DESC_MAX_LENGTH = 350;

  int currentPage = 0;
  bool showAll = false;

  void changeShow() {
    print("a");
    setState(() {
      showAll = !showAll;
    });
  }

  @override
  Widget build(BuildContext context) {
    var manga = widget.manga;
    var desc = manga.data.attributes.description['en']!;

    List<Widget> splashData = [
      RichText(
        text: TextSpan(
          text: showAll
              ? desc
              : desc
                  .toString()
                  .substring(0, min(desc.toString().length, DESC_MAX_LENGTH)),
          style: Theme.of(context).textTheme.bodyText1,
          children: [
            if (desc.length > DESC_MAX_LENGTH)
              TextSpan(
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      changeShow();
                      // Single tapped.
                    },
                  text: showAll ? ' Read less...' : ' ...Read more',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor)),
          ],
        ),
      ),
      MangaArts(),
    ];
    print(splashData.length);
    return IntrinsicHeight(
      child: Container(
        // height: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
              child: Text(
                manga.data.attributes.title['en']!,
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            ExpandablePageView(
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              itemCount: manga.data.attributes.altTitles.length,
              itemBuilder: (ctx, index) => Padding(
                padding: const EdgeInsets.only(
                    top: 10, right: 30, left: 30, bottom: 30),
                child: Text(
                  manga.data.attributes.altTitles[index]['en']!,
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 0, bottom: 30, right: 30, left: 30),
              child: ExpandablePageView(
                itemCount: splashData.length,
                itemBuilder: (ctx, index) => splashData[index],
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                onPageChanged: (newIndex) {
                  setState(() {
                    currentPage = newIndex;
                  });
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashData.length,
                        (index) => buildDot(index: index),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            )
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({int index = 0}) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.only(right: 8),
      height: 8,
      width: currentPage == index ? 22 : 8,
      decoration: BoxDecoration(
        color: currentPage == index
            ? Theme.of(context).primaryColor
            : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

class MangaArts extends StatefulWidget {
  const MangaArts({Key? key}) : super(key: key);

  @override
  _MangaArtsState createState() => _MangaArtsState();
}

class _MangaArtsState extends State<MangaArts> {
  @override
  void initState() {
    super.initState();
    Provider.of<MangaItemController>(context, listen: false).updateCovers();
  }

  @override
  Widget build(BuildContext context) {
    var _covers = Provider.of<MangaItemController>(context).covers;
    var _mangaId = Provider.of<MangaItemController>(context).manga?.data.id;

    return Container(
      height: _covers == null || _covers.length <= 2
          ? MediaQuery.of(context).size.width * (2 / 3) - 15
          : (MediaQuery.of(context).size.width * (2 / 3)) + 50,
      // padding: EdgeInsets.all(30),
      child: _covers != null
          ? GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2 / 3,
                  mainAxisSpacing: 15,
                  crossAxisSpacing: 15),
              physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()),
              scrollDirection: Axis.vertical,
              itemCount: _covers.length,
              itemBuilder: (ctx, i) => Stack(
                children: [
                  Positioned(
                      bottom: 0,
                      top: 0,
                      right: 0,
                      left: 0,
                      child: Center(
                        child: SizedBox(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                            strokeWidth: 2,
                          ),
                          width: 32,
                          height: 32,
                        ),
                      )),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            "https://uploads.mangadex.org/covers/$_mangaId/${_covers[i].data.attributes.fileName}.512.jpg",
                          )),
                    ),
                  ),
                  // Expanded(
                  //   child: ClipRRect(
                  //     borderRadius: BorderRadius.circular(15),
                  //     child: Image.network(
                  //       "https://uploads.mangadex.org/covers/$_mangaId/${_covers[i].data.attributes.fileName}.512.jpg",
                  //       fit: BoxFit.cover,
                  //     ),
                  //   ),
                  // ),
                  Positioned(
                      bottom: 0,
                      top: 0,
                      right: 0,
                      left: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          gradient: LinearGradient(
                            begin: Alignment.bottomLeft,
                            end: Alignment(0.6,
                                0.0), // 10% of the width, so there are ten blinds.
                            colors: <Color>[
                              Colors.black.withOpacity(0.5),
                              Colors.transparent,
                            ], // red to yellow
                          ),
                        ),
                      )),

                  Positioned(
                    child: Text(
                      "Vol. ${_covers[i].data.attributes.volume ?? "Actual"}",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                    bottom: 15,
                    left: 15,
                  ),
                ],
              ),
            )
          : SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(),
            ),
    );
  }
}
