import 'package:flutter/material.dart';

import 'item.dart';

class TabsManga extends StatelessWidget {
  final List<String> tabs;
  final int selectedPage;

  const TabsManga({Key key, @required this.tabs, this.selectedPage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 14),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          border: Border(
              bottom:
                  BorderSide(color: Theme.of(context).primaryColor, width: 1))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ...tabs.map((tab) {
            var index = tabs.indexOf(tab);

            return TabItem(tab, selectedPage, index);
          }).toList()
        ],
      ),
    );
  }
}
