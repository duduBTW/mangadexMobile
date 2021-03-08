import 'package:flutter/material.dart';
import 'package:mangadex/components/ShowTitles/horizontalCards.dart';
import 'package:mangadex/components/latestUpdates/title.dart';

class ShowTitles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TitleUpdate("Featured titles"),
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: CardListHorizontal(),
        ),
        SizedBox(
          height: 40,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TitleUpdate("New titles"),
        ),
        SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: CardListHorizontal(),
        ),
        SizedBox(
          height: 50,
        ),
      ],
    );
  }
}
