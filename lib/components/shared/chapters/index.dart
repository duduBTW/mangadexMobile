import 'package:flutter/material.dart';

class Chapters extends StatelessWidget {
  const Chapters({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: Text(
              "Chapters",
              style: Theme.of(context).textTheme.headline3,
            ),
          ),
          ChapManga(),
          SizedBox(
            height: 15,
          ),
          ChapManga(),
          SizedBox(
            height: 15,
          ),
          ChapManga(),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }
}

class ChapManga extends StatelessWidget {
  const ChapManga({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      decoration: BoxDecoration(color: Theme.of(context).backgroundColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Title"),
          Text("16 hrs"),
        ],
      ),
    );
  }
}
