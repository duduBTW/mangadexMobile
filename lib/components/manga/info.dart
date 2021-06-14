import 'dart:math';

import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';
import 'package:mangadex/service/manga/model/index.dart';
import 'package:flutter/gestures.dart';

class MangaInfo extends StatefulWidget {
  final MangaModel manga;

  const MangaInfo({Key? key, required this.manga}) : super(key: key);

  @override
  _MangaInfoState createState() => _MangaInfoState();
}

class _MangaInfoState extends State<MangaInfo> {
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

    List<Widget> splashData = [
      RichText(
        text: TextSpan(
          text: showAll
              ? manga.data.attributes.description['en']!
              : manga.data.attributes.description['en']!.toString().substring(
                  0,
                  min(
                      manga.data.attributes.description['en']!
                          .toString()
                          .length,
                      350)),
          style: Theme.of(context).textTheme.bodyText1,
          children: [
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
      Text(
        "A salary man is quite depressed, especially on Mondays. At his lowest point a well-endowed High-School girl calling herself Ai-chan stumbles breast-first into his face. The concussion she gave him served as the start of their relationship.",
        style: Theme.of(context).textTheme.bodyText1,
      ),
    ];
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
            Padding(
              padding: const EdgeInsets.all(30),
              child: ExpandablePageView(
                children: splashData,
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
