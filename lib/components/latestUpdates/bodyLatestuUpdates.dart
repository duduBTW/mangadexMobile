import 'package:flutter/material.dart';
import 'package:mangadex/components/tabs/index.dart';

import 'list.dart';

class BodyLatestuUpdates extends StatefulWidget {
  @override
  _BodyLatestuUpdatesState createState() => _BodyLatestuUpdatesState();
}

class _BodyLatestuUpdatesState extends State<BodyLatestuUpdates> {
  List<String> _tabs = ["All", "Follows"];
  PageController _pageController;
  int _selectedPage = 0;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabsManga(
          tabs: _tabs,
          selectedPage: _selectedPage,
        ),
        SizedBox(
          height: 30,
        ),
        Expanded(
            child: PageView(
          onPageChanged: (int page) {
            setState(() {
              _selectedPage = page;
            });
          },
          controller: _pageController,
          children: [
            Container(
              child: ListMangasMain(),
            ),
            Container(
              child: ListMangasMain(),
            )
          ],
        ))
      ],
    );
  }
}
