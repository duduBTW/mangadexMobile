import 'package:flutter/material.dart';
import 'package:mangadex/components/readingHistory/readingHistory.dart';
import 'package:mangadex/components/latestUpdates/title.dart';

class ReadingHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TitleUpdate("Reading history"),
        ),
        SizedBox(
          height: 30,
        ),
        Container(
          height: 240,
          // padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ListHistory(),
        ),
        SizedBox(
          height: 40,
        ),
      ],
    );
  }
}
