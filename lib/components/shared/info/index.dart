import 'package:expandable_page_view/expandable_page_view.dart';
import 'package:flutter/material.dart';

class Info extends StatefulWidget {
  final List<Widget> splashData;
  final String title;

  const Info(this.splashData, this.title);
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        // height: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
              child: Text(
                widget.title,
                style: Theme.of(context).textTheme.headline1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30),
              child: ExpandablePageView(
                children: widget.splashData,
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
                        widget.splashData.length,
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
