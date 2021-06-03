import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';

class MangaInfo extends StatefulWidget {
  @override
  _MangaInfoState createState() => _MangaInfoState();
}

class _MangaInfoState extends State<MangaInfo> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    List<Widget> splashData = [
      Text(
        "A salary man is quite depressed, especially on Mondays. At his lowest point a well-endowed High-School girl calling herself Ai-chan stumbles breast-first into his face. The concussion she gave him served as the start of their relationship.",
        style: Theme.of(context).textTheme.bodyText1,
      ),
      Text(
        "A salary man is quite depressed, especially on Mondays. At his lowest point a well-endowed High-School girl calling herself Ai-chan stumbles breast-first into his face. The concussion she gave him served as the start of their relationship.\nA salary man is quite depressed, especially on Mondays. At his lowest point a well-endowed High-School girl calling herself Ai-chan stumbles breast-first into his face. The concussion she gave him served as the start of their relationship.",
        style: Theme.of(context).textTheme.bodyText1,
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
                "Getsuyoubi no Tawawa (Blue)",
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
