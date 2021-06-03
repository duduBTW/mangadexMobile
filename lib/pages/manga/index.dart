import 'package:flutter/material.dart';
import 'package:mangadex/components/manga/background.dart';
import 'package:mangadex/components/manga/header.dart';
import 'package:mangadex/components/manga/info.dart';
import 'package:mangadex/components/shared/chapters/index.dart';

class MangaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned(
              child: BackgroundImageManga(
                  "https://images.catmanga.org/series/tawawa/chapters/1/007.png"),
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
            ),
            Positioned(
              child: BackgroundGradientManga(),
              top: 0,
              left: 0,
              right: 0,
            ),
            Positioned(
              child: BackgroundManga(Theme.of(context).primaryColor),
              top: 141,
              left: 0,
              right: 0,
              bottom: 0,
            ),
            Positioned(
              child: BackgroundManga(Theme.of(context).accentColor),
              top: 145,
              left: 0,
              right: 0,
              bottom: 0,
            ),
            Column(
              children: [
                SizedBox(
                  height: 60,
                ),
                HeaderManga(),
                MangaInfo(),
                Chapters()
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
