import 'package:flutter/material.dart';
import 'package:mangadex/components/latestUpdates/horizontalCards.dart';

import './title.dart';
import './bodyLatestuUpdates.dart';

class LatestuUpdates extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 50,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: TitleUpdate("Latest updates"),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          child: BodyLatestuUpdates(),
          height: 440,
        ),
        SizedBox(
          height: 40,
        ),
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
