import 'package:flutter/material.dart';
import 'package:mangadex/components/shared/manga/item.dart';
import 'package:mangadex/components/shared/title/index.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
            padding: EdgeInsets.all(30),
            child: Column(
              children: [
                TitleHeader("Follows"),
                SizedBox(
                  height: 30,
                ),
                MangaMainItem(),
                SizedBox(
                  height: 30,
                ),
                MangaMainItem(),
                SizedBox(
                  height: 30,
                ),
                MangaMainItem(),
                SizedBox(
                  height: 30,
                ),
                TextButton(
                  child: Text(
                    "See all",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {},
                ),
                SizedBox(
                  height: 30,
                ),
                TitleHeader("Follows"),
                SizedBox(
                  height: 30,
                ),
                MangaMainItem(),
                SizedBox(
                  height: 30,
                ),
                MangaMainItem(),
                SizedBox(
                  height: 30,
                ),
                MangaMainItem(),
                SizedBox(
                  height: 30,
                ),
                TextButton(
                  child: Text(
                    "See all",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {},
                ),
              ],
            )),
      ),
    );
  }
}
