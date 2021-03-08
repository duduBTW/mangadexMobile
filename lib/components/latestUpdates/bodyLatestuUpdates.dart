import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
        Container(
          padding: EdgeInsets.symmetric(vertical: 14),
          margin: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                      color: Theme.of(context).primaryColor, width: 1))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ..._tabs.map((tab) {
                var index = _tabs.indexOf(tab);

                return TabItem(tab, _selectedPage, index);
              }).toList()
            ],
          ),
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

class TabItem extends StatelessWidget {
  final String _tabText;
  final int _selectedPage;
  final int _index;

  const TabItem(this._tabText, this._selectedPage, this._index);
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      child: Text(
        _tabText,
        style: GoogleFonts.rubik(
          textStyle: Theme.of(context).textTheme.headline2,
          color: _selectedPage == _index ? Colors.white : Color(0xfff949494),
          fontSize: 16,
          fontWeight:
              _selectedPage == _index ? FontWeight.w600 : FontWeight.w400,
        ),
      ),
    );
  }
}
