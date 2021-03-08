import 'package:flutter/material.dart';
import 'package:mangadex/components/mangaHeader/StatusItem.dart';

class InfoManga extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stats(),
          SizedBox(
            height: 20,
          ),
          Rating()
        ],
      ),
    );
  }
}

class Stats extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Stats", style: Theme.of(context).textTheme.headline4),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: StatusItem(
                label: "Views",
                value: "3,631,894",
              ),
              flex: 2,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: StatusItem(
                label: "Follows",
                value: "54,728",
              ),
              flex: 1,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: StatusItem(
                label: "Chapters",
                value: "172",
              ),
              flex: 1,
            ),
          ],
        ),
      ],
    );
  }
}

class Rating extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Rating", style: Theme.of(context).textTheme.headline4),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: StatusItem(
                label: "Note",
                value: "8.80",
              ),
              flex: 2,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: StatusItem(
                label: "Note v2",
                value: "8.82",
              ),
              flex: 1,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: StatusItem(
                label: "Votes",
                value: "3,748",
              ),
              flex: 1,
            ),
          ],
        ),
      ],
    );
  }
}
